import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foqui/l10n/tr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foqui/widgets/block_list_app_line.dart';
import 'package:foqui/models/block_list.dart';
import 'package:foqui/models/focus_label.dart';
import 'package:foqui/models/focus_session.dart';
import 'package:foqui/models/focus_stats.dart';
import 'package:foqui/models/session_duration.dart';
import 'package:foqui/services/focus_repository.dart';
import 'package:foqui/services/focus_shield_bridge.dart';
import 'package:foqui/state/focus_controller.dart';

import 'memory_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadEnglishCatalog);

  final updatedAt = DateTime.utc(2026, 11, 7);

  test('app names fill the line until they would overflow', () {
    const style = TextStyle(fontSize: 14);
    const names = ['Twitter', 'TikTok', 'Instagram', 'YouTube'];
    expect(
      fitApplicationLine(
        count: 4,
        names: names,
        suffix: '',
        maxWidth: 4000,
        style: style,
      ),
      '4 apps: Twitter, TikTok, Instagram, YouTube',
    );
    expect(
      fitApplicationLine(
        count: 1,
        names: const ['Twitter'],
        suffix: ' · 1 category',
        maxWidth: 4000,
        style: style,
      ),
      '1 app: Twitter · 1 category',
    );
    expect(
      fitApplicationLine(
        count: 2,
        names: const [],
        suffix: '',
        maxWidth: 200,
        style: style,
      ),
      '2 apps',
    );

    final full = '4 apps: Twitter, TikTok, Instagram, YouTube';
    final painter = TextPainter(
      text: const TextSpan(
        text: '4 apps: Twitter, TikTok, Instagram, YouTube',
        style: style,
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    final tight = fitApplicationLine(
      count: 4,
      names: names,
      suffix: ' · 1 category',
      maxWidth: painter.width / 2,
      style: style,
    );
    expect(tight, contains('...'));
    expect(tight, isNot(contains('YouTube')));
    expect(tight.startsWith('4 apps:'), isTrue);
  });

  test('summary counts apps, categories, and websites', () {
    final list = BlockList(
      id: 'social',
      name: 'Social',
      applicationCount: 4,
      categoryCount: 1,
      webDomainCount: 2,
      updatedAt: updatedAt,
    );
    expect(list.summary, '4 apps · 1 category · 2 websites');
    expect(
      BlockList(
        id: 'empty',
        name: 'Empty',
        applicationCount: 0,
        categoryCount: 0,
        webDomainCount: 0,
        updatedAt: updatedAt,
      ).summary,
      'Nothing selected',
    );
  });

  test('clock and history labels', () {
    expect(formatRemaining(const Duration(minutes: 45)), '45:00');
    expect(
      formatRemaining(const Duration(hours: 1, minutes: 2, seconds: 3)),
      '1:02:03',
    );
    expect(formatRemaining(const Duration(seconds: -4)), '00:00');
    expect(formatSessionLength(const Duration(minutes: 90)), '1 hr 30 min');

    final now = DateTime(2026, 11, 7, 15);
    expect(
      formatSessionStamp(DateTime(2026, 11, 7, 9, 5), now),
      'Today · 09:05',
    );
    expect(
      formatSessionStamp(DateTime(2026, 11, 6, 18, 30), now),
      'Yesterday · 18:30',
    );
  });

  test('sessions that already ended are marked finished', () {
    final sessions = settleSessions([
      FocusSession(
        id: 'past',
        blockListId: 'list',
        blockListName: 'Social',
        startedAt: DateTime(2026, 1, 1, 10),
        endsAt: DateTime(2026, 1, 1, 10, 25),
        outcome: SessionOutcome.active,
      ),
      FocusSession(
        id: 'future',
        blockListId: 'list',
        blockListName: 'Social',
        startedAt: DateTime(2026, 11, 7, 10),
        endsAt: DateTime(2026, 11, 8, 10),
        outcome: SessionOutcome.active,
      ),
    ], DateTime(2026, 11, 7, 12));

    expect(sessions[0].outcome, SessionOutcome.completed);
    expect(sessions[0].stoppedAt, DateTime(2026, 1, 1, 10, 25));
    expect(sessions[1].outcome, SessionOutcome.active);

    final waiting = settleSessions([
      FocusSession(
        id: 'waiting',
        blockListId: 'list',
        blockListName: 'Social',
        startedAt: DateTime(2026, 1, 1, 10),
        endsAt: DateTime(2026, 1, 1, 10, 25),
        outcome: SessionOutcome.created,
      ),
    ], DateTime(2026, 11, 7, 12));
    expect(waiting.single.outcome, SessionOutcome.created);
    expect(waiting.single.outcomeLabel, 'Not started');

    final open = settleSessions([
      FocusSession(
        id: 'open',
        blockListId: 'list',
        blockListName: 'Social',
        startedAt: DateTime(2026, 1, 1, 10),
        outcome: SessionOutcome.active,
      ),
    ], DateTime(2026, 11, 7, 12));
    expect(open.single.outcome, SessionOutcome.active);
    expect(open.single.outcomeLabel, 'In progress');
    expect(
      open.single
          .copyWith(
            outcome: SessionOutcome.endedEarly,
            stoppedAt: DateTime(2026, 1, 1, 10, 40),
          )
          .outcomeLabel,
      'Ended',
    );
    expect(
      sessionLengthLabel(
        open.single.copyWith(stoppedAt: DateTime(2026, 1, 1, 11, 10)),
      ),
      '1 hr 10 min',
    );
  });

  test('two sessions have to run for more than a minute', () {
    final start = DateTime(2026, 11, 12, 9);
    FocusSession session({
      required String id,
      required Duration length,
      SessionOutcome outcome = SessionOutcome.completed,
      bool stillGoing = false,
    }) {
      return FocusSession(
        id: id,
        blockListId: 'list',
        blockListName: 'Work',
        startedAt: start,
        endsAt: stillGoing ? null : start.add(const Duration(minutes: 15)),
        stoppedAt: stillGoing ? null : start.add(length),
        outcome: stillGoing ? SessionOutcome.active : outcome,
      );
    }

    expect(sessionsStartedLongerThanOneMinute(const [], start), 0);
    expect(
      sessionsStartedLongerThanOneMinute([
        session(id: 'short', length: const Duration(seconds: 20)),
        session(
          id: 'exact',
          length: const Duration(minutes: 1),
          outcome: SessionOutcome.endedEarly,
        ),
      ], start.add(const Duration(hours: 1))),
      0,
    );
    expect(
      sessionsStartedLongerThanOneMinute([
        session(id: 'long', length: const Duration(minutes: 15)),
        session(
          id: 'bailed',
          length: const Duration(seconds: 20),
          outcome: SessionOutcome.endedEarly,
        ),
      ], start.add(const Duration(hours: 1))),
      1,
    );
    expect(
      sessionsStartedLongerThanOneMinute([
        session(id: 'one', length: const Duration(seconds: 61)),
        session(id: 'two', length: const Duration(minutes: 2)),
      ], start.add(const Duration(hours: 1))),
      2,
    );
    expect(
      sessionsStartedLongerThanOneMinute([
        session(id: 'live', length: Duration.zero, stillGoing: true),
      ], start.add(const Duration(seconds: 90))),
      1,
    );
    expect(
      sessionsStartedLongerThanOneMinute([
        session(id: 'live', length: Duration.zero, stillGoing: true),
      ], start.add(const Duration(seconds: 30))),
      0,
    );
  });

  test('a finished session under five minutes is not recorded', () {
    final start = DateTime(2026, 11, 18, 9);
    final now = start.add(const Duration(hours: 1));
    FocusSession finished({
      required String id,
      required Duration length,
      SessionOutcome outcome = SessionOutcome.endedEarly,
    }) {
      return FocusSession(
        id: id,
        blockListId: 'list',
        blockListName: 'Work',
        startedAt: start,
        endsAt: start.add(const Duration(minutes: 25)),
        stoppedAt: start.add(length),
        outcome: outcome,
      );
    }

    final kept = dropUnrecordedSessions([
      finished(id: 'brief', length: const Duration(seconds: 59)),
      finished(id: 'four', length: const Duration(minutes: 4)),
      finished(id: 'five', length: minimumRecordedLength),
      finished(
        id: 'done',
        length: const Duration(minutes: 25),
        outcome: SessionOutcome.completed,
      ),
      FocusSession(
        id: 'live',
        blockListId: 'list',
        blockListName: 'Work',
        startedAt: now.subtract(const Duration(seconds: 20)),
        outcome: SessionOutcome.active,
      ),
      FocusSession(
        id: 'held',
        blockListId: 'list',
        blockListName: 'Work',
        startedAt: start,
        pausedAt: start.add(const Duration(seconds: 10)),
        outcome: SessionOutcome.paused,
      ),
      FocusSession(
        id: 'waiting',
        blockListId: 'list',
        blockListName: 'Work',
        startedAt: start,
        outcome: SessionOutcome.created,
      ),
    ], now);

    expect(kept.map((session) => session.id), [
      'five',
      'done',
      'live',
      'held',
      'waiting',
    ]);
    expect(
      sessionMeetsRecordedLength(
        finished(id: 'four', length: const Duration(minutes: 4)),
        now,
      ),
      isFalse,
    );
    expect(
      sessionMeetsRecordedLength(
        finished(id: 'five', length: minimumRecordedLength),
        now,
      ),
      isTrue,
    );
    expect(
      sessionMeetsRecordedLength(
        FocusSession(
          id: 'held-short',
          blockListId: 'list',
          blockListName: 'Work',
          startedAt: start,
          pausedAt: start.add(const Duration(minutes: 2)),
          outcome: SessionOutcome.paused,
        ),
        now,
      ),
      isFalse,
    );
  });

  test('focus stats are empty without sessions', () {
    final stats = summarizeFocus(const [], DateTime(2026, 11, 11, 12));

    expect(stats.sessionCount, 0);
    expect(stats.focused, Duration.zero);
    expect(stats.streakDays, 0);
    expect(stats.streakIncludesToday, isFalse);
    expect(stats.week, hasLength(7));
    expect(stats.week.every((day) => day.focused == Duration.zero), isTrue);
    expect(stats.byList, isEmpty);
    expect(stats.byLabel, isEmpty);
    expect(stats.today, Duration.zero);
    expect(stats.todaySessions, 0);
    expect(stats.weekDays, 0);
    expect(stats.ranCount, 0);
    expect(stats.stayedCount, 0);
    expect(stats.average, Duration.zero);
    expect(stats.givenBack, Duration.zero);
    expect(stats.bestDay, isNull);
    expect(stats.byLabel, isEmpty);
    expect(stats.today, Duration.zero);
    expect(stats.todaySessions, 0);
    expect(stats.weekDays, 0);
    expect(stats.ranCount, 0);
    expect(stats.stayedCount, 0);
    expect(stats.average, Duration.zero);
    expect(stats.givenBack, Duration.zero);
    expect(stats.bestDay, isNull);
    expect(formatFocusTotal(Duration.zero), '0 min');
    expect(formatFocusTotal(const Duration(seconds: 30)), 'Under 1 min');
  });

  test('focus stats sum time, streak, and the last 7 days', () {
    final now = DateTime(2026, 11, 11, 15);
    final stats = summarizeFocus([
      FocusSession(
        id: 'monday',
        blockListId: 'work',
        blockListName: 'Work',
        startedAt: DateTime(2026, 11, 9, 9),
        endsAt: DateTime(2026, 11, 9, 10),
        stoppedAt: DateTime(2026, 11, 9, 10),
        outcome: SessionOutcome.completed,
      ),
      FocusSession(
        id: 'early',
        blockListId: 'social',
        blockListName: 'Social',
        startedAt: DateTime(2026, 11, 10, 18),
        endsAt: DateTime(2026, 11, 10, 19),
        stoppedAt: DateTime(2026, 11, 10, 18, 20),
        outcome: SessionOutcome.endedEarly,
      ),
      FocusSession(
        id: 'overnight',
        blockListId: 'work',
        blockListName: 'Work',
        startedAt: DateTime(2026, 11, 10, 23, 30),
        endsAt: DateTime(2026, 11, 11, 0, 30),
        stoppedAt: DateTime(2026, 11, 11, 0, 30),
        outcome: SessionOutcome.completed,
      ),
      FocusSession(
        id: 'live',
        blockListId: 'work',
        blockListName: 'Deep work',
        startedAt: DateTime(2026, 11, 11, 14, 30),
        endsAt: DateTime(2026, 11, 11, 16),
        outcome: SessionOutcome.active,
      ),
    ], now);

    expect(stats.focused, const Duration(minutes: 170));
    expect(stats.sessionCount, 4);
    expect(stats.finishedCount, 2);
    expect(stats.endedEarlyCount, 1);
    expect(stats.longest, const Duration(hours: 1));
    expect(stats.streakDays, 3);
    expect(stats.streakIncludesToday, isTrue);
    expect(stats.weekSessions, 4);
    expect(stats.week.last.day, DateTime(2026, 11, 11));
    expect(stats.week.last.focused, const Duration(minutes: 60));
    expect(stats.week[5].focused, const Duration(minutes: 50));
    expect(stats.week[4].focused, const Duration(hours: 1));
    expect(stats.byList.first.name, 'Deep work');
    expect(stats.byList.first.focused, const Duration(minutes: 150));
    expect(stats.byList.first.sessions, 3);
    expect(stats.byList.last.name, 'Social');
    expect(stats.byList.last.focused, const Duration(minutes: 20));
    expect(formatFocusTotal(stats.focused), '2 hr 50 min');
    expect(stats.today, const Duration(minutes: 60));
    expect(stats.todaySessions, 2);
    expect(stats.weekDays, 3);
    expect(stats.ranCount, 4);
    expect(stats.stayedCount, 3);
    expect(stats.average, const Duration(minutes: 42, seconds: 30));
    expect(stats.givenBack, const Duration(minutes: 40));
    expect(stats.bestDay?.day, DateTime(2026, 11, 11));
    expect(stats.bestDay?.focused, const Duration(minutes: 60));
    expect(stats.byLabel, isEmpty);
  });

  test('the streak reaches through yesterday and stops at a gap', () {
    final now = DateTime(2026, 11, 11, 8);
    final stats = summarizeFocus([
      FocusSession(
        id: 'old',
        blockListId: 'work',
        blockListName: 'Work',
        startedAt: DateTime(2026, 11, 8, 9),
        endsAt: DateTime(2026, 11, 8, 9, 25),
        stoppedAt: DateTime(2026, 11, 8, 9, 25),
        outcome: SessionOutcome.completed,
      ),
      FocusSession(
        id: 'yesterday',
        blockListId: 'work',
        blockListName: 'Work',
        startedAt: DateTime(2026, 11, 10, 9),
        endsAt: DateTime(2026, 11, 10, 9, 25),
        stoppedAt: DateTime(2026, 11, 10, 9, 25),
        outcome: SessionOutcome.completed,
      ),
    ], now);

    expect(stats.streakDays, 1);
    expect(stats.streakIncludesToday, isFalse);
    expect(stats.weekSessions, 2);

    final broken = summarizeFocus([
      FocusSession(
        id: 'gap',
        blockListId: 'work',
        blockListName: 'Work',
        startedAt: DateTime(2026, 11, 9, 9),
        endsAt: DateTime(2026, 11, 9, 9, 25),
        stoppedAt: DateTime(2026, 11, 9, 9, 25),
        outcome: SessionOutcome.completed,
      ),
    ], now);
    expect(broken.streakDays, 0);
    expect(broken.streakIncludesToday, isFalse);
  });

  test('an open session counts the time so far', () {
    final now = DateTime(2026, 11, 11, 12);
    final stats = summarizeFocus([
      FocusSession(
        id: 'open',
        blockListId: 'work',
        blockListName: 'Work',
        startedAt: DateTime(2026, 11, 11, 11, 20),
        outcome: SessionOutcome.active,
      ),
    ], now);

    expect(stats.focused, const Duration(minutes: 40));
    expect(stats.finishedCount, 0);
    expect(stats.endedEarlyCount, 0);
    expect(stats.streakIncludesToday, isTrue);
    expect(stats.longest, const Duration(minutes: 40));
    expect(stats.stayedCount, 1);
    expect(stats.givenBack, Duration.zero);
  });

  test('focus time is kept under the label it was for', () {
    final now = DateTime(2026, 11, 11, 18);
    final stats = summarizeFocus([
      FocusSession(
        id: 'study-old',
        blockListId: 'work',
        blockListName: 'Work',
        startedAt: DateTime(2026, 11, 10, 9),
        endsAt: DateTime(2026, 11, 10, 9, 50),
        stoppedAt: DateTime(2026, 11, 10, 9, 50),
        outcome: SessionOutcome.completed,
        labelId: 'study-session',
        labelEmoji: '📚',
        labelName: 'study session',
      ),
      FocusSession(
        id: 'study-new',
        blockListId: 'work',
        blockListName: 'Work',
        startedAt: DateTime(2026, 11, 11, 10),
        endsAt: DateTime(2026, 11, 11, 10, 25),
        stoppedAt: DateTime(2026, 11, 11, 10, 25),
        outcome: SessionOutcome.completed,
        labelId: 'study-session',
        labelEmoji: '📖',
        labelName: 'Study',
      ),
      FocusSession(
        id: 'family',
        blockListId: 'home',
        blockListName: 'Home',
        startedAt: DateTime(2026, 11, 11, 16),
        endsAt: DateTime(2026, 11, 11, 17),
        stoppedAt: DateTime(2026, 11, 11, 16, 40),
        outcome: SessionOutcome.endedEarly,
        labelId: 'family-time',
        labelEmoji: '🏡',
        labelName: 'family time',
      ),
      FocusSession(
        id: 'plain',
        blockListId: 'work',
        blockListName: 'Work',
        startedAt: DateTime(2026, 11, 11, 12),
        endsAt: DateTime(2026, 11, 11, 12, 15),
        stoppedAt: DateTime(2026, 11, 11, 12, 15),
        outcome: SessionOutcome.completed,
      ),
    ], now);

    expect(stats.byLabel, hasLength(2));
    expect(stats.byLabel.first.id, 'study-session');
    expect(stats.byLabel.first.name, 'Study');
    expect(stats.byLabel.first.emoji, '📖');
    expect(stats.byLabel.first.focused, const Duration(minutes: 75));
    expect(stats.byLabel.first.sessions, 2);
    expect(stats.byLabel.last.name, 'family time');
    expect(stats.byLabel.last.focused, const Duration(minutes: 40));
    expect(stats.focused, const Duration(minutes: 130));
    expect(stats.givenBack, const Duration(minutes: 20));
  });

  test('duration stays inside the Screen Time window', () {
    expect(clampSessionMinutes(5), minSessionMinutes);
    expect(clampSessionMinutes(200), maxSessionMinutes);
    expect(clampSessionMinutes(25), 25);
  });

  test('stored lists and sessions round-trip through json', () {
    final list = BlockList(
      id: 'deep',
      name: 'Deep work',
      applicationCount: 2,
      categoryCount: 0,
      webDomainCount: 1,
      updatedAt: updatedAt,
    );
    final session = FocusSession(
      id: 'session',
      blockListId: 'deep',
      blockListName: 'Deep work',
      startedAt: updatedAt,
      endsAt: updatedAt.add(const Duration(minutes: 25)),
      outcome: SessionOutcome.completed,
      stoppedAt: updatedAt.add(const Duration(minutes: 25)),
    );
    final open = FocusSession(
      id: 'open',
      blockListId: 'deep',
      blockListName: 'Deep work',
      startedAt: updatedAt,
      outcome: SessionOutcome.active,
    );

    final lists = decodeBlockLists(jsonEncode([list.toJson()]));
    final sessions = decodeSessions(jsonEncode([session.toJson()]));

    expect(lists.single.name, 'Deep work');
    expect(lists.single.webDomainCount, 1);
    expect(lists.single.isFavorite, isFalse);
    expect(lists.single.applicationNames, isEmpty);
    expect(sessions.single.outcome, SessionOutcome.completed);
    expect(sessions.single.labelId, isNull);
    expect(FocusSession.fromJson(open.toJson()).endsAt, isNull);

    final labeled = session.copyWith(
      labelId: 'deep-work',
      labelEmoji: '🧠',
      labelName: 'deep work',
    );
    final restored = FocusSession.fromJson(labeled.toJson());
    expect(restored.labelId, 'deep-work');
    expect(restored.labelEmoji, '🧠');
    expect(restored.labelName, 'deep work');
    expect(restored.hasLabel, isTrue);
    expect(decodeBlockLists('not json'), isEmpty);
    expect(decodeSessions('not json'), isEmpty);
  });

  test('an expired session is settled when the app loads', () {
    final repository = MemoryFocusRepository(
      sessions: [
        FocusSession(
          id: 'past',
          blockListId: 'list',
          blockListName: 'Social',
          startedAt: DateTime(2026, 1, 1, 10),
          endsAt: DateTime(2026, 1, 1, 10, 25),
          outcome: SessionOutcome.active,
        ),
      ],
    );
    final container = ProviderContainer(
      overrides: [focusRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    final state = container.read(focusControllerProvider);
    expect(state.sessions.single.outcome, SessionOutcome.completed);
    expect(repository.sessions.single.outcome, SessionOutcome.completed);
    expect(state.activeSession, isNull);
  });

  test('a created session can start later', () async {
    final repository = MemoryFocusRepository(
      lists: [
        BlockList(
          id: 'social',
          name: 'Social',
          applicationCount: 1,
          categoryCount: 0,
          webDomainCount: 0,
          updatedAt: DateTime.utc(2026, 1, 1),
        ),
      ],
    );
    final container = ProviderContainer(
      overrides: [
        focusRepositoryProvider.overrideWithValue(repository),
        focusShieldBridgeProvider.overrideWithValue(_ApprovingShield()),
      ],
    );
    addTearDown(container.dispose);
    container.read(focusControllerProvider);

    await container
        .read(focusControllerProvider.notifier)
        .createSession(listId: 'social', minutes: 25);

    final created = container.read(focusControllerProvider);
    expect(created.activeSession, isNull);
    expect(created.sessions.single.outcome, SessionOutcome.created);
    expect(
      created.sessions.single.endsAt!.difference(
        created.sessions.single.startedAt,
      ),
      const Duration(minutes: 25),
    );
    expect(created.sessions.single.labelId, 'focus-time');
    expect(created.sessions.single.labelName, 'Focus Time');

    final study = created.labels.firstWhere(
      (label) => label.id == 'study-session',
    );
    await container
        .read(focusControllerProvider.notifier)
        .setSessionLabel(sessionId: created.sessions.single.id, label: study);
    expect(
      container.read(focusControllerProvider).sessions.single.labelName,
      'Study session',
    );

    await container
        .read(focusControllerProvider.notifier)
        .startSession(sessionId: created.sessions.single.id);

    final started = container.read(focusControllerProvider);
    expect(started.sessions, hasLength(1));
    expect(started.sessions.single.id, created.sessions.single.id);
    expect(started.activeSession?.outcome, SessionOutcome.active);
    expect(started.activeSession?.labelId, 'study-session');
    expect(started.activeSession?.labelEmoji, '📚');
    expect(started.activeSession?.blockListId, 'social');
    expect(repository.sessions.single.outcome, SessionOutcome.active);
  });

  test('a session keeps the label chosen up front', () async {
    final repository = MemoryFocusRepository(
      lists: [
        BlockList(
          id: 'social',
          name: 'Social',
          applicationCount: 1,
          categoryCount: 0,
          webDomainCount: 0,
          updatedAt: DateTime.utc(2026, 1, 1),
        ),
      ],
    );
    final container = ProviderContainer(
      overrides: [
        focusRepositoryProvider.overrideWithValue(repository),
        focusShieldBridgeProvider.overrideWithValue(_ApprovingShield()),
      ],
    );
    addTearDown(container.dispose);
    final controller = container.read(focusControllerProvider.notifier);
    final study = container
        .read(focusControllerProvider)
        .labels
        .firstWhere((label) => label.id == 'study-session');

    await controller.createSession(listId: 'social', minutes: 25, label: study);
    expect(
      container.read(focusControllerProvider).sessions.single.labelId,
      'study-session',
    );
    expect(
      container.read(focusControllerProvider).sessions.single.labelName,
      'Study session',
    );

    await controller.discardSession(
      container.read(focusControllerProvider).sessions.single.id,
    );
    await controller.startSession(listId: 'social', minutes: 25, label: study);

    final started = container.read(focusControllerProvider).activeSession;
    expect(started?.labelId, 'study-session');
    expect(started?.labelEmoji, '📚');
    expect(started?.labelName, 'Study session');
    expect(repository.sessions.single.labelId, 'study-session');
  });

  test('a session starts when Screen Time is unavailable', () async {
    final repository = MemoryFocusRepository(
      lists: [
        BlockList(
          id: 'social',
          name: 'Social',
          applicationCount: 1,
          categoryCount: 0,
          webDomainCount: 0,
          updatedAt: DateTime.utc(2026, 1, 1),
        ),
      ],
    );
    final container = ProviderContainer(
      overrides: [focusRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    await container
        .read(focusControllerProvider.notifier)
        .startSession(listId: 'social', minutes: 25);

    final started = container.read(focusControllerProvider).activeSession;
    expect(started?.outcome, SessionOutcome.active);
    expect(started?.blockListId, 'social');
    expect(repository.sessions.single.outcome, SessionOutcome.active);
  });

  test('a shield failure still leaves the session running', () async {
    final repository = MemoryFocusRepository(
      lists: [
        BlockList(
          id: 'social',
          name: 'Social',
          applicationCount: 1,
          categoryCount: 0,
          webDomainCount: 0,
          updatedAt: DateTime.utc(2026, 1, 1),
        ),
      ],
    );
    final container = ProviderContainer(
      overrides: [
        focusRepositoryProvider.overrideWithValue(repository),
        focusShieldBridgeProvider.overrideWithValue(_ScheduleFailingShield()),
      ],
    );
    addTearDown(container.dispose);

    await container
        .read(focusControllerProvider.notifier)
        .startSession(listId: 'social', minutes: 25);

    expect(
      container.read(focusControllerProvider).activeSession?.outcome,
      SessionOutcome.active,
    );
  });

  test('a list without apps saved on this device loses its counts', () async {
    final repository = MemoryFocusRepository(
      lists: [
        BlockList(
          id: 'social',
          name: 'Social',
          applicationCount: 6,
          categoryCount: 0,
          webDomainCount: 2,
          applicationNames: const ['Maps'],
          updatedAt: DateTime.utc(2026, 1, 1),
          isFavorite: true,
        ),
      ],
    );
    final container = ProviderContainer(
      overrides: [
        focusRepositoryProvider.overrideWithValue(repository),
        focusShieldBridgeProvider.overrideWithValue(_NoStoredSelection()),
      ],
    );
    addTearDown(container.dispose);
    container.read(focusControllerProvider);
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    final list = container.read(focusControllerProvider).lists.single;
    expect(container.read(focusControllerProvider).selectionsReady, isTrue);
    expect(list.name, 'Social');
    expect(list.isFavorite, isTrue);
    expect(list.isEmpty, isTrue);
    expect(list.applicationNames, isEmpty);
    expect(repository.lists.single.isEmpty, isTrue);
  });

  test('Screen Time must be allowed before a session starts', () async {
    final repository = MemoryFocusRepository(
      lists: [
        BlockList(
          id: 'social',
          name: 'Social',
          applicationCount: 1,
          categoryCount: 0,
          webDomainCount: 0,
          updatedAt: DateTime.utc(2026, 1, 1),
        ),
      ],
    );
    final container = ProviderContainer(
      overrides: [
        focusRepositoryProvider.overrideWithValue(repository),
        focusShieldBridgeProvider.overrideWithValue(_DeniedShield()),
      ],
    );
    addTearDown(container.dispose);

    await expectLater(
      container
          .read(focusControllerProvider.notifier)
          .startSession(listId: 'social', minutes: 25),
      throwsA(
        isA<FocusShieldException>().having(
          (error) => error.code,
          'code',
          'NOT_AUTHORIZED',
        ),
      ),
    );
    expect(container.read(focusControllerProvider).activeSession, isNull);
    expect(repository.sessions, isEmpty);
  });

  test('only one block list can be the default', () async {
    final updated = DateTime.utc(2026, 11, 7);
    final repository = MemoryFocusRepository(
      lists: [
        BlockList(
          id: 'work',
          name: 'Work',
          applicationCount: 1,
          categoryCount: 0,
          webDomainCount: 0,
          updatedAt: updated,
        ),
        BlockList(
          id: 'social',
          name: 'Social',
          applicationCount: 2,
          categoryCount: 0,
          webDomainCount: 0,
          updatedAt: updated,
          isFavorite: true,
        ),
      ],
    );
    final container = ProviderContainer(
      overrides: [focusRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    final controller = container.read(focusControllerProvider.notifier);
    expect(container.read(focusControllerProvider).favoriteList?.id, 'social');

    await controller.setFavorite('work');
    expect(container.read(focusControllerProvider).favoriteList?.id, 'work');
    expect(
      container
          .read(focusControllerProvider)
          .lists
          .where((list) => list.isFavorite)
          .map((list) => list.id),
      ['work'],
    );

    await controller.setFavorite('work');
    expect(container.read(focusControllerProvider).favoriteList, isNull);

    await controller.setFavorite('social');
    await controller.upsertList(
      BlockList(
        id: 'social',
        name: 'Socials',
        applicationCount: 2,
        categoryCount: 0,
        webDomainCount: 0,
        updatedAt: updated.add(const Duration(minutes: 1)),
      ),
    );
    expect(
      container.read(focusControllerProvider).favoriteList?.name,
      'Socials',
    );
    expect(repository.lists.where((list) => list.isFavorite).length, 1);
  });

  test('a created label is kept after the built-in ones', () async {
    final repository = MemoryFocusRepository();
    final container = ProviderContainer(
      overrides: [focusRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    expect(
      container.read(focusControllerProvider).labels.map((label) => label.name),
      [
        'Focus Time',
        'Study session',
        'Deep work',
        'Couple time',
        'Family time',
      ],
    );

    await container
        .read(focusControllerProvider.notifier)
        .addLabel(emoji: '📖', name: 'Reading');

    final labels = container.read(focusControllerProvider).labels;
    expect(labels.last.name, 'Reading');
    expect(labels.last.emoji, '📖');
    expect(repository.labels.single.name, 'Reading');
    expect(repository.labels.single.emoji, '📖');
  });

  test('a built-in label cannot be edited or deleted', () async {
    final repository = MemoryFocusRepository(
      sessions: [
        FocusSession(
          id: 'study',
          blockListId: 'social',
          blockListName: 'Social',
          startedAt: DateTime.utc(2026, 11, 18, 9),
          stoppedAt: DateTime.utc(2026, 11, 18, 9, 30),
          outcome: SessionOutcome.completed,
          labelId: 'study-session',
          labelEmoji: '📚',
          labelName: 'Study session',
        ),
      ],
    );
    final container = ProviderContainer(
      overrides: [focusRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    final controller = container.read(focusControllerProvider.notifier);

    await controller.updateLabel(
      id: 'study-session',
      emoji: '✏️',
      name: 'homework',
    );
    await controller.deleteLabel('study-session');
    await controller.deleteLabel(focusTimeLabelId);

    expect(
      container.read(focusControllerProvider).labels.map((label) => label.name),
      [
        'Focus Time',
        'Study session',
        'Deep work',
        'Couple time',
        'Family time',
      ],
    );
    expect(repository.labels, isEmpty);
    final session = container.read(focusControllerProvider).sessions.single;
    expect(session.labelId, 'study-session');
    expect(session.labelEmoji, '📚');
    expect(session.labelName, 'Study session');
  });

  test(
    'editing a label the user created renames past sessions',
    () async {
      final repository = MemoryFocusRepository(
        labels: [
          FocusLabel(
            id: 'reading',
            emoji: '📖',
            name: 'Reading',
            createdAt: DateTime.utc(2026, 11, 1),
          ),
        ],
        sessions: [
          FocusSession(
            id: 'reading',
            blockListId: 'social',
            blockListName: 'Social',
            startedAt: DateTime.utc(2026, 11, 18, 9),
            stoppedAt: DateTime.utc(2026, 11, 18, 9, 30),
            outcome: SessionOutcome.completed,
            labelId: 'reading',
            labelEmoji: '📖',
            labelName: 'Reading',
          ),
        ],
      );
      final container = ProviderContainer(
        overrides: [focusRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);

      await container
          .read(focusControllerProvider.notifier)
          .updateLabel(id: 'reading', emoji: '✏️', name: 'homework');

      final labels = container.read(focusControllerProvider).labels;
      expect(labels.map((label) => label.name), [
        'Focus Time',
        'Study session',
        'Deep work',
        'Couple time',
        'Family time',
        'Homework',
      ]);
      expect(labels.last.id, 'reading');
      expect(labels.last.emoji, '✏️');
      expect(repository.labels.single.name, 'Homework');
      expect(
        container.read(focusControllerProvider).sessions.single.labelName,
        'Homework',
      );
      expect(repository.sessions.single.labelEmoji, '✏️');
    },
  );

  test(
    'deleting a label moves its sessions to Focus Time and hides it',
    () async {
      final repository = MemoryFocusRepository(
        labels: [
          FocusLabel(
            id: 'reading',
            emoji: '📖',
            name: 'Reading',
            createdAt: DateTime.utc(2026, 11, 1),
          ),
        ],
        sessions: [
          FocusSession(
            id: 'reading',
            blockListId: 'social',
            blockListName: 'Social',
            startedAt: DateTime.utc(2026, 11, 18, 9),
            stoppedAt: DateTime.utc(2026, 11, 18, 9, 40),
            outcome: SessionOutcome.completed,
            labelId: 'reading',
            labelEmoji: '📖',
            labelName: 'Reading',
          ),
          FocusSession(
            id: 'study',
            blockListId: 'social',
            blockListName: 'Social',
            startedAt: DateTime.utc(2026, 11, 18, 11),
            stoppedAt: DateTime.utc(2026, 11, 18, 12),
            outcome: SessionOutcome.completed,
            labelId: 'study-session',
            labelEmoji: '📚',
            labelName: 'Study session',
          ),
          FocusSession(
            id: 'deep',
            blockListId: 'social',
            blockListName: 'Social',
            startedAt: DateTime.utc(2026, 11, 18, 13),
            stoppedAt: DateTime.utc(2026, 11, 18, 14),
            outcome: SessionOutcome.completed,
            labelId: 'deep-work',
            labelEmoji: '🧠',
            labelName: 'Deep work',
          ),
        ],
      );
      final container = ProviderContainer(
        overrides: [focusRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      final controller = container.read(focusControllerProvider.notifier);

      await controller.deleteLabel('reading');

      final afterCustom = container.read(focusControllerProvider);
      expect(
        afterCustom.labels.map((label) => label.id),
        isNot(contains('reading')),
      );
      expect(repository.labels, isEmpty);
      final moved = afterCustom.sessions.singleWhere(
        (session) => session.id == 'reading',
      );
      expect(moved.labelId, focusTimeLabelId);
      expect(moved.labelEmoji, '🎯');
      expect(moved.labelName, 'Focus Time');

      await controller.deleteLabel('study-session');

      final labels = container.read(focusControllerProvider).labels;
      expect(labels.map((label) => label.id), [
        focusTimeLabelId,
        'study-session',
        'deep-work',
        'couple-time',
        'family-time',
      ]);
      final study = container
          .read(focusControllerProvider)
          .sessions
          .singleWhere((session) => session.id == 'study');
      expect(study.labelId, 'study-session');
      expect(study.labelName, 'Study session');
      final deep = container
          .read(focusControllerProvider)
          .sessions
          .singleWhere((session) => session.id == 'deep');
      expect(deep.labelId, 'deep-work');
      expect(deep.labelName, 'Deep work');

      await controller.deleteLabel(focusTimeLabelId);
      expect(
        container.read(focusControllerProvider).labels.first.id,
        focusTimeLabelId,
      );
    },
  );

  test('ending a session under a minute leaves no record', () async {
    final now = DateTime.now();
    final repository = MemoryFocusRepository(
      sessions: [
        FocusSession(
          id: 'brief',
          blockListId: 'social',
          blockListName: 'Social',
          startedAt: now.subtract(const Duration(seconds: 20)),
          endsAt: now.add(const Duration(minutes: 25)),
          outcome: SessionOutcome.active,
        ),
      ],
    );
    final container = ProviderContainer(
      overrides: [focusRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    await container.read(focusControllerProvider.notifier).endSession();

    expect(container.read(focusControllerProvider).sessions, isEmpty);
    expect(repository.sessions, isEmpty);
    expect(container.read(focusControllerProvider).activeSession, isNull);
  });

  test('ending a session of four minutes leaves no record', () async {
    final now = DateTime.now();
    final repository = MemoryFocusRepository(
      sessions: [
        FocusSession(
          id: 'brief',
          blockListId: 'social',
          blockListName: 'Social',
          startedAt: now.subtract(const Duration(minutes: 4)),
          endsAt: now.add(const Duration(minutes: 21)),
          outcome: SessionOutcome.active,
        ),
      ],
    );
    final container = ProviderContainer(
      overrides: [focusRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    await container.read(focusControllerProvider.notifier).endSession();

    expect(container.read(focusControllerProvider).sessions, isEmpty);
    expect(repository.sessions, isEmpty);
  });

  test('ending a session of five minutes keeps the record', () async {
    final now = DateTime.now();
    final repository = MemoryFocusRepository(
      sessions: [
        FocusSession(
          id: 'kept',
          blockListId: 'social',
          blockListName: 'Social',
          startedAt: now.subtract(minimumRecordedLength),
          endsAt: now.add(const Duration(minutes: 20)),
          outcome: SessionOutcome.active,
        ),
      ],
    );
    final container = ProviderContainer(
      overrides: [focusRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    await container.read(focusControllerProvider.notifier).endSession();

    final saved = container.read(focusControllerProvider).sessions.single;
    expect(saved.id, 'kept');
    expect(saved.outcome, SessionOutcome.endedEarly);
    expect(repository.sessions.single.outcome, SessionOutcome.endedEarly);
  });

  test('a stored session under five minutes is dropped on load', () {
    final start = DateTime(2026, 11, 18, 9);
    final repository = MemoryFocusRepository(
      sessions: [
        FocusSession(
          id: 'brief',
          blockListId: 'social',
          blockListName: 'Social',
          startedAt: start,
          endsAt: start.add(const Duration(minutes: 25)),
          stoppedAt: start.add(const Duration(seconds: 40)),
          outcome: SessionOutcome.endedEarly,
        ),
        FocusSession(
          id: 'kept',
          blockListId: 'social',
          blockListName: 'Social',
          startedAt: start,
          endsAt: start.add(const Duration(minutes: 25)),
          stoppedAt: start.add(minimumRecordedLength),
          outcome: SessionOutcome.completed,
        ),
      ],
    );
    final container = ProviderContainer(
      overrides: [focusRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    final sessions = container.read(focusControllerProvider).sessions;
    expect(sessions.single.id, 'kept');
    expect(repository.sessions.single.id, 'kept');
  });

  test('pausing holds the clock and resuming continues it', () async {
    final repository = MemoryFocusRepository(
      lists: [
        BlockList(
          id: 'social',
          name: 'Social',
          applicationCount: 1,
          categoryCount: 0,
          webDomainCount: 0,
          updatedAt: DateTime.utc(2026, 1, 1),
        ),
      ],
    );
    final container = ProviderContainer(
      overrides: [
        focusRepositoryProvider.overrideWithValue(repository),
        focusShieldBridgeProvider.overrideWithValue(_ApprovingShield()),
      ],
    );
    addTearDown(container.dispose);
    final controller = container.read(focusControllerProvider.notifier);
    await controller.startSession(listId: 'social', minutes: 25);

    final running = container.read(focusControllerProvider).activeSession!;
    await controller.pauseSession();

    final paused = container.read(focusControllerProvider);
    expect(paused.activeSession, isNull);
    expect(paused.foregroundSession?.outcome, SessionOutcome.paused);
    expect(paused.foregroundSession?.pausedAt, isNotNull);
    expect(paused.foregroundSession?.endsAt, running.endsAt);
    expect(repository.sessions.single.outcome, SessionOutcome.paused);

    await Future<void>.delayed(const Duration(milliseconds: 20));
    await controller.resumeSession();

    final resumed = container.read(focusControllerProvider).activeSession!;
    expect(resumed.outcome, SessionOutcome.active);
    expect(resumed.pausedAt, isNull);
    expect(
      resumed.endsAt!.difference(resumed.startedAt),
      running.endsAt!.difference(running.startedAt),
    );
    expect(
      resumed.endsAt!.difference(running.endsAt!),
      greaterThan(Duration.zero),
    );
  });
}

class _NoStoredSelection extends FocusShieldBridge {
  @override
  bool get storesSelections => true;

  @override
  Future<Map<String, SelectionCounts>?> storedSelections(
    List<String> listIds,
  ) async {
    return const {};
  }

  @override
  Future<void> stopSession() async {}
}

class _ScheduleFailingShield extends _ApprovingShield {
  @override
  Future<void> startSession({
    required String listId,
    DateTime? endsAt,
    bool strict = true,
  }) async {
    throw const FocusShieldException('DEVICE_ACTIVITY', 'schedule failed');
  }
}

class _DeniedShield extends FocusShieldBridge {
  @override
  Future<FamilyControlsAuthorization> status() async {
    return FamilyControlsAuthorization.denied;
  }

  @override
  Future<FamilyControlsAuthorization> requestAuthorization() async {
    return FamilyControlsAuthorization.denied;
  }
}

class _ApprovingShield extends FocusShieldBridge {
  @override
  Future<FamilyControlsAuthorization> status() async {
    return FamilyControlsAuthorization.approved;
  }

  @override
  Future<FamilyControlsAuthorization> requestAuthorization() async {
    return FamilyControlsAuthorization.approved;
  }

  @override
  Future<void> startSession({
    required String listId,
    DateTime? endsAt,
    bool strict = true,
  }) async {}
}
