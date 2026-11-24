import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foqui/l10n/tr.dart';
import 'package:foqui/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foqui/models/block_list.dart';
import 'package:foqui/models/focus_label.dart';
import 'package:foqui/models/focus_session.dart';
import 'package:foqui/models/session_chat.dart';
import 'package:foqui/models/shared_session.dart';
import 'package:foqui/repositories/invite.dart';
import 'package:foqui/screens/block_lists_screen.dart';
import 'package:foqui/screens/home_screen.dart';
import 'package:foqui/services/focus_shield_bridge.dart';
import 'package:foqui/widgets/screen_header.dart';
import 'package:foqui/state/auth.dart';
import 'package:foqui/state/focus_controller.dart';
import 'package:foqui/widgets/block_list_app_line.dart';
import 'package:foqui/theme/app_theme.dart';
import 'package:foqui/widgets/session_live_activity.dart';
import 'package:foqui/widgets/sheet_header.dart';
import 'package:foqui/widgets/surface_card.dart';

import 'memory_repository.dart';

class LoggedInAuthNotifier extends AuthNotifier {
  @override
  Auth build() {
    return const Auth(loginState: LoginState.loggedIn, userId: 'test-user');
  }
}

class LoggedOutAuthNotifier extends AuthNotifier {
  @override
  Auth build() => const Auth(loginState: LoginState.loggedOut);
}

class _PendingAuthorization extends AuthorizationNotifier {
  @override
  Future<FamilyControlsAuthorization> build() async {
    return FamilyControlsAuthorization.notDetermined;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    await loadEnglishCatalog();
  });

  testWidgets('starting a session asks for duration and a block list', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(MemoryFocusRepository()),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    expect(find.text('Foqui'), findsOneWidget);
    expect(
      find.image(const AssetImage('assets/images/foqui.png')),
      findsNWidgets(2),
    );
    expect(find.text('No sessions yet'), findsOneWidget);
    expect(find.text('Start one and it will show up here.'), findsOneWidget);
    expect(
      find.widgetWithText(FilledButton, 'Start a session'),
      findsOneWidget,
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Start a session'));
    await pumpTransitions(tester);
    expect(find.text('Duration'), findsOneWidget);
    Navigator.of(
      tester.element(find.text('Duration')),
      rootNavigator: true,
    ).pop();
    await pumpTransitions(tester);
    expect(find.text('Duration'), findsNothing);
    expect(find.byTooltip('Home'), findsOneWidget);
    expect(find.byTooltip('Stats'), findsOneWidget);
    expect(find.byTooltip('Friends'), findsOneWidget);
    expect(find.byTooltip('Block lists'), findsOneWidget);
    expect(find.byTooltip('Start Focus'), findsOneWidget);
    expect(find.text('No active session'), findsNothing);
    expect(
      find.descendant(
        of: find.byType(HomeScreen),
        matching: find.byTooltip('Start Focus'),
      ),
      findsNothing,
    );

    await tester.tap(find.byTooltip('Start Focus'));
    await pumpTransitions(tester);

    expect(find.text('Duration'), findsOneWidget);
    expect(find.text('Label'), findsOneWidget);
    expect(find.text('Focus Time'), findsOneWidget);
    expect(find.text('Block list'), findsOneWidget);
    expect(find.text('Until I end it'), findsOneWidget);
    expect(find.text('None'), findsOneWidget);
    expect(find.text('15 min'), findsOneWidget);
    expect(find.text('90 min'), findsOneWidget);
    expect(find.text('New list'), findsNothing);
    expect(find.text('New label'), findsNothing);
    expect(find.widgetWithText(FilledButton, 'Start Session'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'Create Session'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(
            find.widgetWithText(FilledButton, 'Start Session'),
          )
          .onPressed,
      isNotNull,
    );
    expect(
      tester
          .widget<TextButton>(find.widgetWithText(TextButton, 'Create Session'))
          .onPressed,
      isNotNull,
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Start Session'));
    await pumpTransitions(tester);

    expect(find.byTooltip('New list'), findsOneWidget);
    expect(find.text('New list'), findsNothing);

    Navigator.of(
      tester.element(find.byTooltip('New list')),
      rootNavigator: true,
    ).pop();
    await pumpTransitions(tester);

    await tester.tap(find.byTooltip('Friends'));
    await pumpTransitions(tester);
    expect(
      find.text('No friends yet. People you focus with will show up here.'),
      findsOneWidget,
    );

    await tester.tap(find.byTooltip('Stats'));
    await pumpTransitions(tester);
    expect(
      find.text('No sessions yet. Time you spend focusing will show up here.'),
      findsOneWidget,
    );

    await tester.tap(find.byTooltip('Block lists'));
    await pumpTransitions(tester);

    expect(find.text('Default'), findsOneWidget);
    expect(find.text('Nothing selected'), findsOneWidget);
    expect(
      find.text('No lists yet. Add the apps you want Foqui to shield.'),
      findsNothing,
    );

    await tester.tap(find.byTooltip('What is a block list?'));
    await pumpTransitions(tester);

    expect(find.textContaining('set of apps'), findsOneWidget);
  });

  testWidgets('starting without Screen Time explains why Foqui will not work', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(MemoryFocusRepository()),
          authorizationProvider.overrideWith(_PendingAuthorization.new),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    expect(
      find.textContaining("Foqui won't work without Screen Time permissions."),
      findsOneWidget,
    );
    expect(
      find.widgetWithText(FilledButton, 'Allow Screen Time permissions'),
      findsOneWidget,
    );

    await tester.tap(find.byTooltip('Start Focus'));
    await pumpTransitions(tester);

    expect(find.text('Duration'), findsNothing);
    expect(find.text('Allow Screen Time permissions'), findsWidgets);
    expect(
      find.textContaining('those permissions are the only way that happens.'),
      findsOneWidget,
    );
    expect(
      find.text(
        'Apps, categories, and websites on your block list stay shielded.',
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        'They stay blocked until the timer ends, even after you leave Foqui.',
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        'Screen Time permissions are only used for the lists you choose.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('block lists are separate cards and one can be the default', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final updatedAt = DateTime.utc(2026, 11, 7);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(
            MemoryFocusRepository(
              lists: [
                BlockList(
                  id: 'social',
                  name: 'Social',
                  applicationCount: 4,
                  categoryCount: 0,
                  webDomainCount: 0,
                  updatedAt: updatedAt,
                  applicationNames: const [
                    'Twitter',
                    'TikTok',
                    'Instagram',
                    'YouTube',
                  ],
                  isFavorite: true,
                ),
                BlockList(
                  id: 'work',
                  name: 'Work',
                  applicationCount: 1,
                  categoryCount: 0,
                  webDomainCount: 0,
                  updatedAt: updatedAt,
                  applicationNames: const ['Mail'],
                ),
              ],
            ),
          ),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    await tester.tap(find.byTooltip('Block lists'));
    await pumpTransitions(tester);

    expect(find.text('Social'), findsOneWidget);
    expect(find.text('Work'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(BlockListsScreen),
        matching: find.byType(SurfaceCard),
      ),
      findsNWidgets(3),
    );
    expect(
      find.descendant(
        of: find.byType(BlockListsScreen),
        matching: find.byType(SurfaceGroup),
      ),
      findsNothing,
    );
    expect(
      find.descendant(
        of: find.byType(BlockListsScreen),
        matching: find.byIcon(CupertinoIcons.checkmark_circle_fill),
      ),
      findsNothing,
    );
    expect(find.text('Default'), findsOneWidget);
    expect(find.byIcon(CupertinoIcons.star_fill), findsOneWidget);
    expect(find.byIcon(CupertinoIcons.star), findsNWidgets(2));
    expect(find.textContaining('4 apps'), findsOneWidget);
    expect(find.text('1 app: Mail'), findsOneWidget);

    await tester.tap(
      find.descendant(
        of: find.ancestor(
          of: find.text('Work'),
          matching: find.byType(SurfaceCard),
        ),
        matching: find.byTooltip('Make default'),
      ),
    );
    await pumpTransitions(tester);

    expect(find.byIcon(CupertinoIcons.star_fill), findsOneWidget);
    expect(find.byTooltip('Default for new sessions'), findsOneWidget);

    final header = find.byType(ScreenHeader);
    final listsHeaderHeight = tester.getSize(header).height;
    expect(
      find.descendant(of: header, matching: find.text('Block lists')),
      findsOneWidget,
    );

    await tester.tap(find.text('Labels'));
    await pumpTransitions(tester);

    expect(tester.getSize(header).height, listsHeaderHeight);
    expect(
      find.descendant(of: header, matching: find.text('Labels')),
      findsOneWidget,
    );
    expect(find.text('Social'), findsNothing);
    expect(find.text('Work'), findsNothing);
    expect(find.byTooltip('New list'), findsNothing);
    expect(find.byTooltip('New label'), findsOneWidget);
    expect(find.byTooltip('What is a block list?'), findsNothing);
    expect(find.byTooltip('What is a label?'), findsOneWidget);

    await tester.tap(find.byTooltip('What is a label?'));
    await pumpTransitions(tester);

    expect(find.textContaining('name a session wears'), findsOneWidget);

    await tester.tap(find.text('I get it now'));
    await pumpTransitions(tester);
    expect(find.text('Focus Time'), findsOneWidget);
    expect(find.text('Study session'), findsOneWidget);
    expect(find.text('Deep work'), findsOneWidget);
    expect(find.text('Couple time'), findsOneWidget);
    expect(find.text('Family time'), findsOneWidget);
    expect(find.text('Digital detox'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(BlockListsScreen),
        matching: find.byType(SurfaceCard),
      ),
      findsNWidgets(6),
    );
    expect(
      find.descendant(
        of: find.byType(BlockListsScreen),
        matching: find.byType(SurfaceGroup),
      ),
      findsNothing,
    );
    expect(
      find.descendant(
        of: find.byType(BlockListsScreen),
        matching: find.byWidgetPredicate(
          (widget) => widget is SurfaceCard && widget.radius == 14,
        ),
      ),
      findsNWidgets(6),
    );
    expect(
      find.descendant(
        of: find.byType(BlockListsScreen),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Padding &&
              widget.padding == const EdgeInsets.fromLTRB(22, 14, 22, 14),
        ),
      ),
      findsNWidgets(6),
    );

    await tester.tap(find.text('Block lists').last);
    await pumpTransitions(tester);

    expect(find.text('Social'), findsOneWidget);
    expect(find.text('Work'), findsOneWidget);
    expect(find.text('Focus Time'), findsNothing);
  });

  testWidgets('a new label shows up with the built-in ones', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(MemoryFocusRepository()),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    await tester.tap(find.byTooltip('Block lists'));
    await pumpTransitions(tester);
    await tester.tap(find.text('Labels'));
    await pumpTransitions(tester);
    await tester.tap(find.byTooltip('New label'));
    await pumpTransitions(tester);

    expect(
      tester
          .widget<TextField>(find.byKey(const Key('label-name')))
          .focusNode!
          .hasFocus,
      isTrue,
    );
    expect(
      find.descendant(
        of: find.byKey(const Key('label-emoji')),
        matching: find.byType(TextField),
      ),
      findsNothing,
    );
    expect(find.widgetWithText(FilledButton, 'Save'), findsOneWidget);
    expect(_labelNameBorder(tester), isNull);

    await tester.tap(find.byKey(const Key('label-save')));
    await tester.pump();

    expect(find.text('New label'), findsOneWidget);
    expect(_labelNameBorder(tester)!.borderSide.color, _missingRed);
    expect(_labelIconBorder(tester).color, _missingRed);

    await pickLabelIcon(tester, query: 'reading', icon: '📖');
    expect(_labelIconBorder(tester).color, Colors.transparent);
    expect(_labelNameBorder(tester)!.borderSide.color, _missingRed);

    await tester.enterText(find.byKey(const Key('label-name')), 'Reading');
    await tester.pump();
    expect(_labelNameBorder(tester), isNull);
    await tester.tap(find.byKey(const Key('label-save')));
    await pumpTransitions(tester);

    expect(find.text('New label'), findsNothing);
    expect(find.text('Reading'), findsOneWidget);
    expect(find.text('Focus Time'), findsOneWidget);
  });

  testWidgets('a label can be renamed', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(
            MemoryFocusRepository(
              labels: [
                FocusLabel(
                  id: 'reading',
                  emoji: '📖',
                  name: 'Reading',
                  createdAt: DateTime.utc(2026, 11, 1),
                ),
              ],
            ),
          ),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    await tester.tap(find.byTooltip('Block lists'));
    await pumpTransitions(tester);
    await tester.tap(find.text('Labels'));
    await pumpTransitions(tester);

    expect(find.byTooltip('Edit label'), findsOneWidget);
    await tester.tap(find.text('Study session'));
    await pumpTransitions(tester);
    expect(find.text('Edit label'), findsNothing);

    await tester.tap(find.text('Reading'));
    await pumpTransitions(tester);

    expect(find.text('Edit label'), findsOneWidget);
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('label-name')))
          .focusNode!
          .hasFocus,
      isTrue,
    );
    expect(
      find.descendant(
        of: find.byKey(const Key('label-emoji')),
        matching: find.byType(TextField),
      ),
      findsNothing,
    );
    expect(_labelSaveEnabled(tester), isFalse);

    await tester.tap(find.byKey(const Key('label-save')));
    await tester.pump();
    expect(find.text('Edit label'), findsOneWidget);
    expect(_labelNameBorder(tester), isNull);

    await tester.enterText(find.byKey(const Key('label-name')), 'Homework');
    await tester.pump();
    expect(_labelSaveEnabled(tester), isTrue);
    await tester.enterText(find.byKey(const Key('label-name')), 'Reading');
    await tester.pump();
    expect(_labelSaveEnabled(tester), isFalse);

    await tester.enterText(find.byKey(const Key('label-name')), '');
    await tester.pump();
    await tester.tap(find.byKey(const Key('label-save')));
    await tester.pump();
    expect(find.text('Edit label'), findsOneWidget);
    expect(_labelNameBorder(tester)!.borderSide.color, _missingRed);
    expect(_labelIconBorder(tester).color, Colors.transparent);

    await pickLabelIcon(tester, query: 'bulb', icon: '💡');
    await tester.enterText(find.byKey(const Key('label-name')), 'homework');
    await tester.pump();
    await tester.tap(find.byKey(const Key('label-save')));
    await pumpTransitions(tester);

    expect(find.text('Edit label'), findsNothing);
    expect(find.text('Homework'), findsOneWidget);
    expect(find.text('💡'), findsOneWidget);
    expect(find.text('Reading'), findsNothing);
    expect(find.text('Study session'), findsOneWidget);
    expect(find.text('Focus Time'), findsOneWidget);
  });

  testWidgets('a renamed label shows on recent sessions', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(
            MemoryFocusRepository(
              labels: [
                FocusLabel(
                  id: 'study-session',
                  emoji: '💡',
                  name: 'Homework',
                  createdAt: DateTime.utc(2026, 11, 1),
                ),
              ],
              sessions: [
                FocusSession(
                  id: 'study',
                  blockListId: 'social',
                  blockListName: 'Social',
                  startedAt: DateTime.utc(2026, 11, 18, 9),
                  stoppedAt: DateTime.utc(2026, 11, 18, 9, 40),
                  outcome: SessionOutcome.completed,
                  labelId: 'study-session',
                ),
              ],
            ),
          ),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    expect(find.text('💡 Homework'), findsOneWidget);
    expect(find.text('📚 Study session'), findsNothing);
    expect(find.text('Recent sessions'), findsOneWidget);
    expect(find.text('No sessions yet'), findsNothing);
  });

  testWidgets('a removed label leaves Focus Time on recent sessions', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(
            MemoryFocusRepository(
              labels: [
                FocusLabel(
                  id: focusTimeLabelId,
                  emoji: '🎯',
                  name: 'Deep focus',
                  createdAt: DateTime.utc(2026, 1, 1),
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
                ),
              ],
            ),
          ),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    expect(find.text('🎯 Deep focus'), findsOneWidget);
    expect(find.text('📖 Reading'), findsNothing);
  });

  testWidgets('deleting a label explains that its time stays as Focus Time', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

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
          stoppedAt: DateTime.utc(2026, 11, 18, 10),
          outcome: SessionOutcome.completed,
          labelId: 'reading',
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(repository),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    await tester.tap(find.byTooltip('Block lists'));
    await pumpTransitions(tester);
    await tester.tap(find.text('Labels'));
    await pumpTransitions(tester);

    await tester.tap(find.text('Focus Time'));
    await pumpTransitions(tester);
    expect(find.text('Edit label'), findsNothing);
    expect(find.byKey(const Key('label-delete')), findsNothing);

    await tester.tap(find.text('Study session'));
    await pumpTransitions(tester);
    expect(find.text('Edit label'), findsNothing);

    await tester.tap(find.text('Reading'));
    await pumpTransitions(tester);

    final delete = find.byKey(const Key('label-delete'));
    expect(delete, findsOneWidget);
    expect(find.byIcon(CupertinoIcons.trash), findsOneWidget);

    await tester.tap(delete);
    await pumpTransitions(tester);
    expect(find.text('Delete this label?'), findsOneWidget);
    expect(
      find.text(
        'Sessions with this label will move to Focus Time. You can still track that time.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.text('Cancel'));
    await pumpTransitions(tester);
    expect(find.text('Edit label'), findsOneWidget);
    expect(repository.sessions.single.labelId, 'reading');

    await tester.tap(delete);
    await pumpTransitions(tester);
    await tester.tap(find.byKey(const Key('label-delete-confirm')));
    await pumpTransitions(tester);

    expect(find.text('Edit label'), findsNothing);
    expect(find.text('Reading'), findsNothing);
    expect(find.text('Study session'), findsOneWidget);
    expect(find.text('Focus Time'), findsOneWidget);
    expect(repository.sessions.single.labelId, 'reading');
  });

  testWidgets('app names stop where the line runs out', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: SizedBox(
            width: 180,
            child: BlockListAppLine(
              list: BlockList(
                id: 'social',
                name: 'Social',
                applicationCount: 4,
                categoryCount: 1,
                webDomainCount: 0,
                updatedAt: DateTime.utc(2026, 11, 7),
                applicationNames: ['Twitter', 'TikTok', 'Instagram', 'YouTube'],
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.textContaining('4 apps:'), findsOneWidget);
    expect(find.textContaining('...'), findsOneWidget);
    expect(find.textContaining('YouTube'), findsNothing);
  });

  testWidgets('the session sheet opens on the default block list', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(
            MemoryFocusRepository(
              lists: [
                BlockList(
                  id: 'work',
                  name: 'Work',
                  applicationCount: 2,
                  categoryCount: 0,
                  webDomainCount: 0,
                  updatedAt: DateTime.utc(2026, 1, 1),
                ),
                BlockList(
                  id: 'social',
                  name: 'Social',
                  applicationCount: 1,
                  categoryCount: 0,
                  webDomainCount: 0,
                  updatedAt: DateTime.utc(2026, 1, 2),
                  isFavorite: true,
                ),
              ],
            ),
          ),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    await tester.tap(find.byTooltip('Start Focus'));
    await pumpTransitions(tester);

    expect(find.text('Social'), findsOneWidget);
    expect(find.text('Work'), findsNothing);
    expect(
      tester
          .widget<FilledButton>(
            find.widgetWithText(FilledButton, 'Start Session'),
          )
          .onPressed,
      isNotNull,
    );
    expect(
      tester
          .widget<TextButton>(find.widgetWithText(TextButton, 'Create Session'))
          .onPressed,
      isNotNull,
    );

    await tester.tap(find.text('Block list'));
    await pumpTransitions(tester);

    expect(find.byTooltip('New list'), findsOneWidget);
    expect(find.text('New list'), findsNothing);
    expect(find.text('Social'), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await pumpTransitions(tester);

    expect(find.text('New list'), findsNothing);
    expect(find.text('Social'), findsOneWidget);

    await tester.tap(find.text('Block list'));
    await pumpTransitions(tester);
    await tester.tap(find.text('Work'));
    await pumpTransitions(tester);

    expect(find.text('Work'), findsOneWidget);
    expect(find.text('Social'), findsNothing);
    expect(find.text('New list'), findsNothing);
  });

  testWidgets('create saves the session and leaves it unstarted', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final repository = MemoryFocusRepository(
      lists: [
        BlockList(
          id: 'social',
          name: 'Social',
          applicationCount: 1,
          categoryCount: 0,
          webDomainCount: 0,
          updatedAt: DateTime.utc(2026, 1, 2),
          isFavorite: true,
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(repository),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    await tester.tap(find.byTooltip('Start Focus'));
    await pumpTransitions(tester);
    await tester.tap(find.text('25 min'));
    await tester.pump();
    await tester.tap(find.widgetWithText(TextButton, 'Create Session'));
    await pumpTransitions(tester);

    expect(find.widgetWithText(TextButton, 'Create Session'), findsNothing);
    expect(find.byTooltip('End session'), findsNothing);
    expect(find.text('Foqui is blocking apps from:'), findsOneWidget);
    expect(find.text('Social'), findsOneWidget);
    expect(find.text('Not started'), findsOneWidget);
    expect(find.text('Focus Time'), findsOneWidget);
    expect(find.text('Share'), findsOneWidget);
    expect(find.text('00:00'), findsOneWidget);
    expect(find.textContaining('25:00'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Start'), findsOneWidget);
    expect(repository.sessions, hasLength(1));
    expect(repository.sessions.single.outcome, SessionOutcome.created);
    expect(repository.sessions.single.blockListName, 'Social');
    expect(repository.sessions.single.labelId, 'focus-time');
    expect(repository.sessions.single.endsAt, isNotNull);

    await tester.pump(const Duration(seconds: 2));
    expect(find.text('00:00'), findsOneWidget);
    expect(find.textContaining('25:00'), findsOneWidget);
  });

  testWidgets('start session from the sheet begins it', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final repository = MemoryFocusRepository(
      lists: [
        BlockList(
          id: 'social',
          name: 'Social',
          applicationCount: 1,
          categoryCount: 0,
          webDomainCount: 0,
          updatedAt: DateTime.utc(2026, 1, 2),
          isFavorite: true,
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(repository),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    await tester.tap(find.byTooltip('Start Focus'));
    await pumpTransitions(tester);
    await tester.tap(find.text('25 min'));
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Start Session'));
    await pumpTransitions(tester);

    expect(find.widgetWithText(FilledButton, 'Start Session'), findsNothing);
    expect(find.text('In progress'), findsOneWidget);
    expect(find.text('Social'), findsOneWidget);
    expect(repository.sessions, hasLength(1));
    expect(repository.sessions.single.outcome, SessionOutcome.active);
    expect(repository.sessions.single.blockListName, 'Social');
  });

  testWidgets('block list and label sections slide over the form', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(MemoryFocusRepository()),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    await tester.tap(find.byTooltip('Start Focus'));
    await pumpTransitions(tester);

    final durationX = tester.getTopLeft(find.text('Duration')).dx;
    final sheetTop = tester.getTopLeft(find.byType(SheetGrabber)).dy;

    await tester.tap(find.text('Block list'));
    await tester.pump();

    final enteringList = tester.getTopLeft(find.byTooltip('New list')).dx;
    expect(enteringList, greaterThan(390));
    expect(tester.getTopLeft(find.text('Duration')).dx, closeTo(durationX, 1));
    expect(
      tester.getTopLeft(find.byType(SheetGrabber)).dy,
      closeTo(sheetTop, 0.5),
    );

    await tester.pump(const Duration(milliseconds: 160));
    expect(
      tester.getTopLeft(find.byTooltip('New list')).dx,
      lessThan(enteringList),
    );
    expect(
      tester.getTopLeft(find.byType(SheetGrabber)).dy,
      closeTo(sheetTop, 0.5),
    );

    await pumpTransitions(tester);
    expect(tester.getTopLeft(find.byTooltip('New list')).dx, lessThan(390));
    expect(
      tester.getTopLeft(find.byType(SheetGrabber)).dy,
      closeTo(sheetTop, 0.5),
    );

    await tester.tap(find.byTooltip('Back'));
    await tester.pump();
    expect(
      tester.getTopLeft(find.text('Duration')).dx,
      lessThan(durationX - 20),
    );
    await pumpTransitions(tester);

    await tester.tap(find.text('Label'));
    await tester.pump();
    expect(tester.getTopLeft(find.byTooltip('New label')).dx, greaterThan(390));
  });

  testWidgets('a session can be labeled from the new session sheet', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final repository = MemoryFocusRepository(
      lists: [
        BlockList(
          id: 'social',
          name: 'Social',
          applicationCount: 1,
          categoryCount: 0,
          webDomainCount: 0,
          updatedAt: DateTime.utc(2026, 1, 2),
          isFavorite: true,
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(repository),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    await tester.tap(find.byTooltip('Start Focus'));
    await pumpTransitions(tester);

    expect(find.text('Focus Time'), findsOneWidget);
    expect(find.text('Study session'), findsNothing);

    await tester.tap(find.text('Label'));
    await pumpTransitions(tester);

    expect(find.byTooltip('New label'), findsOneWidget);
    expect(find.text('New label'), findsNothing);
    expect(find.text('Study session'), findsOneWidget);
    expect(find.text('Deep work'), findsOneWidget);
    expect(find.text('Family time'), findsOneWidget);
    expect(find.text('Start Session'), findsNothing);

    await tester.tap(find.text('Study session'));
    await pumpTransitions(tester);

    expect(find.text('New label'), findsNothing);
    expect(find.text('Study session'), findsOneWidget);
    expect(find.text('Focus Time'), findsNothing);
    expect(find.text('Start Session'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, 'Create Session'));
    await pumpTransitions(tester);

    expect(repository.sessions.single.labelId, 'study-session');
    expect(find.text('Study session'), findsOneWidget);
  });

  testWidgets('a label made in the session sheet is selected', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(
            MemoryFocusRepository(
              lists: [
                BlockList(
                  id: 'social',
                  name: 'Social',
                  applicationCount: 1,
                  categoryCount: 0,
                  webDomainCount: 0,
                  updatedAt: DateTime.utc(2026, 1, 2),
                  isFavorite: true,
                ),
              ],
            ),
          ),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    await tester.tap(find.byTooltip('Start Focus'));
    await pumpTransitions(tester);
    await tester.tap(find.text('Label'));
    await pumpTransitions(tester);
    await tester.tap(find.byTooltip('New label'));
    await pumpTransitions(tester);

    await pickLabelIcon(tester, query: 'reading', icon: '📖');
    await tester.enterText(find.byKey(const Key('label-name')), 'Reading');
    await tester.pump();
    await tester.tap(find.byKey(const Key('label-save')));
    await pumpTransitions(tester);

    expect(find.text('New label'), findsNothing);
    expect(find.text('Reading'), findsOneWidget);
    expect(find.text('Focus Time'), findsNothing);
    expect(find.text('Start Session'), findsOneWidget);
  });

  testWidgets('the live bar matches how much of the session has elapsed', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final now = DateTime.now();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(
            MemoryFocusRepository(
              sessions: [
                FocusSession(
                  id: 'session',
                  blockListId: 'list',
                  blockListName: 'Work',
                  startedAt: now.subtract(const Duration(minutes: 10)),
                  endsAt: now.add(const Duration(minutes: 10)),
                  outcome: SessionOutcome.active,
                ),
              ],
            ),
          ),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    final ratio = _progressRatio(tester);
    expect(ratio, greaterThan(0.45));
    expect(ratio, lessThan(0.55));
    expect(find.textContaining('10:00'), findsOneWidget);
    expect(find.textContaining('20:00'), findsOneWidget);
  });

  testWidgets('a session that just started has an empty live bar', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final now = DateTime.now();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(
            MemoryFocusRepository(
              sessions: [
                FocusSession(
                  id: 'session',
                  blockListId: 'list',
                  blockListName: 'Work',
                  startedAt: now,
                  endsAt: now.add(const Duration(minutes: 20)),
                  outcome: SessionOutcome.active,
                ),
              ],
            ),
          ),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    expect(_progressRatio(tester), lessThan(0.05));
  });

  testWidgets('stats shows focus time from past sessions', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final ended = DateTime.now().subtract(const Duration(hours: 3));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(
            MemoryFocusRepository(
              sessions: [
                FocusSession(
                  id: 'session',
                  blockListId: 'work',
                  blockListName: 'Work',
                  startedAt: ended.subtract(const Duration(minutes: 40)),
                  endsAt: ended,
                  stoppedAt: ended,
                  outcome: SessionOutcome.completed,
                  labelId: 'study-session',
                ),
              ],
            ),
          ),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    await tester.tap(find.byTooltip('Stats'));
    await pumpTransitions(tester);

    expect(find.text('Stats'), findsOneWidget);
    expect(find.text('Today'), findsOneWidget);
    expect(find.text('This week'), findsOneWidget);
    expect(find.text('Stayed'), findsOneWidget);
    expect(find.text('Last 7 days'), findsOneWidget);
    await tester.drag(find.text('Last 7 days'), const Offset(0, -700));
    await tester.pump();

    expect(find.text('All time'), findsOneWidget);
    expect(find.text('By label'), findsOneWidget);
    expect(find.text('Study session'), findsWidgets);
    expect(find.text('By list'), findsOneWidget);
    expect(find.text('40 min'), findsWidgets);
    expect(find.text('Work'), findsWidgets);
    expect(find.text('Finished'), findsOneWidget);
  });

  testWidgets('signed out people see a welcome and a start button', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [authProvider.overrideWith(LoggedOutAuthNotifier.new)],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    expect(find.text('Foqui'), findsOneWidget);
    expect(find.text('blocks distracting apps during your'), findsOneWidget);
    expect(find.text('Study session'), findsOneWidget);
    expect(
      find.image(const AssetImage('assets/images/foqui-study.png')),
      findsOneWidget,
    );
    expect(find.text('Start'), findsOneWidget);
    expect(find.text('Continue with Apple'), findsNothing);
    expect(find.byTooltip('Start Focus'), findsNothing);

    await tester.pump(const Duration(milliseconds: 700));
    await tester.pumpAndSettle();
    expect(find.text('Deep work'), findsOneWidget);
    expect(
      find.image(const AssetImage('assets/images/foqui-deep-work.png')),
      findsOneWidget,
    );

    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();

    expect(find.text('Continue with Apple'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
  });

  testWidgets('the start button pulses until two sessions pass a minute', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    Future<void> pumpSessions(List<FocusSession> sessions) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith(LoggedInAuthNotifier.new),
            focusRepositoryProvider.overrideWithValue(
              MemoryFocusRepository(sessions: sessions),
            ),
          ],
          child: const FoquiApp(),
        ),
      );
      await settleApp(tester);
    }

    final start = DateTime.now().subtract(const Duration(hours: 2));
    FocusSession ran(String id, Duration length) {
      final stopped = start.add(length);
      return FocusSession(
        id: id,
        blockListId: 'list',
        blockListName: 'Work',
        startedAt: start,
        endsAt: stopped,
        stoppedAt: stopped,
        outcome: SessionOutcome.completed,
      );
    }

    Finder pulseUnder(String tooltip) {
      return find.descendant(
        of: find.byTooltip(tooltip),
        matching: find.byType(AnimatedBuilder),
      );
    }

    await pumpSessions(const []);
    expect(find.byTooltip('Start Focus'), findsOneWidget);
    expect(pulseUnder('Start Focus'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 800));
    final scales = tester
        .widgetList<Transform>(
          find.descendant(
            of: find.byTooltip('Start Focus'),
            matching: find.byType(Transform),
          ),
        )
        .map((transform) => transform.transform.getMaxScaleOnAxis());
    expect(scales.any((scale) => scale > 1.02), isTrue);

    await pumpSessions([
      ran('short', const Duration(seconds: 20)),
      ran('minute', const Duration(minutes: 1)),
    ]);
    expect(pulseUnder('Start Focus'), findsOneWidget);

    await pumpSessions([
      ran('one', const Duration(minutes: 15)),
      ran('two', const Duration(seconds: 61)),
    ]);
    expect(find.byTooltip('Start Focus'), findsOneWidget);
    expect(pulseUnder('Start Focus'), findsNothing);

    final now = DateTime.now();
    await pumpSessions([
      FocusSession(
        id: 'live',
        blockListId: 'list',
        blockListName: 'Work',
        startedAt: now.subtract(const Duration(minutes: 5)),
        endsAt: now.add(const Duration(minutes: 10)),
        outcome: SessionOutcome.active,
      ),
    ]);
    expect(find.byTooltip('End session'), findsOneWidget);
    expect(find.text('Pause'), findsOneWidget);
    expect(pulseUnder('End session'), findsNothing);
  });

  testWidgets('ending a session confirms from a sheet', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final now = DateTime.now();
    final repository = MemoryFocusRepository(
      lists: [
        BlockList(
          id: 'work',
          name: 'Work',
          applicationCount: 2,
          categoryCount: 0,
          webDomainCount: 0,
          updatedAt: now,
          applicationNames: const ['Instagram', 'Safari'],
        ),
      ],
      sessions: [
        FocusSession(
          id: 'live',
          blockListId: 'work',
          blockListName: 'Work',
          startedAt: now.subtract(const Duration(minutes: 5)),
          endsAt: now.add(const Duration(minutes: 20)),
          outcome: SessionOutcome.active,
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(repository),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    await tester.tap(find.byTooltip('End session'));
    await pumpTransitions(tester);

    expect(find.text('End this session?'), findsOneWidget);
    expect(find.text('Apps in Work will be available again.'), findsOneWidget);
    expect(find.text('Stay a little longer'), findsNothing);
    expect(find.widgetWithText(FilledButton, 'Keep focusing'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'End session'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Keep focusing'));
    await pumpTransitions(tester);

    expect(find.text('End this session?'), findsNothing);
    expect(find.byTooltip('End session'), findsOneWidget);
    expect(repository.sessions.single.outcome, SessionOutcome.active);

    await tester.tap(find.byTooltip('End session'));
    await pumpTransitions(tester);
    await tester.tap(find.widgetWithText(TextButton, 'End session'));
    await pumpTransitions(tester);

    expect(find.text('End this session?'), findsNothing);
    expect(find.byTooltip('Start Focus'), findsOneWidget);
    expect(repository.sessions.single.outcome, SessionOutcome.endedEarly);
  });

  testWidgets('ending before five minutes says the session has to keep going', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final now = DateTime.now();
    final repository = MemoryFocusRepository(
      lists: [
        BlockList(
          id: 'work',
          name: 'Work',
          applicationCount: 2,
          categoryCount: 0,
          webDomainCount: 0,
          updatedAt: now,
          applicationNames: const ['Instagram', 'Safari'],
        ),
      ],
      sessions: [
        FocusSession(
          id: 'live',
          blockListId: 'work',
          blockListName: 'Work',
          startedAt: now.subtract(const Duration(minutes: 2)),
          endsAt: now.add(const Duration(minutes: 23)),
          outcome: SessionOutcome.active,
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(repository),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    await tester.tap(find.widgetWithText(FilledButton, 'Stop'));
    await pumpTransitions(tester);

    expect(find.text("You can't end yet"), findsOneWidget);
    expect(
      find.text(
        'You can end this session once it has been going for 5 minutes.',
      ),
      findsOneWidget,
    );
    expect(find.widgetWithText(TextButton, 'End session'), findsNothing);

    await tester.tap(find.widgetWithText(FilledButton, 'Keep focusing'));
    await pumpTransitions(tester);

    expect(find.text("You can't end yet"), findsNothing);
    expect(repository.sessions.single.outcome, SessionOutcome.active);
  });

  testWidgets('an active session only allows stopping it', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final now = DateTime.now();
    final repository = MemoryFocusRepository(
      lists: [
        BlockList(
          id: 'work',
          name: 'Work',
          applicationCount: 2,
          categoryCount: 1,
          webDomainCount: 0,
          updatedAt: now,
          applicationNames: const ['Instagram', 'Safari'],
        ),
      ],
      sessions: [
        FocusSession(
          id: 'live',
          blockListId: 'work',
          blockListName: 'Work',
          startedAt: now.subtract(const Duration(minutes: 5)),
          endsAt: now.add(const Duration(minutes: 21)),
          outcome: SessionOutcome.active,
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(repository),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    expect(find.text('Put chosen apps away for a while.'), findsOneWidget);
    expect(find.text('Foqui is blocking apps from:'), findsOneWidget);
    expect(find.text('In progress'), findsOneWidget);
    expect(find.text('Work'), findsOneWidget);
    expect(find.text('Pause'), findsOneWidget);
    expect(find.byTooltip('You can pause after 20 minutes.'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Pause'))
          .onPressed,
      isNotNull,
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Pause'));
    await pumpTransitions(tester);
    expect(find.text("Pause isn't available yet"), findsOneWidget);
    expect(
      find.text(
        'You can pause once this session has been going for more than 20 minutes.',
      ),
      findsOneWidget,
    );
    expect(repository.sessions.single.outcome, SessionOutcome.active);

    await tester.tap(find.widgetWithText(FilledButton, 'Keep focusing'));
    await pumpTransitions(tester);
    expect(find.text("Pause isn't available yet"), findsNothing);
    expect(find.text('Stop'), findsOneWidget);
    expect(
      tester.getSize(find.byType(SessionLiveActivity)).height,
      moreOrLessEquals(844, epsilon: 1),
    );
    expect(find.text('No active session'), findsNothing);
    expect(
      tester
          .widget<IconButton>(
            find.widgetWithIcon(IconButton, CupertinoIcons.square_arrow_right),
          )
          .onPressed,
      isNotNull,
    );

    await tester.tap(find.byTooltip('Stats'), warnIfMissed: false);
    await pumpTransitions(tester);
    expect(find.text('See the time you have spent focusing.'), findsNothing);
    expect(find.text('Foqui is blocking apps from:'), findsOneWidget);
    expect(find.text('Work'), findsOneWidget);

    await tester.tap(find.byTooltip('Sign out'), warnIfMissed: false);
    await pumpTransitions(tester);
    expect(
      find.text('Your block lists and sessions stay on this account.'),
      findsNothing,
    );

    expect(find.text('Members (1)'), findsOneWidget);
    expect(find.text('You'), findsOneWidget);
    expect(find.byTooltip('Share'), findsOneWidget);
    expect(find.byIcon(CupertinoIcons.person_fill), findsOneWidget);
    expect(find.text('Focus Time'), findsOneWidget);
    expect(
      find.byIcon(CupertinoIcons.chevron_down).evaluate().length +
          find.byIcon(CupertinoIcons.chevron_up).evaluate().length,
      1,
    );
    final status = find.text('In progress').evaluate().isNotEmpty
        ? find.text('In progress')
        : find.text('Paused');
    final dot = find.byKey(const Key('session-status-dot'));
    expect(
      (tester.getCenter(dot).dy - tester.getCenter(status).dy).abs(),
      lessThan(2),
    );
    final barBottom = tester.getBottomLeft(
      find.byWidgetPredicate(
        (widget) => widget is ColoredBox && widget.color == FoquiColors.violet,
      ),
    );
    expect(
      tester.getTopLeft(find.text('Members (1)')).dy - barBottom.dy,
      greaterThan(20),
    );
    expect(
      tester.getTopLeft(find.text('You')).dy,
      greaterThan(tester.getTopLeft(find.text('Members (1)')).dy),
    );

    if (find.text('Study session').evaluate().isEmpty) {
      await tester.tap(find.byTooltip('Choose a focus label'));
      await pumpTransitions(tester);
    }
    expect(find.text('Study session'), findsOneWidget);
    expect(find.text('Deep work'), findsOneWidget);
    expect(find.text('Couple time'), findsOneWidget);
    expect(find.text('Family time'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
    expect(find.byType(EditableText), findsNothing);

    await tester.tap(find.text('Deep work'));
    await pumpTransitions(tester);
    expect(find.text('Deep work'), findsOneWidget);
    expect(find.text('Focus Time'), findsNothing);
    expect(repository.sessions.single.labelId, 'deep-work');

    await tester.tap(find.text('Work'));
    await pumpTransitions(tester);
    expect(find.text('This session'), findsNothing);
    expect(
      repository.sessions.single.outcome,
      anyOf(SessionOutcome.active, SessionOutcome.paused),
    );

    await tester.tap(find.byTooltip('Share'));
    await pumpTransitions(tester);
    expect(find.text('Members (1)'), findsOneWidget);
    expect(
      repository.sessions.single.outcome,
      anyOf(SessionOutcome.active, SessionOutcome.paused),
    );

    await tester.tap(find.byTooltip('End session'));
    await pumpTransitions(tester);
    expect(find.text('End this session?'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, 'End session'));
    await pumpTransitions(tester);
    await tester.pump(const Duration(seconds: 1));

    expect(find.byTooltip('Start Focus'), findsOneWidget);
    expect(find.text('Members (1)'), findsNothing);
    expect(find.byTooltip('Share'), findsNothing);
    await tester.tap(find.byTooltip('Stats'));
    await pumpTransitions(tester);
    expect(
      find.text('How long you focused, and what it was for.'),
      findsOneWidget,
    );
  });

  testWidgets('a group can leave, and a pause waits for everyone', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final now = DateTime.now();
    final repository = MemoryFocusRepository(
      lists: [
        BlockList(
          id: 'work',
          name: 'Work',
          applicationCount: 1,
          categoryCount: 0,
          webDomainCount: 0,
          updatedAt: now,
        ),
      ],
      sessions: [
        FocusSession(
          id: 'live',
          blockListId: 'work',
          blockListName: 'Work',
          startedAt: now.subtract(const Duration(minutes: 21)),
          endsAt: now.add(const Duration(minutes: 24)),
          outcome: SessionOutcome.active,
          sharedSessionId: 'room',
        ),
      ],
    );
    const members = [
      SessionParticipant(
        uid: 'test-user',
        name: 'Marco',
        joinedAt: null,
        username: 'marco',
      ),
      SessionParticipant(
        uid: 'ada',
        name: 'Ada',
        joinedAt: null,
        username: 'ada',
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(repository),
          participantsProvider.overrideWith(
            (ref, sessionId) => Stream.value(members),
          ),
          pauseRequestProvider.overrideWith(
            (ref, sessionId) => Stream.value(null),
          ),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    expect(find.text('Leave'), findsOneWidget);
    expect(find.text('Stop'), findsNothing);
    expect(find.text('In progress'), findsOneWidget);
    expect(find.text('Marco (marco)'), findsOneWidget);
    expect(find.text('Ada (ada)'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Pause'));
    await pumpTransitions(tester);
    expect(find.text('Request a pause?'), findsOneWidget);
    expect(
      find.text('Everyone in this session has to accept before it pauses.'),
      findsOneWidget,
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Request pause'));
    await pumpTransitions(tester);
    expect(find.text('Request a pause?'), findsNothing);
    expect(repository.sessions.single.outcome, SessionOutcome.active);

    await tester.tap(find.widgetWithText(FilledButton, 'Leave'));
    await pumpTransitions(tester);
    expect(find.text('Leave this session?'), findsOneWidget);
    expect(
      find.text(
        'Apps in Work will be available again. Everyone else keeps going.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.widgetWithText(TextButton, 'Leave'));
    await pumpTransitions(tester);
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byTooltip('Start Focus'), findsOneWidget);
    expect(repository.sessions.single.outcome, SessionOutcome.endedEarly);
  });

  testWidgets('a pause request stays open until every member accepts', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final now = DateTime.now();
    final repository = MemoryFocusRepository(
      sessions: [
        FocusSession(
          id: 'live',
          blockListId: 'work',
          blockListName: 'Work',
          startedAt: now.subtract(const Duration(minutes: 6)),
          endsAt: now.add(const Duration(minutes: 19)),
          outcome: SessionOutcome.active,
          sharedSessionId: 'room',
        ),
      ],
    );
    const members = [
      SessionParticipant(uid: 'test-user', name: 'Marco', joinedAt: null),
      SessionParticipant(uid: 'ada', name: 'Ada', joinedAt: null),
    ];
    final requests = StreamController<PauseRequest?>();
    addTearDown(requests.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(repository),
          participantsProvider.overrideWith(
            (ref, sessionId) => Stream.value(members),
          ),
          pauseRequestProvider.overrideWith(
            (ref, sessionId) => requests.stream,
          ),
        ],
        child: const FoquiApp(),
      ),
    );
    requests.add(
      const PauseRequest(
        requestedBy: 'ada',
        requestedName: 'Ada',
        createdAt: null,
        accepted: {'ada': true},
      ),
    );
    await settleApp(tester);

    expect(find.text('Ada wants to pause.'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Accept'), findsOneWidget);
    expect(find.text('In progress'), findsOneWidget);
    expect(repository.sessions.single.outcome, SessionOutcome.active);

    requests.add(
      const PauseRequest(
        requestedBy: 'ada',
        requestedName: 'Ada',
        createdAt: null,
        accepted: {'ada': true, 'test-user': true},
      ),
    );
    await settleApp(tester);
    await tester.pump();

    expect(find.text('Paused'), findsOneWidget);
    expect(repository.sessions.single.outcome, SessionOutcome.paused);
  });

  testWidgets('the new session sheet can turn chat on', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final repository = MemoryFocusRepository(
      lists: [
        BlockList(
          id: 'social',
          name: 'Social',
          applicationCount: 1,
          categoryCount: 0,
          webDomainCount: 0,
          updatedAt: DateTime.utc(2026, 1, 2),
          isFavorite: true,
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(repository),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    await tester.tap(find.byTooltip('Start Focus'));
    await pumpTransitions(tester);
    expect(find.text('Chat'), findsOneWidget);
    expect(
      find.text('Messages with the people in this session'),
      findsOneWidget,
    );
    expect(
      tester.widget<CupertinoSwitch>(find.byType(CupertinoSwitch)).value,
      isFalse,
    );

    await tester.tap(find.byType(CupertinoSwitch));
    await tester.pump();
    await tester.tap(find.widgetWithText(TextButton, 'Create Session'));
    await pumpTransitions(tester);

    expect(repository.sessions.single.chatEnabled, isTrue);
    await tester.pump(const Duration(seconds: 1));
    final chat = find.widgetWithText(FilledButton, 'Chat');
    expect(chat, findsOneWidget);
    expect(tester.getCenter(chat).dy, lessThan(844));

    await tester.tap(chat);
    await pumpTransitions(tester);
    expect(find.text('No messages yet'), findsOneWidget);
  });

  testWidgets('the session sheet opens chat and clears the new-message dot', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final now = DateTime.now();
    final repository = MemoryFocusRepository(
      lists: [
        BlockList(
          id: 'work',
          name: 'Work',
          applicationCount: 1,
          categoryCount: 0,
          webDomainCount: 0,
          updatedAt: now,
        ),
      ],
      sessions: [
        FocusSession(
          id: 'live',
          blockListId: 'work',
          blockListName: 'Work',
          startedAt: now.subtract(const Duration(minutes: 21)),
          endsAt: now.add(const Duration(minutes: 24)),
          outcome: SessionOutcome.active,
          sharedSessionId: 'room',
        ),
      ],
    );
    const members = [
      SessionParticipant(
        uid: 'test-user',
        name: 'Marco',
        joinedAt: null,
        username: 'marco',
      ),
      SessionParticipant(
        uid: 'ada',
        name: 'Ada',
        joinedAt: null,
        username: 'ada',
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(LoggedInAuthNotifier.new),
          focusRepositoryProvider.overrideWithValue(repository),
          participantsProvider.overrideWith(
            (ref, sessionId) => Stream.value(members),
          ),
          pauseRequestProvider.overrideWith(
            (ref, sessionId) => Stream.value(null),
          ),
          sharedSessionProvider.overrideWith(
            (ref, sessionId) => Stream.value(
              SharedSession(
                id: 'room',
                hostId: 'ada',
                hostName: 'Ada',
                title: 'Focus',
                labelEmoji: null,
                durationMinutes: 45,
                status: SharedSessionStatus.active,
                startedAt: now.subtract(const Duration(minutes: 21)),
                endsAt: now.add(const Duration(minutes: 24)),
                createdAt: now,
                expiresAt: now.add(const Duration(hours: 2)),
                chatEnabled: true,
                chatAt: now,
                chatBy: 'ada',
              ),
            ),
          ),
          sessionChatProvider.overrideWith(
            (ref, sessionId) =>
                Stream<List<SessionChatMessage>>.value(const []),
          ),
        ],
        child: const FoquiApp(),
      ),
    );
    await settleApp(tester);

    expect(find.text('Chat'), findsOneWidget);
    expect(find.byKey(const Key('chat-unread')), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Chat'));
    await pumpTransitions(tester);
    expect(find.text('No messages yet'), findsOneWidget);
    expect(find.text('Members (2)').hitTestable(), findsNothing);

    await tester.pump(const Duration(milliseconds: 500));
    final gesture = await tester.startGesture(const Offset(4, 500));
    await gesture.moveBy(const Offset(200, 0));
    await tester.pump();
    await gesture.moveBy(const Offset(160, 0));
    await gesture.up();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Members (2)').hitTestable(), findsOneWidget);
    expect(find.byKey(const Key('chat-unread')), findsNothing);
  });
}

final _missingRed = FoquiColors.destructive.withValues(alpha: 0.55);

bool _labelSaveEnabled(WidgetTester tester) {
  return tester
          .widget<ButtonStyleButton>(find.byKey(const Key('label-save')))
          .onPressed !=
      null;
}

OutlineInputBorder? _labelNameBorder(WidgetTester tester) {
  return tester
          .widget<TextField>(find.byKey(const Key('label-name')))
          .decoration!
          .focusedBorder
      as OutlineInputBorder?;
}

BorderSide _labelIconBorder(WidgetTester tester) {
  final material = tester
      .widgetList<Material>(
        find.ancestor(
          of: find.byKey(const Key('label-emoji')),
          matching: find.byType(Material),
        ),
      )
      .firstWhere((material) {
        final shape = material.shape;
        return shape is RoundedRectangleBorder && shape.side.width == 1.5;
      });
  return (material.shape! as RoundedRectangleBorder).side;
}

/// Route transitions finish in well under this.
///
/// The start button's pulse repeats, so [WidgetTester.pumpAndSettle] does
/// not return while that button is on screen.
/// Lets locale files finish loading. The asset bundle resolves outside the
/// test's fake clock, so a plain pump never shows the signed-in screens.
///
/// The second pump applies the start button's pulse, which is scheduled
/// after the first frame that actually shows it.
Future<void> pickLabelIcon(
  WidgetTester tester, {
  required String query,
  required String icon,
}) async {
  await tester.tap(find.byKey(const Key('label-emoji')));
  await pumpTransitions(tester);
  await tester.enterText(find.byKey(const Key('label-icon-search')), query);
  await tester.pump();
  await tester.tap(find.byKey(Key('label-icon-$icon')));
  await pumpTransitions(tester);
}

Future<void> settleApp(WidgetTester tester) async {
  await tester.runAsync(() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
  });
  await tester.pump();
  await tester.pump();
}

Future<void> pumpTransitions(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
}

double _progressRatio(WidgetTester tester) {
  const fillColor = FoquiColors.violet;
  final fillFinder = find.byWidgetPredicate(
    (widget) => widget is ColoredBox && widget.color == fillColor,
  );
  final trackFinder = find.descendant(
    of: find.ancestor(of: fillFinder, matching: find.byType(Stack)).first,
    matching: find.byWidgetPredicate((widget) {
      return widget is ColoredBox && widget.color != fillColor;
    }),
  );
  return tester.getSize(fillFinder).width / tester.getSize(trackFinder).width;
}
