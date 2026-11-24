import '../l10n/tr.dart';

enum SessionOutcome { active, completed, endedEarly, created, paused }

const _unchanged = Object();

class FocusSession {
  const FocusSession({
    required this.id,
    required this.blockListId,
    required this.blockListName,
    required this.startedAt,
    this.endsAt,
    required this.outcome,
    this.stoppedAt,
    this.pausedAt,
    this.labelId,
    this.sharedSessionId,
    this.inviteCode,
    this.sharedHost = false,
    this.chatEnabled = false,
  });

  final String id;
  final String blockListId;
  final String blockListName;
  final DateTime startedAt;

  /// When null, the session has no set length and runs until it is ended.
  final DateTime? endsAt;
  final DateTime? stoppedAt;

  /// When the clock was held. Set only while [outcome] is paused.
  final DateTime? pausedAt;
  final SessionOutcome outcome;

  /// Label this session uses. The name and emoji live on that label.
  final String? labelId;

  /// Shared room this phone is part of, when the session was shared or joined.
  final String? sharedSessionId;

  /// Invite code for [sharedSessionId]. Sharing again reuses it.
  final String? inviteCode;

  /// True on the phone that created the shared room.
  final bool sharedHost;

  /// Chosen on the new-session sheet. Copied onto the room when it is shared.
  final bool chatEnabled;

  bool get hasLabel => labelId != null;

  bool isRunningAt(DateTime now) {
    if (outcome != SessionOutcome.active) return false;
    final end = endsAt;
    return end == null || end.isAfter(now);
  }

  Duration? remainingAt(DateTime now) {
    final end = endsAt;
    if (end == null) return null;
    final remaining = end.difference(now);
    return remaining.isNegative ? Duration.zero : remaining;
  }

  String get outcomeLabel {
    switch (outcome) {
      case SessionOutcome.created:
        return tr('session_not_started');
      case SessionOutcome.active:
        return tr('session_in_progress');
      case SessionOutcome.paused:
        return tr('session_paused');
      case SessionOutcome.completed:
        return tr('session_finished');
      case SessionOutcome.endedEarly:
        return endsAt == null ? tr('session_ended') : tr('session_ended_early');
    }
  }

  FocusSession copyWith({
    String? blockListName,
    DateTime? startedAt,
    Object? endsAt = _unchanged,
    SessionOutcome? outcome,
    DateTime? stoppedAt,
    Object? pausedAt = _unchanged,
    String? labelId,
    String? sharedSessionId,
    String? inviteCode,
    bool? sharedHost,
    bool? chatEnabled,
  }) {
    return FocusSession(
      id: id,
      blockListId: blockListId,
      blockListName: blockListName ?? this.blockListName,
      startedAt: startedAt ?? this.startedAt,
      endsAt: identical(endsAt, _unchanged) ? this.endsAt : endsAt as DateTime?,
      outcome: outcome ?? this.outcome,
      stoppedAt: stoppedAt ?? this.stoppedAt,
      pausedAt: identical(pausedAt, _unchanged)
          ? this.pausedAt
          : pausedAt as DateTime?,
      labelId: labelId ?? this.labelId,
      sharedSessionId: sharedSessionId ?? this.sharedSessionId,
      inviteCode: inviteCode ?? this.inviteCode,
      sharedHost: sharedHost ?? this.sharedHost,
      chatEnabled: chatEnabled ?? this.chatEnabled,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'blockListId': blockListId,
      'blockListName': blockListName,
      'startedAt': startedAt.millisecondsSinceEpoch,
      'endsAt': endsAt?.millisecondsSinceEpoch,
      'stoppedAt': stoppedAt?.millisecondsSinceEpoch,
      'pausedAt': pausedAt?.millisecondsSinceEpoch,
      'outcome': outcome.name,
      'labelId': labelId,
      'sharedSessionId': sharedSessionId,
      'inviteCode': inviteCode,
      'sharedHost': sharedHost,
      'chatEnabled': chatEnabled,
    };
  }

  factory FocusSession.fromJson(Map<String, dynamic> json) {
    return FocusSession(
      id: json['id'] as String,
      blockListId: json['blockListId'] as String,
      blockListName: json['blockListName'] as String,
      startedAt: DateTime.fromMillisecondsSinceEpoch(json['startedAt'] as int),
      endsAt: json['endsAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['endsAt'] as int),
      stoppedAt: json['stoppedAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['stoppedAt'] as int),
      pausedAt: json['pausedAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['pausedAt'] as int),
      outcome: SessionOutcome.values.byName(json['outcome'] as String),
      labelId: json['labelId'] as String?,
      sharedSessionId: json['sharedSessionId'] as String?,
      inviteCode: json['inviteCode'] as String?,
      sharedHost: json['sharedHost'] == true,
      chatEnabled: json['chatEnabled'] == true,
    );
  }
}

/// Marks sessions whose end time has passed as finished.
List<FocusSession> settleSessions(List<FocusSession> sessions, DateTime now) {
  return [
    for (final session in sessions)
      if (session.outcome == SessionOutcome.active &&
          session.endsAt != null &&
          !session.endsAt!.isAfter(now))
        session.copyWith(
          outcome: SessionOutcome.completed,
          stoppedAt: session.endsAt,
        )
      else
        session,
  ];
}

bool sessionsChanged(List<FocusSession> before, List<FocusSession> after) {
  if (before.length != after.length) return true;
  for (var index = 0; index < before.length; index++) {
    if (before[index].outcome != after[index].outcome ||
        before[index].stoppedAt != after[index].stoppedAt) {
      return true;
    }
  }
  return false;
}

List<FocusSession> trimSessions(List<FocusSession> sessions) {
  if (sessions.length <= 50) return sessions;
  return sessions.sublist(sessions.length - 50);
}

/// Finished sessions shorter than this never join history or stats.
const minimumRecordedLength = Duration(minutes: 5);

/// Pause stays unavailable until the session has run longer than this.
const minimumPauseLength = Duration(minutes: 20);

/// Drops finished sessions that ran for less than [minimumRecordedLength].
///
/// A session is part of the record once it has been going that long.
/// Stopping sooner leaves nothing behind. One that is still running, paused,
/// or not started yet stays, so it can continue.
List<FocusSession> dropUnrecordedSessions(
  List<FocusSession> sessions,
  DateTime now,
) {
  return [
    for (final session in sessions)
      if (_isRecorded(session, now)) session,
  ];
}

/// True once [session] has run for [minimumRecordedLength].
///
/// Ending sooner drops it from history. Time spent paused does not count.
bool sessionMeetsRecordedLength(FocusSession session, DateTime now) {
  final length = _runLength(session, now);
  return length != null && length >= minimumRecordedLength;
}

/// True when the user may stop [session].
///
/// Stopping stays unavailable until the session has run for
/// [minimumRecordedLength]. Time spent paused does not count.
bool canStopSession(FocusSession session, DateTime now) {
  if (session.outcome != SessionOutcome.active &&
      session.outcome != SessionOutcome.paused) {
    return false;
  }
  return sessionMeetsRecordedLength(session, now);
}

/// True when the user may pause [session].
///
/// Pausing lifts the shield, so it stays unavailable until the session has
/// run for longer than [minimumPauseLength].
bool canPauseSession(FocusSession session, DateTime now) {
  if (session.outcome != SessionOutcome.active) return false;
  final length = _runLength(session, now);
  return length != null && length > minimumPauseLength;
}

bool _isRecorded(FocusSession session, DateTime now) {
  switch (session.outcome) {
    case SessionOutcome.created:
    case SessionOutcome.active:
    case SessionOutcome.paused:
      return true;
    case SessionOutcome.completed:
    case SessionOutcome.endedEarly:
      return sessionMeetsRecordedLength(session, now);
  }
}

/// Sessions that have actually run for more than one minute.
///
/// The clock starts when the session starts. A session that is still going
/// counts once [now] is more than a minute past its start. One that was
/// stopped sooner does not, even if it was planned to run longer.
int sessionsStartedLongerThanOneMinute(
  List<FocusSession> sessions,
  DateTime now,
) {
  var count = 0;
  for (final session in sessions) {
    final length = _runLength(session, now);
    if (length != null && length > const Duration(minutes: 1)) count++;
  }
  return count;
}

Duration? _runLength(FocusSession session, DateTime now) {
  final DateTime? end;
  switch (session.outcome) {
    case SessionOutcome.created:
      return null;
    case SessionOutcome.active:
      final planned = session.endsAt;
      end = planned != null && !planned.isAfter(now) ? planned : now;
    case SessionOutcome.paused:
      final held = session.pausedAt ?? now;
      final plannedPause = session.endsAt;
      end = plannedPause != null && !plannedPause.isAfter(held)
          ? plannedPause
          : held;
    case SessionOutcome.completed:
    case SessionOutcome.endedEarly:
      end = session.stoppedAt ?? session.endsAt;
  }
  if (end == null || !end.isAfter(session.startedAt)) return null;
  return end.difference(session.startedAt);
}

String formatRemaining(Duration duration) {
  final clamped = duration.isNegative ? Duration.zero : duration;
  final hours = clamped.inHours;
  final minutes = clamped.inMinutes.remainder(60);
  final seconds = clamped.inSeconds.remainder(60);
  final minuteText = minutes.toString().padLeft(2, '0');
  final secondText = seconds.toString().padLeft(2, '0');
  if (hours > 0) {
    return '$hours:$minuteText:$secondText';
  }
  return '$minuteText:$secondText';
}

String sessionLengthLabel(FocusSession session) {
  final planned = session.endsAt;
  if (planned == null) {
    final stopped = session.stoppedAt;
    if (stopped == null) return tr('session_open');
    final span = stopped.difference(session.startedAt);
    if (span.inSeconds < 60) return tr('duration_under_minute');
    return formatSessionLength(span);
  }
  return formatSessionLength(planned.difference(session.startedAt));
}

String minutesLabel(int minutes) => tr('duration_minutes', args: ['$minutes']);

String formatSessionLength(Duration duration) {
  final minutes = duration.inMinutes;
  if (minutes < 60) return minutesLabel(minutes);
  final hours = minutes ~/ 60;
  final rest = minutes % 60;
  if (rest == 0) {
    return hours == 1
        ? tr('duration_one_hour')
        : tr('duration_hours', args: ['$hours']);
  }
  return tr('duration_hours_minutes', args: ['$hours', '$rest']);
}

String formatSessionStamp(DateTime time, DateTime now) {
  final local = time.toLocal();
  final current = now.toLocal();
  final day = DateTime(local.year, local.month, local.day);
  final today = DateTime(current.year, current.month, current.day);
  final diff = today.difference(day).inDays;
  final clock =
      '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  if (diff == 0) return tr('stamp_today', args: [clock]);
  if (diff == 1) return tr('stamp_yesterday', args: [clock]);
  return tr(
    'stamp_date',
    args: [monthShort(local.month), '${local.day}', clock],
  );
}
