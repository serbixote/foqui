import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foqui/l10n/tr.dart';
import 'package:foqui/models/block_list.dart';
import 'package:foqui/models/user_profile.dart';
import 'package:foqui/models/username.dart';
import 'package:foqui/repositories/user.dart';
import 'package:foqui/screens/onboarding_screen.dart';
import 'package:foqui/services/focus_shield_bridge.dart';
import 'package:foqui/state/auth.dart';
import 'package:foqui/state/focus_controller.dart';
import 'package:foqui/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'memory_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    await loadEnglishCatalog();
  });

  testWidgets(
    'onboarding requires a block list and reserves a name at the end',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final directory = _Directory(taken: {'takenname'});
      final repository = MemoryFocusRepository();
      await _pump(tester, directory, repository);
      expect(find.byTooltip('Sign out'), findsNothing);
      await _finishIntro(tester);

      expect(find.text('What should we call you?'), findsOneWidget);
      expect(find.byTooltip('Sign out'), findsOneWidget);
      expect(find.text('Alias'), findsOneWidget);
      expect(find.text('Pick a username'), findsNothing);
      expect(_continue(tester).onPressed, isNull);

      await tester.enterText(find.byType(TextField), 'Ada');
      await tester.pump();
      expect(_continue(tester).onPressed, isNotNull);

      await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
      await _frames(tester);

      expect(find.text('Pick a username'), findsOneWidget);
      expect(
        find.text('3–20 letters, numbers, or underscores.'),
        findsOneWidget,
      );

      await tester.enterText(find.byType(TextField), 'foqui');
      await tester.pump();
      expect(find.text("Can't use that one."), findsOneWidget);
      expect(directory.lookups, isEmpty);

      await tester.enterText(find.byType(TextField), 'takenname');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pump();
      expect(find.text('Someone already has that one.'), findsOneWidget);
      expect(directory.lookups, ['takenname']);
      expect(_continue(tester).onPressed, isNull);

      await tester.enterText(find.byType(TextField), 'Marco');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pump();
      expect(find.text('Looks good'), findsOneWidget);
      expect(directory.lookups, ['takenname', 'marco']);

      await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
      await _frames(tester);

      expect(directory.alias, 'Ada');
      expect(directory.username, 'marco');
      expect(directory.published, isFalse);
      expect(find.text('Screen Time'), findsOneWidget);
      expect(find.text('Not now'), findsNothing);
      expect(find.byTooltip('Sign out'), findsOneWidget);
      expect(_continue(tester).onPressed, isNotNull);
      expect(directory.completed, isFalse);

      await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
      await _frames(tester);

      expect(find.text('Default block list'), findsOneWidget);
      expect(find.text('Default'), findsOneWidget);
      expect(
        find.text('Screen Time permission is necessary for Foqui to work.'),
        findsOneWidget,
      );
      expect(
        tester
            .widget<Text>(
              find.text(
                'Screen Time permission is necessary for Foqui to work.',
              ),
            )
            .style
            ?.color,
        const Color(0xFF30D158),
      );
      expect(_continue(tester).onPressed, isNull);

      await tester.tap(find.text('Choose apps'));
      await _frames(tester);
      expect(
        find.text('Screen Time permission is necessary for Foqui to work.'),
        findsNothing,
      );
      expect(_continue(tester).onPressed, isNotNull);

      await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
      await _frames(tester);

      final saved = repository.lists.singleWhere(
        (list) => list.id == defaultBlockListId,
      );
      expect(saved.name, defaultBlockListName);
      expect(saved.isFavorite, isTrue);
      expect(saved.applicationCount, 2);
      expect(directory.published, isFalse);
      expect(directory.completed, isFalse);
      expect(find.text('All set'), findsOneWidget);
      expect(find.text('Time to put some apps away.'), findsOneWidget);
      expect(directory.published, isFalse);
      expect(directory.completed, isFalse);

      await tester.tap(find.widgetWithText(FilledButton, 'Start'));
      await _frames(tester);
      expect(directory.published, isTrue);
      expect(directory.completed, isTrue);
    },
  );

  testWidgets('a name taken before the end sends you back to pick another', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final directory = _Directory(taken: {}, alias: 'Marco', username: 'marco');
    await _pump(
      tester,
      directory,
      MemoryFocusRepository(),
      profile: const UserProfile(alias: 'Marco', username: 'marco'),
    );

    expect(find.text('Screen Time'), findsOneWidget);
    expect(find.text('Not now'), findsNothing);
    await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
    await _frames(tester);
    expect(find.text('Default block list'), findsOneWidget);
    await tester.tap(find.text('Choose apps'));
    await _frames(tester);
    await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
    await _frames(tester);
    expect(find.text('All set'), findsOneWidget);
    expect(directory.published, isFalse);

    directory.taken.add('marco');
    await tester.tap(find.widgetWithText(FilledButton, 'Start'));
    await _frames(tester);

    expect(directory.completed, isFalse);
    expect(directory.published, isFalse);
    expect(find.text('Pick a username'), findsOneWidget);
    expect(find.text('Someone already has that one.'), findsOneWidget);
  });

  testWidgets('onboarding asks again when the saved list has no apps here', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final repository = MemoryFocusRepository(
      lists: [
        BlockList(
          id: 'social',
          name: 'Social',
          applicationCount: 6,
          categoryCount: 0,
          webDomainCount: 2,
          updatedAt: DateTime.utc(2026, 1, 2),
          isFavorite: true,
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(_LoggedIn.new),
          userRepositoryProvider.overrideWithValue(_Directory(taken: {})),
          focusRepositoryProvider.overrideWithValue(repository),
          focusShieldBridgeProvider.overrideWithValue(_NoStoredSelection()),
        ],
        child: EasyLocalization(
          supportedLocales: foquiLocales,
          path: 'assets/translations',
          assetLoader: const FoquiAssetLoader(),
          fallbackLocale: const Locale('en'),
          startLocale: const Locale('en'),
          child: const _ReturningHarness(),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('Screen Time'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
    await _frames(tester);

    expect(find.text('Default block list'), findsOneWidget);
    expect(find.text('Screen Time'), findsNothing);
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller?.text,
      'Default',
    );
    expect(
      repository.lists.singleWhere((list) => list.id == 'social').isEmpty,
      isTrue,
    );
    expect(find.text('Screen Time'), findsNothing);
    expect(find.byTooltip('Sign out'), findsOneWidget);
  });

  testWidgets('sign out from the second step asks before leaving', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    var signedOut = false;
    await _pump(
      tester,
      _Directory(taken: {}),
      MemoryFocusRepository(),
      auth: () => _RecordingAuth(() => signedOut = true),
    );
    await _finishIntro(tester);

    final signOut = find.byTooltip('Sign out');
    expect(tester.getRect(signOut).right, moreOrLessEquals(362, epsilon: 1));

    await tester.tap(signOut);
    await tester.pumpAndSettle();
    expect(
      find.text('Your block lists and sessions stay on this account.'),
      findsOneWidget,
    );
    expect(find.text("I'd rather stay"), findsOneWidget);
    expect(signedOut, isFalse);

    await tester.tap(find.text("I'd rather stay"));
    await tester.pumpAndSettle();
    expect(find.text('What should we call you?'), findsOneWidget);
    expect(signedOut, isFalse);

    await tester.tap(find.byTooltip('Sign out'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Sign out'));
    await tester.pumpAndSettle();
    expect(signedOut, isTrue);
  });
}

Future<void> _finishIntro(WidgetTester tester) async {
  expect(find.text('What should we call you?'), findsNothing);

  await _typeIntroParagraph(tester, 'blocking distracting apps');
  await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
  await tester.pump();

  await _typeIntroParagraph(tester, 'press start');
  await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
  await tester.pump();

  await _typeIntroParagraph(tester, 'fixed duration');
  await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
  await tester.pump();

  await _typeIntroParagraph(tester, 'friends and family');
  expect(find.textContaining('blocking distracting apps'), findsOneWidget);

  await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
  await tester.pump();

  await _typeIntroParagraph(tester, 'digital detox');
  expect(find.textContaining('friends and family'), findsOneWidget);

  await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
  await _frames(tester);
  expect(find.text('What should we call you?'), findsOneWidget);

  await tester.tap(find.byTooltip('Back'));
  await _frames(tester);
  expect(find.textContaining('friends and family'), findsOneWidget);
  expect(find.textContaining('blocking distracting apps'), findsOneWidget);
  expect(find.byTooltip('Sign out'), findsNothing);
  expect(_continue(tester).onPressed, isNotNull);

  await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
  await _frames(tester);
}

Future<void> _typeIntroParagraph(WidgetTester tester, String snippet) async {
  await tester.tap(find.text('Foqui'));
  await tester.pump();
  expect(find.textContaining(snippet), findsOneWidget);
  expect(_continue(tester).onPressed, isNotNull);
}

FilledButton _continue(WidgetTester tester) => _filled(tester, 'Continue');

FilledButton _filled(WidgetTester tester, String label) {
  return tester.widget<FilledButton>(find.widgetWithText(FilledButton, label));
}

Future<void> _pump(
  WidgetTester tester,
  _Directory directory,
  MemoryFocusRepository repository, {
  UserProfile profile = const UserProfile(),
  AuthNotifier Function()? auth,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(auth ?? _LoggedIn.new),
        userRepositoryProvider.overrideWithValue(directory),
        focusRepositoryProvider.overrideWithValue(repository),
        focusShieldBridgeProvider.overrideWithValue(_QuietShield()),
      ],
      child: EasyLocalization(
        supportedLocales: foquiLocales,
        path: 'assets/translations',
        assetLoader: const FoquiAssetLoader(),
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        child: _Harness(profile: profile),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 50));
}

Future<void> _frames(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
}

class _Harness extends StatelessWidget {
  const _Harness({this.profile = const UserProfile()});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: AppTheme.dark,
      home: OnboardingScreen(profile: profile),
    );
  }
}

class _ReturningHarness extends StatelessWidget {
  const _ReturningHarness();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: AppTheme.dark,
      home: const OnboardingScreen(
        profile: UserProfile(alias: 'Marco', username: 'marco'),
      ),
    );
  }
}

class _LoggedIn extends AuthNotifier {
  @override
  Auth build() {
    return const Auth(loginState: LoginState.loggedIn, userId: 'test-user');
  }
}

class _RecordingAuth extends AuthNotifier {
  _RecordingAuth(this.onSignOut);

  final VoidCallback onSignOut;

  @override
  Auth build() {
    return const Auth(loginState: LoginState.loggedIn, userId: 'test-user');
  }

  @override
  Future<void> signOut() async {
    onSignOut();
  }
}

class _NoStoredSelection extends _QuietShield {
  @override
  bool get storesSelections => true;

  @override
  Future<Map<String, SelectionCounts>?> storedSelections(
    List<String> listIds,
  ) async {
    return const {};
  }
}

class _QuietShield extends FocusShieldBridge {
  @override
  Future<FamilyControlsAuthorization> status() async {
    return FamilyControlsAuthorization.notDetermined;
  }

  @override
  Future<FamilyControlsAuthorization> requestAuthorization() async {
    return FamilyControlsAuthorization.approved;
  }

  @override
  Future<SelectionCounts?> presentAppPicker(String listId) async {
    return const SelectionCounts(
      applicationCount: 2,
      categoryCount: 0,
      webDomainCount: 0,
    );
  }

  @override
  Future<SelectionCounts?> commitSelection(String listId) async {
    return const SelectionCounts(
      applicationCount: 2,
      categoryCount: 0,
      webDomainCount: 0,
    );
  }

  @override
  Future<void> stopSession() async {}

  @override
  Future<Map<String, List<String>>> applicationNames(
    List<String> listIds,
  ) async {
    return const {};
  }
}

class _Directory implements UserDirectory {
  _Directory({required this.taken, this.alias, this.username});

  final Set<String> taken;
  final lookups = <String>[];
  String? alias;
  String? username;
  var published = false;
  var completed = false;

  @override
  Stream<UserProfile> watchProfile() => const Stream<UserProfile>.empty();

  @override
  Future<bool> isUsernameAvailable(String normalized) async {
    lookups.add(normalized);
    return !taken.contains(normalized) || (normalized == username && published);
  }

  @override
  Future<void> saveProfile({
    required String alias,
    required String username,
  }) async {
    if (!Username.isValid(username) || !Username.isAliasValid(alias)) {
      throw ArgumentError('Invalid profile');
    }
    this.alias = alias;
    this.username = username;
    published = false;
  }

  @override
  Future<void> releaseUsername() async {
    published = false;
  }

  @override
  Future<void> completeOnboarding() async {
    final name = username;
    final savedAlias = alias;
    if (name == null ||
        savedAlias == null ||
        !Username.isValid(name) ||
        !Username.isAliasValid(savedAlias)) {
      throw ArgumentError('Invalid profile');
    }
    if (taken.contains(name)) throw const UsernameTaken();
    published = true;
    completed = true;
  }

  @override
  Future<void> createIfDoesNotExist() async {}
}
