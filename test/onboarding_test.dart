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

  testWidgets('onboarding requires a block list and leaves Screen Time last', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final directory = _Directory(taken: {'takenname'});
    final repository = MemoryFocusRepository();
    await _pump(tester, directory, repository);

    expect(find.text('What should we call you?'), findsOneWidget);
    expect(find.text('Alias'), findsOneWidget);
    expect(find.text('Pick a username'), findsNothing);
    expect(_continue(tester).onPressed, isNull);

    await tester.enterText(find.byType(TextField), 'Ada');
    await tester.pump();
    expect(_continue(tester).onPressed, isNotNull);

    await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
    await _frames(tester);

    expect(find.text('Pick a username'), findsOneWidget);
    expect(find.text('3–20 letters, numbers, or underscores.'), findsOneWidget);

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
    expect(find.text('Your default block list'), findsOneWidget);
    expect(find.text('Default'), findsOneWidget);
    expect(find.text("I'll do this later"), findsNothing);
    expect(_continue(tester).onPressed, isNull);
    expect(directory.completed, isFalse);

    await tester.tap(find.text('Choose apps'));
    await _frames(tester);
    expect(_continue(tester).onPressed, isNotNull);

    await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
    await _frames(tester);

    final saved = repository.lists.singleWhere(
      (list) => list.id == defaultBlockListId,
    );
    expect(saved.name, defaultBlockListName);
    expect(saved.isFavorite, isTrue);
    expect(saved.applicationCount, 2);
    expect(find.text('Screen Time'), findsOneWidget);
    expect(find.text('Not now'), findsOneWidget);
    expect(directory.completed, isFalse);

    await tester.tap(find.text('Not now'));
    await _frames(tester);
    expect(directory.completed, isTrue);
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

    expect(find.text('Your default block list'), findsOneWidget);
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller?.text,
      'Default',
    );
    expect(
      repository.lists.singleWhere((list) => list.id == 'social').isEmpty,
      isTrue,
    );
    expect(find.text('Screen Time'), findsNothing);
  });
}

FilledButton _continue(WidgetTester tester) => _filled(tester, 'Continue');

FilledButton _filled(WidgetTester tester, String label) {
  return tester.widget<FilledButton>(find.widgetWithText(FilledButton, label));
}

Future<void> _pump(
  WidgetTester tester,
  _Directory directory,
  MemoryFocusRepository repository,
) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(_LoggedIn.new),
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
        child: const _Harness(),
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
  const _Harness();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: AppTheme.dark,
      home: const OnboardingScreen(profile: UserProfile()),
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
  _Directory({required this.taken});

  final Set<String> taken;
  final lookups = <String>[];
  String? alias;
  String? username;
  var completed = false;

  @override
  Stream<UserProfile> watchProfile() => const Stream<UserProfile>.empty();

  @override
  Future<bool> isUsernameAvailable(String normalized) async {
    lookups.add(normalized);
    return !taken.contains(normalized) || normalized == username;
  }

  @override
  Future<void> claimProfile({
    required String alias,
    required String username,
  }) async {
    if (!Username.isValid(username) || !Username.isAliasValid(alias)) {
      throw ArgumentError('Invalid profile');
    }
    if (!await isUsernameAvailable(username)) throw const UsernameTaken();
    this.alias = alias;
    this.username = username;
  }

  @override
  Future<void> completeOnboarding() async {
    completed = true;
  }

  @override
  Future<void> createIfDoesNotExist() async {}
}
