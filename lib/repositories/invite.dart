import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/session_chat.dart';
import '../models/shared_session.dart';
import '../state/auth.dart';
import 'repository.dart';

const _uuid = Uuid();

final inviteRepositoryProvider = Provider<InviteRepository?>((ref) {
  final auth = ref.watch(authProvider);
  if (!auth.isLoggedIn) return null;
  return InviteRepository(auth.userId!);
});

final sharedSessionProvider = StreamProvider.family<SharedSession?, String>((
  ref,
  sessionId,
) {
  final repository = ref.watch(inviteRepositoryProvider);
  if (repository == null || sessionId.isEmpty) {
    return const Stream<SharedSession?>.empty();
  }
  return repository.watchSession(sessionId);
});

final participantsProvider =
    StreamProvider.family<List<SessionParticipant>, String>((ref, sessionId) {
      final repository = ref.watch(inviteRepositoryProvider);
      if (repository == null || sessionId.isEmpty) {
        return const Stream<List<SessionParticipant>>.empty();
      }
      return repository.watchParticipants(sessionId);
    });

/// Messages for one room. Watched only while the chat page is open, so a
/// closed chat does not read this document.
final sessionChatProvider = StreamProvider.autoDispose
    .family<List<SessionChatMessage>, String>((ref, sessionId) {
      final repository = ref.watch(inviteRepositoryProvider);
      if (repository == null || sessionId.isEmpty) {
        return Stream.value(const <SessionChatMessage>[]);
      }
      return repository.watchChat(sessionId);
    });

final pauseRequestProvider = StreamProvider.family<PauseRequest?, String>((
  ref,
  sessionId,
) {
  final repository = ref.watch(inviteRepositoryProvider);
  if (repository == null || sessionId.isEmpty) {
    return const Stream<PauseRequest?>.empty();
  }
  return repository.watchPauseRequest(sessionId);
});

class InviteRepository extends Repository {
  InviteRepository(this.userId);

  final String userId;

  DocumentReference<Map<String, dynamic>> _session(String sessionId) {
    return firestore.collection(sessionsCollection).doc(sessionId);
  }

  DocumentReference<Map<String, dynamic>> _invite(String code) {
    return firestore.collection(invitationsCollection).doc(code);
  }

  /// Creates the shared room, the invite, and the host as a participant.
  Future<CreatedInvite> create({
    required String hostName,
    required String username,
    required String title,
    required String? labelEmoji,
    required int? durationMinutes,
    required SharedSessionStatus status,
    required DateTime? startedAt,
    required DateTime? endsAt,
    required DateTime expiresAt,
    required bool chatEnabled,
  }) async {
    final sessionId = _uuid.v4().replaceAll('-', '');
    final code = _uuid.v4().replaceAll('-', '');
    final session = _session(sessionId);
    final invite = _invite(code);
    final participant = session.collection(participantsCollection).doc(userId);
    final batch = firestore.batch();
    batch.set(session, {
      'hostId': userId,
      'hostName': hostName,
      'title': title,
      'labelEmoji': labelEmoji,
      'durationMinutes': durationMinutes,
      'status': status.name,
      'startedAt': _time(startedAt),
      'endsAt': _time(endsAt),
      'createdAt': FieldValue.serverTimestamp(),
      'expiresAt': Timestamp.fromDate(expiresAt),
      'chatEnabled': chatEnabled,
    });
    batch.set(invite, {
      'sessionId': sessionId,
      'createdBy': userId,
      'hostName': hostName,
      'title': title,
      'labelEmoji': labelEmoji,
      'durationMinutes': durationMinutes,
      'createdAt': FieldValue.serverTimestamp(),
      'expiresAt': Timestamp.fromDate(expiresAt),
      'revoked': false,
    });
    batch.set(participant, {
      'uid': userId,
      'name': hostName,
      'username': username,
      'joinedAt': FieldValue.serverTimestamp(),
      'inviteCode': code,
    });
    await batch.commit();
    return CreatedInvite(sessionId: sessionId, code: code);
  }

  Future<SessionInvite?> fetchInvite(String code) async {
    if (!validInviteCode(code)) return null;
    final snapshot = await _invite(code).get();
    if (!snapshot.exists) return null;
    final data = snapshot.data();
    if (data == null) return null;
    return _inviteFrom(code, data);
  }

  /// Null when this account cannot read the room yet.
  Future<SharedSession?> readSession(String sessionId) async {
    try {
      final snapshot = await _session(sessionId).get();
      if (!snapshot.exists) return null;
      final data = snapshot.data();
      if (data == null) return null;
      return _sessionFrom(sessionId, data);
    } on FirebaseException catch (error, stack) {
      if (error.code == 'permission-denied') return null;
      debugPrint('Could not read shared session: $error\n$stack');
      rethrow;
    }
  }

  Future<void> join({
    required SessionInvite invite,
    required String name,
    required String username,
  }) {
    return _session(invite.sessionId)
        .collection(participantsCollection)
        .doc(userId)
        .set({
          'uid': userId,
          'name': name,
          'username': username,
          'joinedAt': FieldValue.serverTimestamp(),
          'inviteCode': invite.code,
        });
  }

  /// Writes this account's username onto an existing member document.
  Future<void> publishUsername({
    required String sessionId,
    required String username,
  }) {
    return _session(sessionId)
        .collection(participantsCollection)
        .doc(userId)
        .update({'username': username});
  }

  Future<void> activate({
    required String sessionId,
    required String inviteCode,
    required DateTime startedAt,
    required DateTime? endsAt,
    required DateTime expiresAt,
  }) async {
    final expiry = Timestamp.fromDate(expiresAt);
    final batch = firestore.batch();
    batch.update(_session(sessionId), {
      'status': SharedSessionStatus.active.name,
      'startedAt': Timestamp.fromDate(startedAt),
      'endsAt': _time(endsAt),
      'expiresAt': expiry,
    });
    batch.update(_invite(inviteCode), {'expiresAt': expiry});
    await batch.commit();
  }

  Future<void> markEnded(String sessionId) {
    return _session(sessionId)
        .update({'status': SharedSessionStatus.ended.name});
  }

  DocumentReference<Map<String, dynamic>> _chat(String sessionId) {
    return _session(sessionId).collection(chatCollection).doc(chatRoomId);
  }

  /// Turns messaging on for a room that was created without it.
  Future<void> enableChat(String sessionId) {
    return _session(sessionId).update({'chatEnabled': true});
  }

  Stream<List<SessionChatMessage>> watchChat(String sessionId) {
    return _chat(sessionId).snapshots().map((snapshot) {
      if (!snapshot.exists) return const <SessionChatMessage>[];
      return _messagesFrom(snapshot.data()?['messages']);
    });
  }

  /// Appends one message and keeps the latest [maxChatMessages].
  ///
  /// Existing entries are written back unchanged so the document stays one
  /// read for everyone who has the chat open. The latest-message time and
  /// author land on the session document, which the sheet already listens to.
  Future<void> sendMessage({
    required String sessionId,
    required String name,
    required String text,
    String? id,
    DateTime? at,
  }) async {
    final message = chatMessageText(text);
    if (message == null) return;
    final room = _chat(sessionId);
    final session = _session(sessionId);
    final messageId = id ?? _uuid.v4().replaceAll('-', '');
    final sentAt = at ?? DateTime.now();
    await firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(room);
      final current = snapshot.exists
          ? _messageMaps(snapshot.data()?['messages'])
          : <Map<String, dynamic>>[];
      current.add({
        'id': messageId,
        'uid': userId,
        'name': name,
        'text': message,
        'at': Timestamp.fromDate(sentAt),
      });
      if (current.length > maxChatMessages) {
        current.removeRange(0, current.length - maxChatMessages);
      }
      transaction.set(room, {'messages': current});
      transaction.update(session, {
        'chatAt': FieldValue.serverTimestamp(),
        'chatBy': userId,
      });
    });
  }

  DocumentReference<Map<String, dynamic>> _pauseRequest(String sessionId) {
    return _session(sessionId)
        .collection(pauseRequestCollection)
        .doc(currentPauseRequestId);
  }

  /// Asks the other members to pause. The asker counts as having accepted.
  Future<void> requestPause({required String sessionId, required String name}) {
    return _pauseRequest(sessionId).set({
      'requestedBy': userId,
      'requestedName': name,
      'createdAt': FieldValue.serverTimestamp(),
      'accepted': {userId: true},
    });
  }

  Future<void> acceptPause(String sessionId) {
    return _pauseRequest(sessionId).update({'accepted.$userId': true});
  }

  Future<void> clearPauseRequest(String sessionId) {
    return _pauseRequest(sessionId).delete();
  }

  /// Drops this account from the room. The room keeps going for the others.
  Future<void> leave(String sessionId) {
    return _session(sessionId)
        .collection(participantsCollection)
        .doc(userId)
        .delete();
  }

  Stream<PauseRequest?> watchPauseRequest(String sessionId) {
    return _pauseRequest(sessionId).snapshots().map((snapshot) {
      final data = snapshot.data();
      if (!snapshot.exists || data == null) return null;
      return _pauseRequestFrom(data);
    });
  }

  Stream<SharedSession?> watchSession(String sessionId) {
    return _session(sessionId).snapshots().map((snapshot) {
      final data = snapshot.data();
      if (!snapshot.exists || data == null) return null;
      return _sessionFrom(sessionId, data);
    });
  }

  Stream<List<SessionParticipant>> watchParticipants(String sessionId) {
    return _session(sessionId)
        .collection(participantsCollection)
        .snapshots()
        .map((snapshot) {
          final people = <SessionParticipant>[];
          for (final doc in snapshot.docs) {
            try {
              people.add(_participantFrom(doc.id, doc.data()));
            } catch (error, stack) {
              debugPrint('Skipping participant ${doc.id}: $error\n$stack');
            }
          }
          people.sort((a, b) {
            final left = a.joinedAt;
            final right = b.joinedAt;
            if (left == null && right == null) return a.uid.compareTo(b.uid);
            if (left == null) return 1;
            if (right == null) return -1;
            final byTime = left.compareTo(right);
            if (byTime != 0) return byTime;
            return a.uid.compareTo(b.uid);
          });
          return people;
        });
  }
}

Object? _time(DateTime? time) {
  if (time == null) return null;
  return Timestamp.fromDate(time);
}

DateTime? _readTime(Object? value) {
  if (value is Timestamp) return value.toDate();
  return null;
}

SharedSession _sessionFrom(String id, Map<String, dynamic> data) {
  final expiresAt = _readTime(data['expiresAt']);
  return SharedSession(
    id: id,
    hostId: data['hostId'] as String? ?? '',
    hostName: data['hostName'] as String? ?? '',
    title: data['title'] as String? ?? '',
    labelEmoji: data['labelEmoji'] as String?,
    durationMinutes: data['durationMinutes'] as int?,
    status: sharedStatusFrom(data['status'] as String?),
    startedAt: _readTime(data['startedAt']),
    endsAt: _readTime(data['endsAt']),
    createdAt: _readTime(data['createdAt']),
    expiresAt: expiresAt ?? DateTime.fromMillisecondsSinceEpoch(0),
    chatEnabled: data['chatEnabled'] == true,
    chatAt: _readTime(data['chatAt']),
    chatBy: data['chatBy'] is String && (data['chatBy'] as String).isNotEmpty
        ? data['chatBy'] as String
        : null,
  );
}

SessionInvite _inviteFrom(String code, Map<String, dynamic> data) {
  final expiresAt = _readTime(data['expiresAt']);
  return SessionInvite(
    code: code,
    sessionId: data['sessionId'] as String? ?? '',
    createdBy: data['createdBy'] as String? ?? '',
    hostName: data['hostName'] as String? ?? '',
    title: data['title'] as String? ?? '',
    labelEmoji: data['labelEmoji'] as String?,
    durationMinutes: data['durationMinutes'] as int?,
    createdAt: _readTime(data['createdAt']),
    expiresAt: expiresAt ?? DateTime.fromMillisecondsSinceEpoch(0),
    revoked: data['revoked'] == true,
  );
}

SessionParticipant _participantFrom(String id, Map<String, dynamic> data) {
  final username = data['username'];
  return SessionParticipant(
    uid: data['uid'] as String? ?? id,
    name: data['name'] as String? ?? '',
    joinedAt: _readTime(data['joinedAt']),
    username: username is String && username.isNotEmpty ? username : null,
  );
}

List<SessionChatMessage> _messagesFrom(Object? raw) {
  if (raw is! List) return const [];
  final messages = <SessionChatMessage>[];
  for (final item in raw) {
    if (item is! Map) continue;
    final id = item['id'];
    final uid = item['uid'];
    final name = item['name'];
    final text = item['text'];
    final at = _readTime(item['at']);
    if (id is! String ||
        uid is! String ||
        name is! String ||
        text is! String ||
        at == null) {
      continue;
    }
    messages.add(
      SessionChatMessage(id: id, uid: uid, name: name, text: text, at: at),
    );
  }
  return messages;
}

List<Map<String, dynamic>> _messageMaps(Object? raw) {
  if (raw is! List) return [];
  return [
    for (final item in raw)
      if (item is Map) Map<String, dynamic>.from(item),
  ];
}

PauseRequest _pauseRequestFrom(Map<String, dynamic> data) {
  final accepted = <String, bool>{};
  final raw = data['accepted'];
  if (raw is Map) {
    for (final entry in raw.entries) {
      if (entry.value == true) accepted[entry.key.toString()] = true;
    }
  }
  return PauseRequest(
    requestedBy: data['requestedBy'] as String? ?? '',
    requestedName: data['requestedName'] as String? ?? '',
    createdAt: _readTime(data['createdAt']),
    accepted: accepted,
  );
}
