import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/block_list.dart';
import '../models/focus_label.dart';
import '../models/focus_session.dart';
import '../services/focus_repository.dart';
import '../state/auth.dart';
import 'repository.dart';

final focusRepositoryProvider = Provider<FocusRepository>((ref) {
  final auth = ref.watch(authProvider);
  if (!auth.isLoggedIn) return const UnloadedFocusRepository();

  final repository = FirestoreFocusRepository(auth.userId!);
  ref.onDispose(repository.dispose);
  return repository;
});

class UnloadedFocusRepository extends FocusRepository {
  const UnloadedFocusRepository();

  @override
  bool get hasLoaded => false;

  @override
  List<BlockList> readLists() => const [];

  @override
  List<FocusSession> readSessions() => const [];

  @override
  List<FocusLabel> readLabels() => const [];

  @override
  Future<void> writeLists(List<BlockList> lists) async {}

  @override
  Future<void> writeSessions(List<FocusSession> sessions) async {}

  @override
  Future<void> writeLabels(List<FocusLabel> labels) async {}
}

class FirestoreFocusRepository extends Repository implements FocusRepository {
  FirestoreFocusRepository(this.userId) {
    _listenLists();
    _listenSessions();
    _listenLabels();
  }

  final String userId;

  final _changes = StreamController<void>.broadcast();
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _listsSub;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _sessionsSub;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _labelsSub;

  var _lists = const <BlockList>[];
  var _sessions = const <FocusSession>[];
  var _labels = const <FocusLabel>[];
  var _listsReady = false;
  var _sessionsReady = false;
  var _labelsReady = false;
  var _listsRetried = false;
  var _sessionsRetried = false;
  var _labelsRetried = false;
  var _listWrites = 0;
  var _sessionWrites = 0;
  var _labelWrites = 0;
  var _pending = false;
  var _disposed = false;
  Future<void> _tail = Future<void>.value();

  bool get _writing =>
      _listWrites > 0 || _sessionWrites > 0 || _labelWrites > 0;

  DocumentReference<Map<String, dynamic>> get _user =>
      firestore.collection(usersCollection).doc(userId);

  @override
  bool get hasLoaded => _listsReady && _sessionsReady && _labelsReady;

  @override
  Stream<void> get changes => _changes.stream;

  @override
  List<BlockList> readLists() => List.unmodifiable(_lists);

  @override
  List<FocusSession> readSessions() => List.unmodifiable(_sessions);

  @override
  List<FocusLabel> readLabels() => List.unmodifiable(_labels);

  @override
  Future<void> writeLists(List<BlockList> lists) {
    return _enqueue(() async {
      _lists = List.of(lists);
      _listWrites++;
      try {
        await _commit(_user.collection(blockListsCollection), {
          for (final list in lists) list.id: list.toJson(),
        });
      } finally {
        _listWrites--;
        _flush();
      }
    });
  }

  @override
  Future<void> writeSessions(List<FocusSession> sessions) {
    final trimmed = trimSessions(sessions);
    return _enqueue(() async {
      _sessions = List.of(trimmed);
      _sessionWrites++;
      try {
        await _commit(_user.collection(sessionsCollection), {
          for (final session in trimmed) session.id: session.toJson(),
        });
      } finally {
        _sessionWrites--;
        _flush();
      }
    });
  }

  @override
  Future<void> writeLabels(List<FocusLabel> labels) {
    return _enqueue(() async {
      _labels = List.of(labels);
      _labelWrites++;
      try {
        await _commit(_user.collection(labelsCollection), {
          for (final label in labels) label.id: label.toJson(),
        });
      } finally {
        _labelWrites--;
        _flush();
      }
    });
  }

  @override
  void dispose() {
    _disposed = true;
    _listsSub?.cancel();
    _sessionsSub?.cancel();
    _labelsSub?.cancel();
    _changes.close();
  }

  void _listenLists() {
    _listsSub?.cancel();
    _listsSub = _user
        .collection(blockListsCollection)
        .snapshots()
        .listen(
          (snapshot) {
            _listsReady = true;
            if (_listWrites > 0) {
              _pending = true;
              return;
            }
            _lists = _listsFrom(snapshot);
            _publish();
          },
          onError: (Object error, StackTrace stack) {
            debugPrint('Block list snapshots failed: $error\n$stack');
            if (_listsRetried || _disposed) return;
            _listsRetried = true;
            Future.delayed(const Duration(milliseconds: 600), () {
              if (!_disposed) _listenLists();
            });
          },
        );
  }

  void _listenSessions() {
    _sessionsSub?.cancel();
    _sessionsSub = _user
        .collection(sessionsCollection)
        .snapshots()
        .listen(
          (snapshot) {
            _sessionsReady = true;
            if (_sessionWrites > 0) {
              _pending = true;
              return;
            }
            _sessions = _sessionsFrom(snapshot);
            _publish();
          },
          onError: (Object error, StackTrace stack) {
            debugPrint('Session snapshots failed: $error\n$stack');
            if (_sessionsRetried || _disposed) return;
            _sessionsRetried = true;
            Future.delayed(const Duration(milliseconds: 600), () {
              if (!_disposed) _listenSessions();
            });
          },
        );
  }

  void _listenLabels() {
    _labelsSub?.cancel();
    _labelsSub = _user
        .collection(labelsCollection)
        .snapshots()
        .listen(
          (snapshot) {
            _labelsReady = true;
            if (_labelWrites > 0) {
              _pending = true;
              return;
            }
            _labels = _labelsFrom(snapshot);
            _publish();
          },
          onError: (Object error, StackTrace stack) {
            debugPrint('Label snapshots failed: $error\n$stack');
            if (_labelsRetried || _disposed) return;
            _labelsRetried = true;
            Future.delayed(const Duration(milliseconds: 600), () {
              if (!_disposed) _listenLabels();
            });
          },
        );
  }

  Future<void> _commit(
    CollectionReference<Map<String, dynamic>> collection,
    Map<String, Map<String, dynamic>> documents,
  ) async {
    final existing = await collection.get();
    final batch = firestore.batch();
    var writes = 0;
    for (final doc in existing.docs) {
      if (documents.containsKey(doc.id)) continue;
      batch.delete(doc.reference);
      writes++;
    }
    for (final entry in documents.entries) {
      batch.set(collection.doc(entry.key), entry.value);
      writes++;
    }
    if (writes == 0) return;
    await batch.commit();
  }

  Future<void> _enqueue(Future<void> Function() action) {
    final run = _tail.then((_) => action());
    _tail = run.then((_) {}, onError: (_) {});
    return run;
  }

  void _flush() {
    if (_writing || !_pending || !hasLoaded) return;
    _pending = false;
    _emit();
  }

  void _publish() {
    if (!hasLoaded) return;
    if (_writing) {
      _pending = true;
      return;
    }
    _emit();
  }

  void _emit() {
    if (!_disposed && !_changes.isClosed) _changes.add(null);
  }
}

List<BlockList> _listsFrom(QuerySnapshot<Map<String, dynamic>> snapshot) {
  final lists = <BlockList>[];
  for (final doc in snapshot.docs) {
    try {
      lists.add(BlockList.fromJson({...doc.data(), 'id': doc.id}));
    } catch (error, stack) {
      debugPrint('Skipping block list ${doc.id}: $error\n$stack');
    }
  }
  lists.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  return lists;
}

List<FocusLabel> _labelsFrom(QuerySnapshot<Map<String, dynamic>> snapshot) {
  final labels = <FocusLabel>[];
  for (final doc in snapshot.docs) {
    try {
      labels.add(FocusLabel.fromJson({...doc.data(), 'id': doc.id}));
    } catch (error, stack) {
      debugPrint('Skipping label ${doc.id}: $error\n$stack');
    }
  }
  labels.sort((a, b) => a.createdAt.compareTo(b.createdAt));
  return labels;
}

List<FocusSession> _sessionsFrom(QuerySnapshot<Map<String, dynamic>> snapshot) {
  final sessions = <FocusSession>[];
  for (final doc in snapshot.docs) {
    try {
      sessions.add(FocusSession.fromJson({...doc.data(), 'id': doc.id}));
    } catch (error, stack) {
      debugPrint('Skipping session ${doc.id}: $error\n$stack');
    }
  }
  sessions.sort((a, b) {
    final byStart = a.startedAt.compareTo(b.startedAt);
    if (byStart != 0) return byStart;
    return a.id.compareTo(b.id);
  });
  return sessions;
}
