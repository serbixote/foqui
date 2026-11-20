import 'dart:async';
import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'l10n/tr.dart';
import 'repositories/user.dart';
import 'screens/onboarding_screen.dart';
import 'screens/sign_in_screen.dart';
import 'state/auth.dart';
import 'state/focus_controller.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await loadEnglishCatalog();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  try {
    await initializeGoogleSignIn();
  } catch (error, stack) {
    debugPrint('Google Sign-In setup failed: $error\n$stack');
  }

  runApp(const ProviderScope(child: FoquiApp()));
}

class FoquiApp extends StatelessWidget {
  const FoquiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: foquiLocales,
      path: 'assets/translations',
      assetLoader: const FoquiAssetLoader(),
      fallbackLocale: const Locale('en'),
      useOnlyLangCode: true,
      useFallbackTranslations: true,
      saveLocale: false,
      startLocale: Platform.environment.containsKey('FLUTTER_TEST')
          ? const Locale('en')
          : null,
      child: const FoquiRoot(),
    );
  }
}

class FoquiRoot extends ConsumerWidget {
  const FoquiRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (previous, next) {
      _onAuthChanged(ref, previous, next);
    });
    final auth = ref.watch(authProvider);

    return MaterialApp(
      title: 'Foqui',
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: switch (auth.loginState) {
        LoginState.unknown => const AuthLoadingScreen(),
        LoginState.loggedOut => const SignInScreen(),
        LoginState.loggedIn => const SignedInGate(),
      },
    );
  }
}

void _onAuthChanged(WidgetRef ref, Auth? previous, Auth next) {
  if (previous?.isLoggedIn == true && !next.isLoggedIn) {
    final bridge = ref.read(focusShieldBridgeProvider);
    unawaited(bridge.stopSession());
  }
  if (!next.isLoggedIn || previous?.userId == next.userId) return;

  final repository = ref.read(userRepositoryProvider);
  unawaited(_prepareUser(repository));
}

Future<void> _prepareUser(UserDirectory? repository) async {
  try {
    await FirebaseAuth.instance.currentUser?.getIdToken(true);
    await repository?.createIfDoesNotExist();
  } catch (error, stack) {
    debugPrint('Could not prepare the signed-in user: $error\n$stack');
  }
}
