import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/block_list.dart';
import '../models/focus_label.dart';
import '../models/focus_session.dart';
import '../models/session_duration.dart';
import '../repositories/focus.dart';
import '../services/focus_repository.dart';
import '../services/focus_shield_bridge.dart';

export '../repositories/focus.dart' show focusRepositoryProvider;

const _uuid = Uuid();
const _keep = Object();

final focusShieldBridgeProvider = Provider<FocusShieldBridge>((ref) {
  return FocusShieldBridge();
});

final authorizationProvider =
    AsyncNotifierProvider<AuthorizationNotifier, FamilyControlsAuthorization>(
      AuthorizationNotifier.new,
    );

class AuthorizationNotifier extends AsyncNotifier<FamilyControlsAuthorization> {
  @override
  Future<FamilyControlsAuthorization> build() {
    return ref.read(focusShieldBridgeProvider).status();
  }

  Future<FamilyControlsAuthorization> request() async {
    final status = await ref
        .read(focusShieldBridgeProvider)
        .requestAuthorization();
    state = AsyncData(status);
    return status;
  }

  Future<void> refresh() async {
    state = AsyncData(await ref.read(focusShieldBridgeProvider).status());
  }
}

final focusControllerProvider = NotifierProvider<FocusController, FocusState>(
  FocusController.new,
);

class FocusState {
  const FocusState({
    required this.lists,
    required this.sessions,
    this.customLabels = const [],
    this.durationMinutes,
    this.selectionsReady = false,
  });

  final List<BlockList> lists;
  final List<FocusSession> sessions;

  /// Labels the user created, plus edits and deletions of the built-in ones.
  /// Built-in labels are always shown ahead of labels the user created.
  final List<FocusLabel> customLabels;

  /// Null means the next session has no set length.
  final int? durationMinutes;

  /// True once list counts match the selection stored on this device.
  ///
  /// Counts in the account can describe apps chosen on another install.
  /// Those numbers stay unread until this phone has checked its own copy.
  final bool selectionsReady;

  List<FocusLabel> get labels {
    final saved = {for (final label in customLabels) label.id: label};
    final builtInIds = {for (final label in kBuiltInFocusLabels) label.id};
    return [
      for (final builtIn in kBuiltInFocusLabels)
        if (saved[builtIn.id]?.deleted != true) saved[builtIn.id] ?? builtIn,
      for (final label in customLabels)
        if (!builtInIds.contains(label.id) && !label.deleted) label,
    ];
  }

  FocusSession? get activeSession {
    for (final session in sessions.reversed) {
      if (session.outcome == SessionOutcome.active) return session;
    }
    return null;
  }

  FocusSession? get pausedSession {
    for (final session in sessions.reversed) {
      if (session.outcome == SessionOutcome.paused) return session;
    }
    return null;
  }

  /// The session on screen. A running one wins, then one that is paused,
  /// then the newest session whose timer has not been started yet.
  FocusSession? get foregroundSession {
    final running = activeSession;
    if (running != null) return running;
    final held = pausedSession;
    if (held != null) return held;
    for (final session in sessions.reversed) {
      if (session.outcome == SessionOutcome.created) return session;
    }
    return null;
  }

  BlockList? get favoriteList {
    for (final list in lists) {
      if (list.isFavorite) return list;
    }
    return null;
  }

  FocusState copyWith({
    List<BlockList>? lists,
    List<FocusSession>? sessions,
    List<FocusLabel>? customLabels,
    Object? durationMinutes = _keep,
    bool? selectionsReady,
  }) {
    return FocusState(
      lists: lists ?? this.lists,
      sessions: sessions ?? this.sessions,
      customLabels: customLabels ?? this.customLabels,
      durationMinutes: identical(durationMinutes, _keep)
          ? this.durationMinutes
          : durationMinutes as int?,
      selectionsReady: selectionsReady ?? this.selectionsReady,
    );
  }
}

class FocusController extends Notifier<FocusState> {
  bool _settling = false;
  var _generation = 0;
  var _syncedShields = false;
  final Set<String> _nameLoads = {};

  @override
  FocusState build() {
    final generation = ++_generation;
    _settling = false;
    _nameLoads.clear();
    _syncedShields = false;

    final repository = ref.watch(focusRepositoryProvider);
    final bridge = ref.watch(focusShieldBridgeProvider);
    final subscription = repository.changes.listen((_) {
      Future<void>(() {
        if (!ref.mounted || generation != _generation) return;
        _hydrate(repository, bridge);
      });
    });
    ref.onDispose(subscription.cancel);

    final initial = _project(repository, commitSettled: repository.hasLoaded);
    if (repository.hasLoaded) {
      _syncedShields = true;
      final now = DateTime.now();
      unawaited(_syncShields(bridge, initial.sessions, now));
      unawaited(_loadApplicationNames(bridge, initial.lists));
    }
    if (!bridge.storesSelections) {
      return initial.copyWith(selectionsReady: true);
    }
    if (repository.hasLoaded) {
      unawaited(_reconcileSelections(bridge, generation, initial.lists));
    }
    return initial;
  }

  FocusState _project(
    FocusRepository repository, {
    required bool commitSettled,
  }) {
    final lists = repository.readLists();
    final stored = repository.readSessions();
    final now = DateTime.now();
    final settled = dropUnrecordedSessions(settleSessions(stored, now), now);
    if (commitSettled && sessionsChanged(stored, settled)) {
      unawaited(
        repository
            .writeSessions(settled)
            .then(
              (_) {},
              onError: (Object error, StackTrace stack) {
                debugPrint('Could not save settled sessions: $error\n$stack');
              },
            ),
      );
    }
    return FocusState(
      lists: lists,
      sessions: settled,
      customLabels: repository.readLabels(),
    );
  }

  void _hydrate(FocusRepository repository, FocusShieldBridge bridge) {
    if (!ref.mounted) return;
    final previous = state.activeSession;
    final next = _project(repository, commitSettled: true);
    state = next.copyWith(
      durationMinutes: state.durationMinutes,
      selectionsReady: bridge.storesSelections ? state.selectionsReady : true,
    );
    if (bridge.storesSelections) {
      unawaited(_reconcileSelections(bridge, _generation, next.lists));
    }
    final active = state.activeSession;
    final activeChanged =
        previous?.id != active?.id ||
        previous?.endsAt != active?.endsAt ||
        previous?.blockListId != active?.blockListId;
    if (!_syncedShields || activeChanged) {
      _syncedShields = true;
      unawaited(_syncShields(bridge, state.sessions, DateTime.now()));
    }
    unawaited(_loadApplicationNames(bridge, state.lists));
  }

  Future<void> _loadApplicationNames(
    FocusShieldBridge bridge,
    List<BlockList> lists,
  ) async {
    final ids = <String>[];
    for (final list in lists) {
      if (list.applicationCount == 0 || list.applicationNames.isNotEmpty) {
        continue;
      }
      if (!_nameLoads.add('${list.id}:${list.applicationCount}')) continue;
      ids.add(list.id);
    }
    if (ids.isEmpty) return;
    final names = await bridge.applicationNames(ids);
    if (!ref.mounted || names.isEmpty) return;

    final updated = <BlockList>[];
    var changed = false;
    for (final list in state.lists) {
      final found = names[list.id];
      if (found != null && found.isNotEmpty && list.applicationNames.isEmpty) {
        updated.add(list.copyWith(applicationNames: found));
        changed = true;
      } else {
        updated.add(list);
      }
    }
    if (!changed) return;
    state = state.copyWith(lists: updated);
    await ref.read(focusRepositoryProvider).writeLists(updated);
  }

  /// Drops counts for lists whose apps are not stored on this device.
  ///
  /// The account can still say a list blocks six apps after a reinstall.
  /// The tokens never leave the phone, so that count is cleared until the
  /// apps are chosen again here.
  Future<void> _reconcileSelections(
    FocusShieldBridge bridge,
    int generation,
    List<BlockList> lists,
  ) async {
    final stored = lists.isEmpty
        ? const <String, SelectionCounts>{}
        : await bridge.storedSelections([
            for (final list in lists) list.id,
          ]);
    if (lists.isEmpty) {
      await Future<void>.value();
    }
    if (!ref.mounted || generation != _generation) return;
    if (stored == null) {
      if (!state.selectionsReady) {
        state = state.copyWith(selectionsReady: true);
      }
      return;
    }

    final updated = <BlockList>[];
    var changed = false;
    for (final list in state.lists) {
      final found = stored[list.id];
      if (found == null) {
        if (list.isEmpty && list.applicationNames.isEmpty) {
          updated.add(list);
          continue;
        }
        changed = true;
        updated.add(
          list.copyWith(
            applicationCount: 0,
            categoryCount: 0,
            webDomainCount: 0,
            applicationNames: const [],
          ),
        );
        continue;
      }
      final names = found.applicationNames.isNotEmpty
          ? found.applicationNames
          : list.applicationNames;
      if (list.applicationCount == found.applicationCount &&
          list.categoryCount == found.categoryCount &&
          list.webDomainCount == found.webDomainCount &&
          _sameNames(list.applicationNames, names)) {
        updated.add(list);
        continue;
      }
      changed = true;
      updated.add(
        list.copyWith(
          applicationCount: found.applicationCount,
          categoryCount: found.categoryCount,
          webDomainCount: found.webDomainCount,
          applicationNames: names,
        ),
      );
    }
    if (!changed) {
      if (!state.selectionsReady) {
        state = state.copyWith(selectionsReady: true);
      }
      return;
    }
    state = state.copyWith(lists: updated, selectionsReady: true);
    await ref.read(focusRepositoryProvider).writeLists(updated);
  }

  bool _sameNames(List<String> left, List<String> right) {
    if (left.length != right.length) return false;
    for (var i = 0; i < left.length; i++) {
      if (left[i] != right[i]) return false;
    }
    return true;
  }

  /// Marks [id] as the list a new session starts with.
  ///
  /// Tapping the current default clears it, so zero or one list is the default.
  Future<void> setFavorite(String id) async {
    if (!state.lists.any((list) => list.id == id)) return;
    final turningOff = state.lists.any(
      (list) => list.id == id && list.isFavorite,
    );
    final lists = [
      for (final list in state.lists)
        list.copyWith(isFavorite: !turningOff && list.id == id),
    ];
    state = state.copyWith(lists: lists);
    await ref.read(focusRepositoryProvider).writeLists(lists);
  }

  void setDuration(int? minutes) {
    state = state.copyWith(
      durationMinutes: minutes == null ? null : clampSessionMinutes(minutes),
    );
  }

  Future<void> upsertList(BlockList list) async {
    BlockList? previous;
    for (final existing in state.lists) {
      if (existing.id == list.id) {
        previous = existing;
        break;
      }
    }
    final favorite = previous?.isFavorite ?? list.isFavorite;
    final saved = list.copyWith(
      isFavorite: favorite,
      applicationNames: list.applicationNames.isNotEmpty
          ? list.applicationNames
          : previous?.applicationNames ?? const [],
    );
    final lists = [
      for (final existing in state.lists)
        if (existing.id != saved.id)
          existing.copyWith(isFavorite: favorite ? false : existing.isFavorite),
      saved,
    ]..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    var sessions = state.sessions;
    final active = state.foregroundSession;
    if (active != null &&
        active.blockListId == list.id &&
        active.blockListName != list.name) {
      sessions = [
        for (final session in sessions)
          if (session.id == active.id)
            session.copyWith(blockListName: list.name)
          else
            session,
      ];
    }

    state = state.copyWith(lists: lists, sessions: sessions);
    final repository = ref.read(focusRepositoryProvider);
    await repository.writeLists(lists);
    if (active != null && active.blockListId == list.id) {
      await repository.writeSessions(sessions);
    }

    if (active != null &&
        active.outcome == SessionOutcome.active &&
        active.blockListId == list.id) {
      await ref
          .read(focusShieldBridgeProvider)
          .startSession(listId: list.id, endsAt: active.endsAt, strict: false);
    }
    if (saved.applicationCount > 0 && saved.applicationNames.isEmpty) {
      unawaited(
        _loadApplicationNames(ref.read(focusShieldBridgeProvider), [saved]),
      );
    }
  }

  Future<void> addLabel({required String emoji, required String name}) async {
    final label = FocusLabel(
      id: _uuid.v4(),
      emoji: emoji,
      name: capitalizeLabelName(name),
      createdAt: DateTime.now(),
    );
    final customLabels = [...state.customLabels, label];
    state = state.copyWith(customLabels: customLabels);
    await ref.read(focusRepositoryProvider).writeLabels(customLabels);
  }

  /// Changes a label's emoji or name. Past sessions that used it keep the new name.
  ///
  /// Labels that come with the app stay as they are.
  Future<void> updateLabel({
    required String id,
    required String emoji,
    required String name,
  }) async {
    if (isBuiltInLabel(id)) return;
    FocusLabel? current;
    for (final label in state.labels) {
      if (label.id == id) {
        current = label;
        break;
      }
    }
    if (current == null) return;

    final updated = FocusLabel(
      id: id,
      emoji: emoji,
      name: capitalizeLabelName(name),
      createdAt: current.createdAt,
    );
    if (updated.emoji == current.emoji && updated.name == current.name) {
      return;
    }

    final customLabels = [...state.customLabels];
    final index = customLabels.indexWhere((label) => label.id == id);
    if (index < 0) {
      customLabels.add(updated);
    } else {
      customLabels[index] = updated;
    }

    var sessionsChanged = false;
    final sessions = <FocusSession>[];
    for (final session in state.sessions) {
      if (session.labelId != id ||
          (session.labelEmoji == updated.emoji &&
              session.labelName == updated.name)) {
        sessions.add(session);
        continue;
      }
      sessionsChanged = true;
      sessions.add(
        session.copyWith(labelEmoji: updated.emoji, labelName: updated.name),
      );
    }

    state = state.copyWith(customLabels: customLabels, sessions: sessions);
    final repository = ref.read(focusRepositoryProvider);
    await repository.writeLabels(customLabels);
    if (sessionsChanged) await repository.writeSessions(sessions);
  }

  /// Removes a label the user created. Sessions that wore it switch to Focus
  /// Time, so that time stays in history and stats. The default labels stay.
  Future<void> deleteLabel(String id) async {
    if (isBuiltInLabel(id)) return;
    FocusLabel? current;
    for (final label in state.labels) {
      if (label.id == id) {
        current = label;
        break;
      }
    }
    if (current == null) return;

    final focusTime = _focusTimeLabel();
    final customLabels = [...state.customLabels]
      ..removeWhere((label) => label.id == id);

    var sessionsChanged = false;
    final sessions = <FocusSession>[];
    for (final session in state.sessions) {
      if (session.labelId != id) {
        sessions.add(session);
        continue;
      }
      sessionsChanged = true;
      sessions.add(
        session.copyWith(
          labelId: focusTime.id,
          labelEmoji: focusTime.emoji,
          labelName: focusTime.name,
        ),
      );
    }

    state = state.copyWith(customLabels: customLabels, sessions: sessions);
    final repository = ref.read(focusRepositoryProvider);
    await repository.writeLabels(customLabels);
    if (sessionsChanged) await repository.writeSessions(sessions);
  }

  FocusLabel _focusTimeLabel() {
    for (final label in state.labels) {
      if (label.id == focusTimeLabelId) return label;
    }
    return kBuiltInFocusLabels.first;
  }

  Future<void> deleteList(String id) async {
    if (state.foregroundSession?.blockListId == id) {
      throw const FocusShieldException(
        'LIST_IN_USE',
        'End the current session before deleting this list.',
      );
    }
    final lists = [
      for (final list in state.lists)
        if (list.id != id) list,
    ];
    state = state.copyWith(lists: lists);
    await ref.read(focusRepositoryProvider).writeLists(lists);
    await ref.read(focusShieldBridgeProvider).deleteSelection(id);
  }

  /// Saves a session without shielding apps. It can be started later.
  Future<void> createSession({
    required String listId,
    int? minutes,
    FocusLabel? label,
  }) async {
    final list = _listById(listId);
    if (list == null || list.isEmpty) {
      throw const FocusShieldException('EMPTY_SELECTION', '');
    }

    final length = minutes == null ? null : clampSessionMinutes(minutes);
    final startedAt = DateTime.now();
    final endsAt = length == null
        ? null
        : startedAt.add(Duration(minutes: length));
    final sessions = trimSessions([
      ...state.sessions,
      _labeled(
        FocusSession(
          id: _uuid.v4(),
          blockListId: list.id,
          blockListName: list.name,
          startedAt: startedAt,
          endsAt: endsAt,
          outcome: SessionOutcome.created,
          labelId: label?.id,
          labelEmoji: label?.emoji,
          labelName: label?.name,
        ),
      ),
    ]);
    state = state.copyWith(sessions: sessions, durationMinutes: length);
    await ref.read(focusRepositoryProvider).writeSessions(sessions);
  }

  Future<void> startSession({
    String? listId,
    int? minutes,
    String? sessionId,
    FocusLabel? label,
  }) async {
    if (sessionId != null) {
      await _startCreated(sessionId);
      return;
    }

    final list = _listById(listId);
    if (list == null || list.isEmpty) {
      throw const FocusShieldException('EMPTY_SELECTION', '');
    }
    if (state.activeSession != null || state.pausedSession != null) return;

    final length = minutes == null ? null : clampSessionMinutes(minutes);
    state = state.copyWith(durationMinutes: length);

    final startedAt = DateTime.now();
    final endsAt = length == null
        ? null
        : startedAt.add(Duration(minutes: length));
    await _startShield(listId: list.id, endsAt: endsAt);

    final sessions = trimSessions([
      ...state.sessions,
      _labeled(
        FocusSession(
          id: _uuid.v4(),
          blockListId: list.id,
          blockListName: list.name,
          startedAt: startedAt,
          endsAt: endsAt,
          outcome: SessionOutcome.active,
          labelId: label?.id,
          labelEmoji: label?.emoji,
          labelName: label?.name,
        ),
      ),
    ]);
    state = state.copyWith(sessions: sessions, durationMinutes: length);
    await ref.read(focusRepositoryProvider).writeSessions(sessions);
  }

  Future<void> _startCreated(String sessionId) async {
    FocusSession? existing;
    for (final session in state.sessions) {
      if (session.id == sessionId) {
        existing = session;
        break;
      }
    }
    if (existing == null || existing.outcome != SessionOutcome.created) return;
    if (state.activeSession != null || state.pausedSession != null) return;

    final list = _listById(existing.blockListId);
    if (list == null || list.isEmpty) {
      throw const FocusShieldException('EMPTY_SELECTION', '');
    }

    final planned = existing.endsAt?.difference(existing.startedAt);
    final length = planned == null
        ? null
        : clampSessionMinutes(planned.inMinutes);
    state = state.copyWith(durationMinutes: length);

    final startedAt = DateTime.now();
    final endsAt = length == null
        ? null
        : startedAt.add(Duration(minutes: length));
    await _startShield(listId: list.id, endsAt: endsAt);

    final sessions = [
      for (final session in state.sessions)
        if (session.id == sessionId)
          session.copyWith(
            blockListName: list.name,
            startedAt: startedAt,
            endsAt: endsAt,
            outcome: SessionOutcome.active,
          )
        else
          session,
    ];
    state = state.copyWith(sessions: sessions, durationMinutes: length);
    await ref.read(focusRepositoryProvider).writeSessions(sessions);
  }

  /// Remembers which label a session is for. The whole session keeps that label.
  Future<void> setSessionLabel({
    required String sessionId,
    required FocusLabel label,
  }) async {
    var changed = false;
    final sessions = <FocusSession>[];
    for (final session in state.sessions) {
      if (session.id != sessionId ||
          (session.labelId == label.id &&
              session.labelEmoji == label.emoji &&
              session.labelName == label.name)) {
        sessions.add(session);
        continue;
      }
      changed = true;
      sessions.add(
        session.copyWith(
          labelId: label.id,
          labelEmoji: label.emoji,
          labelName: label.name,
        ),
      );
    }
    if (!changed) return;
    state = state.copyWith(sessions: sessions);
    await ref.read(focusRepositoryProvider).writeSessions(sessions);
  }

  /// New sessions wear the first label until a person picks another.
  FocusSession _labeled(FocusSession session) {
    if (session.hasLabel) return session;
    final label = state.labels.first;
    return session.copyWith(
      labelId: label.id,
      labelEmoji: label.emoji,
      labelName: label.name,
    );
  }

  BlockList? _listById(String? listId) {
    if (listId == null) return state.favoriteList;
    for (final candidate in state.lists) {
      if (candidate.id == listId) return candidate;
    }
    return null;
  }

  /// Puts the shield up when Screen Time can do it.
  ///
  /// Family Controls is missing on the simulator. The session still starts,
  /// and the in-app clock ends it. A schedule the system rejects does not
  /// cancel the session either: strict mode used to throw and drop it, so
  /// Start Session closed the sheet and left nothing on screen.
  Future<void> _startShield({required String listId, DateTime? endsAt}) async {
    final authorization = await ref
        .read(authorizationProvider.notifier)
        .request();
    if (authorization == FamilyControlsAuthorization.unavailable) return;
    if (!authorization.isAuthorized) {
      throw const FocusShieldException('NOT_AUTHORIZED', '');
    }
    try {
      await ref
          .read(focusShieldBridgeProvider)
          .startSession(listId: listId, endsAt: endsAt, strict: false);
    } on FocusShieldException catch (error, stack) {
      if (error.code == 'NOT_AUTHORIZED' || error.code == 'EMPTY_SELECTION') {
        rethrow;
      }
      debugPrint('Could not shield the session: $error\n$stack');
    }
  }

  /// Drops a session whose timer was never started.
  Future<void> discardSession(String sessionId) async {
    FocusSession? existing;
    for (final session in state.sessions) {
      if (session.id == sessionId) {
        existing = session;
        break;
      }
    }
    if (existing == null || existing.outcome != SessionOutcome.created) return;
    final sessions = [
      for (final session in state.sessions)
        if (session.id != sessionId) session,
    ];
    state = state.copyWith(sessions: sessions);
    await ref.read(focusRepositoryProvider).writeSessions(sessions);
  }

  /// Holds the clock and lifts the shield. The session stays on screen.
  Future<void> pauseSession() async {
    final active = state.activeSession;
    if (active == null || _settling) return;
    final pausedAt = DateTime.now();
    await ref.read(focusShieldBridgeProvider).stopSession();
    final sessions = [
      for (final session in state.sessions)
        if (session.id == active.id)
          session.copyWith(outcome: SessionOutcome.paused, pausedAt: pausedAt)
        else
          session,
    ];
    state = state.copyWith(sessions: sessions);
    await ref.read(focusRepositoryProvider).writeSessions(sessions);
  }

  /// Continues a paused session. Time spent paused is not counted.
  Future<void> resumeSession() async {
    final paused = state.pausedSession;
    if (paused == null || state.activeSession != null || _settling) return;
    final list = _listById(paused.blockListId);
    if (list == null || list.isEmpty) {
      throw const FocusShieldException('EMPTY_SELECTION', '');
    }

    final pausedAt = paused.pausedAt ?? DateTime.now();
    final held = DateTime.now().difference(pausedAt);
    final startedAt = paused.startedAt.add(held);
    final endsAt = paused.endsAt?.add(held);
    await _startShield(listId: list.id, endsAt: endsAt);

    final sessions = [
      for (final session in state.sessions)
        if (session.id == paused.id)
          session.copyWith(
            startedAt: startedAt,
            endsAt: endsAt,
            outcome: SessionOutcome.active,
            pausedAt: null,
          )
        else
          session,
    ];
    state = state.copyWith(sessions: sessions);
    await ref.read(focusRepositoryProvider).writeSessions(sessions);
  }

  Future<void> endSession() async {
    final session = state.foregroundSession;
    if (session == null ||
        session.outcome == SessionOutcome.created ||
        _settling) {
      return;
    }
    _settling = true;
    try {
      final stoppedAt = session.outcome == SessionOutcome.paused
          ? (session.pausedAt ?? DateTime.now())
          : DateTime.now();
      await _finish(session, SessionOutcome.endedEarly, stoppedAt);
    } finally {
      _settling = false;
    }
  }

  /// Returns true when an in-progress session just reached its end.
  Future<bool> completeIfDue() async {
    if (_settling) return false;
    final active = state.activeSession;
    final endsAt = active?.endsAt;
    if (active == null || endsAt == null || endsAt.isAfter(DateTime.now())) {
      return false;
    }
    _settling = true;
    try {
      await _finish(active, SessionOutcome.completed, endsAt);
      return true;
    } finally {
      _settling = false;
    }
  }

  Future<void> _finish(
    FocusSession session,
    SessionOutcome outcome,
    DateTime stoppedAt,
  ) async {
    await ref.read(focusShieldBridgeProvider).stopSession();
    final finished = [
      for (final existing in state.sessions)
        if (existing.id == session.id)
          existing.copyWith(outcome: outcome, stoppedAt: stoppedAt)
        else
          existing,
    ];
    final sessions = dropUnrecordedSessions(finished, stoppedAt);
    state = state.copyWith(sessions: sessions);
    await ref.read(focusRepositoryProvider).writeSessions(sessions);
  }

  Future<void> _syncShields(
    FocusShieldBridge bridge,
    List<FocusSession> sessions,
    DateTime now,
  ) async {
    try {
      FocusSession? active;
      for (final session in sessions.reversed) {
        if (session.isRunningAt(now)) {
          active = session;
          break;
        }
      }
      if (active == null) {
        await bridge.stopSession();
        return;
      }
      await bridge.startSession(
        listId: active.blockListId,
        endsAt: active.endsAt,
        strict: false,
      );
    } catch (error, stack) {
      debugPrint('sync shields failed: $error\n$stack');
    }
  }
}
