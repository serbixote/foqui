import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/tr.dart';
import '../state/auth.dart';
import '../widgets/sheet_header.dart';
import '../widgets/welcome_frame.dart';

const _scenes = [
  (labelKey: 'label_study', image: 'assets/images/foqui-study.png'),
  (labelKey: 'label_deep_work', image: 'assets/images/foqui-deep-work.png'),
  (labelKey: 'label_couple', image: 'assets/images/foqui-couple.png'),
  (labelKey: 'label_family', image: 'assets/images/foqui-family.png'),
];
const _focusLead = Duration(milliseconds: 700);
const _focusInterval = Duration(milliseconds: 1600);
const _switchDuration = Duration(milliseconds: 320);

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  var _busy = false;
  var _focusIndex = 0;
  var _imagesReady = false;
  Timer? _focusTimer;

  @override
  void initState() {
    super.initState();
    _scheduleFocus(first: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_imagesReady) return;
    _imagesReady = true;
    for (final scene in _scenes) {
      precacheImage(AssetImage(scene.image), context);
    }
  }

  void _scheduleFocus({required bool first}) {
    _focusTimer = Timer(first ? _focusLead : _focusInterval, () {
      if (!mounted) return;
      setState(() => _focusIndex = (_focusIndex + 1) % _scenes.length);
      _scheduleFocus(first: false);
    });
  }

  @override
  void dispose() {
    _focusTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scene = _scenes[_focusIndex];
    final sceneLabel = tr(scene.labelKey);

    return WelcomeFrame(
      warm: false,
      // Onboarding signs out with the keyboard still open. This screen has
      // no fields, so that inset should not squash the column.
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 88, 28, 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final theme = Theme.of(context);
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Foqui',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1.2,
                            height: 1.05,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Semantics(
                          container: true,
                          liveRegion: true,
                          label: tr('sign_in_blocks_named', args: [sceneLabel]),
                          child: ExcludeSemantics(
                            child: Column(
                              children: [
                                Text(
                                  tr('sign_in_blocks'),
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: theme.colorScheme.onSurface,
                                    fontWeight: FontWeight.w500,
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                SizedBox(
                                  height: 64,
                                  width: double.infinity,
                                  child: _FocusSwitch(
                                    sceneKey: ValueKey(scene.labelKey),
                                    slide: const Offset(0, 0.45),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        sceneLabel,
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.displayMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: -1,
                                              color: theme.colorScheme.primary,
                                              height: 1,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 168,
                          width: double.infinity,
                          child: ClipRect(
                            child: _FocusSwitch(
                              sceneKey: ValueKey(scene.image),
                              child: Image.asset(
                                scene.image,
                                fit: BoxFit.contain,
                                alignment: Alignment.topCenter,
                                excludeFromSemantics: true,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(height: 16),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 150),
                          opacity: _busy ? 0.5 : 1,
                          child: FilledButton(
                            onPressed: _busy ? null : _start,
                            style: FilledButton.styleFrom(
                              disabledBackgroundColor:
                                  theme.colorScheme.primary,
                              disabledForegroundColor:
                                  theme.colorScheme.onPrimary,
                            ),
                            child: _busy
                                ? SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: theme.colorScheme.onPrimary,
                                    ),
                                  )
                                : Text(tr('sign_in_start')),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<User?> _google() {
    return ref.read(authProvider.notifier).signInWithGoogle();
  }

  Future<User?> _apple() {
    return ref.read(authProvider.notifier).signInWithApple();
  }

  Future<void> _start() async {
    final method = await showModalBottomSheet<_SignInMethod>(
      context: context,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => const _SignInSheet(),
    );
    if (method == null || !mounted) return;
    await _signIn(switch (method) {
      _SignInMethod.apple => _apple,
      _SignInMethod.google => _google,
    });
  }

  Future<void> _signIn(Future<User?> Function() signIn) async {
    setState(() => _busy = true);
    try {
      final user = await signIn();
      if (user == null || !mounted) return;
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(_message(error))));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}

class _FocusSwitch extends StatelessWidget {
  const _FocusSwitch({
    required this.sceneKey,
    required this.child,
    this.slide = const Offset(0, 0.08),
  });

  final Key sceneKey;
  final Widget child;
  final Offset slide;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: _switchDuration,
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [...previousChildren, ?currentChild],
        );
      },
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: slide,
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: KeyedSubtree(key: sceneKey, child: child),
    );
  }
}

enum _SignInMethod { apple, google }

class _SignInSheet extends StatelessWidget {
  const _SignInSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, kSheetBottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetGrabber(),
          SheetHeader(title: tr('sign_in_title')),
          const SizedBox(height: 8),
          _SignInButton(
            label: tr('sign_in_apple'),
            icon: const Icon(Icons.apple, size: 22),
            background: isDark ? Colors.white : Colors.black,
            foreground: isDark ? Colors.black : Colors.white,
            onPressed: () => Navigator.pop(context, _SignInMethod.apple),
          ),
          const SizedBox(height: 12),
          _SignInButton(
            label: tr('sign_in_google'),
            icon: const Text(
              'G',
              style: TextStyle(
                color: Color(0xFF4285F4),
                fontSize: 18,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
            background: Colors.white,
            foreground: Colors.black,
            border: BorderSide(color: theme.colorScheme.outlineVariant),
            onPressed: () => Navigator.pop(context, _SignInMethod.google),
          ),
        ],
      ),
    );
  }
}

class AuthLoadingScreen extends StatelessWidget {
  const AuthLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
    required this.onPressed,
    this.border,
  });

  final String label;
  final Widget icon;
  final Color background;
  final Color foreground;
  final VoidCallback? onPressed;
  final BorderSide? border;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(label),
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        backgroundColor: background,
        foregroundColor: foreground,
        disabledBackgroundColor: background.withValues(alpha: 0.6),
        disabledForegroundColor: foreground.withValues(alpha: 0.6),
        side: border,
        shape: const StadiumBorder(),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
      ),
    );
  }
}

String _message(Object error) {
  if (error is FirebaseAuthException) {
    switch (error.code) {
      case 'account-exists-with-different-credential':
        return tr('sign_in_email_in_use');
      case 'network-request-failed':
        return tr('sign_in_offline');
    }
  }
  return tr('sign_in_failed');
}
