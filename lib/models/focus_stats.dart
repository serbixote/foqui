import '../l10n/tr.dart';
import 'focus_session.dart';

/// One local calendar day in the trailing week.
class DayFocus {
  const DayFocus({required this.day, required this.focused});

  /// Local date at midnight.
  final DateTime day;
  final Duration focused;
}

/// Focus time collected under one block list.
class BlockListFocus {
  const BlockListFocus({
    required this.id,
    required this.name,
    required this.focused,
    required this.sessions,
  });

  final String id;
  final String name;
  final Duration focused;
  final int sessions;
}

/// Focus time collected under one label, such as study or family time.
class LabelFocus {
  const LabelFocus({
    required this.id,
    required this.emoji,
    required this.name,
    required this.focused,
    required this.sessions,
  });

  final String id;
  final String emoji;
  final String name;
  final Duration focused;
  final int sessions;
}

/// Totals derived from saved sessions.
class FocusStats {
  const FocusStats({
    required this.focused,
    required this.sessionCount,
    required this.finishedCount,
    required this.endedEarlyCount,
    required this.streakDays,
    required this.streakIncludesToday,
    required this.longest,
    required this.average,
    required this.givenBack,
    required this.today,
    required this.todaySessions,
    required this.weekSessions,
    required this.weekDays,
    required this.ranCount,
    required this.stayedCount,
    required this.bestDay,
    required this.week,
    required this.byLabel,
    required this.byList,
  });

  final Duration focused;
  final int sessionCount;
  final int finishedCount;
  final int endedEarlyCount;

  /// Consecutive days with focus time, ending today or yesterday.
  final int streakDays;

  /// True when [streakDays] includes the current local day.
  final bool streakIncludesToday;
  final Duration longest;

  /// Mean length of sessions that contributed focus time.
  final Duration average;

  /// Planned time left behind when a session was ended early.
  final Duration givenBack;

  /// Focus time that falls on the current local day.
  final Duration today;
  final int todaySessions;

  /// Sessions that started during [week] or spilled time into it.
  final int weekSessions;

  /// Days in [week] that have any focus time.
  final int weekDays;

  /// Sessions that left the not-started state.
  final int ranCount;

  /// Running or finished sessions. Ending early does not count.
  final int stayedCount;

  /// Local day with the most focus time. Null when nothing has been focused.
  final DayFocus? bestDay;
  final List<DayFocus> week;
  final List<LabelFocus> byLabel;
  final List<BlockListFocus> byList;
}

/// Totals, streak, and the last seven local days for [sessions] at [now].
///
/// Time from a session that crosses midnight is split across those days.
/// The streak is the run of days with focus time ending today, or yesterday
/// when today has none yet.
FocusStats summarizeFocus(List<FocusSession> sessions, DateTime now) {
  final current = now.toLocal();
  final today = DateTime(current.year, current.month, current.day);
  final weekStart = today.subtract(const Duration(days: 6));
  final tomorrow = today.add(const Duration(days: 1));
  final byDay = <DateTime, Duration>{};
  final lists = <String, _ListTally>{};
  final labels = <String, _LabelTally>{};
  var focused = Duration.zero;
  var longest = Duration.zero;
  var givenBack = Duration.zero;
  var weekSessions = 0;
  var todaySessions = 0;
  var timedSessions = 0;
  var finishedCount = 0;
  var endedEarlyCount = 0;
  var ranCount = 0;
  var stayedCount = 0;

  for (final session in sessions) {
    switch (session.outcome) {
      case SessionOutcome.created:
        break;
      case SessionOutcome.completed:
        finishedCount++;
        ranCount++;
        stayedCount++;
      case SessionOutcome.endedEarly:
        endedEarlyCount++;
        ranCount++;
        final planned = session.endsAt;
        final stopped = session.stoppedAt;
        if (planned != null && stopped != null && planned.isAfter(stopped)) {
          givenBack += planned.difference(stopped);
        }
      case SessionOutcome.active:
      case SessionOutcome.paused:
        ranCount++;
        stayedCount++;
    }

    final tally = lists.putIfAbsent(
      session.blockListId,
      () => _ListTally(session.blockListName, session.startedAt),
    );
    tally.sessions++;
    if (!session.startedAt.isBefore(tally.latestStart)) {
      tally.name = session.blockListName;
      tally.latestStart = session.startedAt;
    }

    final labelId = session.labelId;
    final labelName = session.labelName;
    _LabelTally? labelTally;
    if (session.hasLabel && labelId != null && labelName != null) {
      labelTally = labels.putIfAbsent(
        labelId,
        () =>
            _LabelTally(session.labelEmoji ?? '', labelName, session.startedAt),
      );
      labelTally.sessions++;
      if (!session.startedAt.isBefore(labelTally.latestStart)) {
        labelTally
          ..emoji = session.labelEmoji ?? ''
          ..name = labelName
          ..latestStart = session.startedAt;
      }
    }

    final end = _focusEnd(session, current);
    if (end == null) {
      final started = session.startedAt.toLocal();
      final startedDay = DateTime(started.year, started.month, started.day);
      if (!startedDay.isBefore(weekStart) && startedDay.isBefore(tomorrow)) {
        weekSessions++;
      }
      if (startedDay == today) todaySessions++;
      continue;
    }

    final span = end.difference(session.startedAt);
    focused += span;
    if (span > Duration.zero) timedSessions++;
    if (span > longest) longest = span;
    tally.focused += span;
    if (labelTally != null) labelTally.focused += span;

    var countedThisWeek = false;
    var countedToday = false;
    var cursor = session.startedAt.toLocal();
    final finish = end.toLocal();
    while (cursor.isBefore(finish)) {
      final day = DateTime(cursor.year, cursor.month, cursor.day);
      final next = day.add(const Duration(days: 1));
      final sliceEnd = finish.isBefore(next) ? finish : next;
      final slice = sliceEnd.difference(cursor);
      byDay[day] = (byDay[day] ?? Duration.zero) + slice;
      if (!day.isBefore(weekStart) && day.isBefore(tomorrow)) {
        countedThisWeek = true;
      }
      if (day == today) countedToday = true;
      cursor = sliceEnd;
    }
    if (countedThisWeek) weekSessions++;
    if (countedToday) todaySessions++;
  }

  final streakIncludesToday = (byDay[today] ?? Duration.zero) > Duration.zero;
  var streakDays = 0;
  var cursorDay = streakIncludesToday
      ? today
      : today.subtract(const Duration(days: 1));
  while ((byDay[cursorDay] ?? Duration.zero) > Duration.zero) {
    streakDays++;
    cursorDay = cursorDay.subtract(const Duration(days: 1));
  }

  final week = [
    for (var offset = 6; offset >= 0; offset--)
      DayFocus(
        day: today.subtract(Duration(days: offset)),
        focused: byDay[today.subtract(Duration(days: offset))] ?? Duration.zero,
      ),
  ];

  final byList =
      [
        for (final entry in lists.entries)
          BlockListFocus(
            id: entry.key,
            name: entry.value.name,
            focused: entry.value.focused,
            sessions: entry.value.sessions,
          ),
      ]..sort((a, b) {
        final byTime = b.focused.compareTo(a.focused);
        if (byTime != 0) return byTime;
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
  final byLabel =
      [
        for (final entry in labels.entries)
          LabelFocus(
            id: entry.key,
            emoji: entry.value.emoji,
            name: entry.value.name,
            focused: entry.value.focused,
            sessions: entry.value.sessions,
          ),
      ]..sort((a, b) {
        final byTime = b.focused.compareTo(a.focused);
        if (byTime != 0) return byTime;
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

  DayFocus? bestDay;
  for (final entry in byDay.entries) {
    if (entry.value <= Duration.zero) continue;
    final currentBest = bestDay;
    if (currentBest == null ||
        entry.value > currentBest.focused ||
        (entry.value == currentBest.focused &&
            entry.key.isAfter(currentBest.day))) {
      bestDay = DayFocus(day: entry.key, focused: entry.value);
    }
  }

  return FocusStats(
    focused: focused,
    sessionCount: sessions.length,
    finishedCount: finishedCount,
    endedEarlyCount: endedEarlyCount,
    streakDays: streakDays,
    streakIncludesToday: streakIncludesToday,
    longest: longest,
    average: timedSessions == 0
        ? Duration.zero
        : Duration(seconds: focused.inSeconds ~/ timedSessions),
    givenBack: givenBack,
    today: byDay[today] ?? Duration.zero,
    todaySessions: todaySessions,
    weekSessions: weekSessions,
    weekDays: week.where((day) => day.focused > Duration.zero).length,
    ranCount: ranCount,
    stayedCount: stayedCount,
    bestDay: bestDay,
    week: week,
    byLabel: byLabel,
    byList: byList,
  );
}

/// Whole minutes, or a short label when the span is under a minute.
String formatFocusTotal(Duration duration) {
  if (duration.inMinutes <= 0) {
    return duration.inSeconds > 0
        ? tr('duration_under_minute')
        : tr('duration_zero');
  }
  return formatSessionLength(duration);
}

DateTime? _focusEnd(FocusSession session, DateTime now) {
  switch (session.outcome) {
    case SessionOutcome.created:
      return null;
    case SessionOutcome.active:
      final planned = session.endsAt;
      final end = planned != null && !planned.isAfter(now) ? planned : now;
      return end.isAfter(session.startedAt) ? end : null;
    case SessionOutcome.paused:
      final held = session.pausedAt ?? now;
      final plannedPause = session.endsAt;
      final pausedEnd = plannedPause != null && !plannedPause.isAfter(held)
          ? plannedPause
          : held;
      return pausedEnd.isAfter(session.startedAt) ? pausedEnd : null;
    case SessionOutcome.completed:
    case SessionOutcome.endedEarly:
      final end = session.stoppedAt ?? session.endsAt;
      if (end == null || !end.isAfter(session.startedAt)) return null;
      return end;
  }
}

class _ListTally {
  _ListTally(this.name, this.latestStart);

  String name;
  DateTime latestStart;
  Duration focused = Duration.zero;
  var sessions = 0;
}

class _LabelTally {
  _LabelTally(this.emoji, this.name, this.latestStart);

  String emoji;
  String name;
  DateTime latestStart;
  Duration focused = Duration.zero;
  var sessions = 0;
}
