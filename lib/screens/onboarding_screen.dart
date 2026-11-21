import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/tr.dart';
import '../models/block_list.dart';
import '../models/user_profile.dart';
import '../models/username.dart';
import '../repositories/user.dart';
import '../services/focus_shield_bridge.dart';
import '../state/auth.dart';
import '../state/focus_controller.dart';
import '../state/profile.dart';
import '../theme/app_theme.dart';
import '../widgets/welcome_frame.dart';
import 'app_shell.dart';
import 'sign_in_screen.dart';
import 'sign_out_sheet.dart';

const _usernamePause = Duration(milliseconds: 400);
const _stepDuration = Duration(milliseconds: 320);
const _stepTravel = 0.18;
const _introLead = Duration(milliseconds: 280);
const _introNext = Duration(milliseconds: 200);
const _introBlink = Duration(milliseconds: 530);

const _introParagraphKeys = [
  'onboarding_intro_1',
  'onboarding_intro_2',
  'onboarding_intro_3',
  'onboarding_intro_4',
  'onboarding_intro_5',
];

const _stepArt = {
  _Step.alias: 'assets/images/foqui.png',
  _Step.username: 'assets/images/foqui-couple.png',
  _Step.blockList: 'assets/images/foqui-study.png',
  _Step.permission: 'assets/images/foqui-deep-work.png',
  _Step.ready: 'assets/images/foqui-family.png',
};

/// Sends a signed-in person through onboarding until their profile is done.
class SignedInGate extends ConsumerWidget {
  const SignedInGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Widget tests sign in without starting Firebase. Skipping the profile
    // read keeps them in the app, and it avoids a listener that cannot start.
    if (Firebase.apps.isEmpty) return const AppShell();

    final profile = ref.watch(userProfileProvider);
    return switch (destinationFor(profile)) {
      SignedInDestination.loading => const AuthLoadingScreen(),
      SignedInDestination.onboarding => OnboardingScreen(
        profile: profile.requireValue,
      ),
      SignedInDestination.ready => const AppShell(),
      SignedInDestination.unavailable => const ProfileUnavailable(),
    };
  }
}

class ProfileUnavailable extends ConsumerWidget {
  const ProfileUnavailable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                tr('onboarding_profile_error'),
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(height: 1.35),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => ref.invalidate(userProfileProvider),
                child: Text(tr('screen_time_try_again')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _Step { intro, alias, username, permission, blockList, ready }

enum _HandleStatus { invalid, reserved, checking, available, taken, failed }

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key, required this.profile});

  final UserProfile profile;

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final TextEditingController _alias = TextEditingController(
    text: widget.profile.alias ?? '',
  );
  late final TextEditingController _username = TextEditingController(
    text: widget.profile.username ?? '',
  );
  late final TextEditingController _listName = TextEditingController(
    text: tr('list_default_name'),
  );
  final String _listId = defaultBlockListId;

  // Intro, alias, and username are the first three. A saved username resumes
  // on whatever comes after them.
  late int _stepIndex = widget.profile.username == null ? 0 : 3;
  var _introShown = 1;
  var _introCaughtUp = false;
  var _releasedHold = false;
  bool? _includeList;
  Timer? _usernameTimer;
  var _usernameGeneration = 0;
  String? _checkedUsername;
  _HandleStatus? _handle;
  var _forward = true;
  var _busy = false;
  var _apps = 0;
  var _categories = 0;
  var _websites = 0;
  var _names = const <String>[];
  var _touchedPicker = false;
  var _savedList = false;
  String? _listNote;
  var _artReady = false;

  int get _selectionCount => _apps + _categories + _websites;

  /// The step edits the account's block list, using the name it already has.
  void _prepareDefaultList(List<BlockList> lists) {
    for (final list in lists) {
      if (list.id != defaultBlockListId) continue;
      _listName.text = blockListTitle(id: list.id, name: list.name);
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    final existing = widget.profile.username;
    if (existing != null && existing == Username.normalize(_username.text)) {
      _handle = _HandleStatus.available;
      _checkedUsername = existing;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || _releasedHold) return;
        _releasedHold = true;
        unawaited(_releaseHold());
      });
    }
  }

  /// A username saved earlier is only a draft. Drop the directory document
  /// so leaving again does not keep the name.
  Future<void> _releaseHold() async {
    final directory = ref.read(userRepositoryProvider);
    if (directory == null) return;
    try {
      await directory.releaseUsername();
    } catch (error, stack) {
      debugPrint('Releasing username hold failed: $error\n$stack');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_artReady) return;
    _artReady = true;
    for (final image in _stepArt.values) {
      precacheImage(AssetImage(image), context);
    }
  }

  @override
  void dispose() {
    _usernameTimer?.cancel();
    if (_touchedPicker && !_savedList) {
      unawaited(ref.read(focusShieldBridgeProvider).discardDraft(_listId));
    }
    _alias.dispose();
    _username.dispose();
    _listName.dispose();
    super.dispose();
  }

  List<_Step> _steps() {
    return [
      _Step.intro,
      _Step.alias,
      _Step.username,
      _Step.permission,
      if (_includeList ?? false) _Step.blockList,
      _Step.ready,
    ];
  }

  bool get _canContinueAlias => Username.isAliasValid(_alias.text) && !_busy;

  void _onAliasChanged(String _) => setState(() {});

  void _onUsernameChanged(String value) {
    _usernameTimer?.cancel();
    final normalized = Username.normalize(value);
    _checkedUsername = null;
    if (normalized.isEmpty) {
      setState(() => _handle = null);
      return;
    }
    if (Username.isReserved(normalized)) {
      setState(() => _handle = _HandleStatus.reserved);
      return;
    }
    if (!Username.isFormatValid(normalized)) {
      setState(() => _handle = _HandleStatus.invalid);
      return;
    }

    setState(() => _handle = _HandleStatus.checking);
    final generation = ++_usernameGeneration;
    _usernameTimer = Timer(_usernamePause, () async {
      final directory = ref.read(userRepositoryProvider);
      if (directory == null) return;
      try {
        final available = await directory.isUsernameAvailable(normalized);
        if (!mounted || generation != _usernameGeneration) return;
        setState(() {
          _handle = available ? _HandleStatus.available : _HandleStatus.taken;
          _checkedUsername = normalized;
        });
      } on ProfileWriteException {
        if (!mounted || generation != _usernameGeneration) return;
        setState(() => _handle = _HandleStatus.failed);
      }
    });
  }

  bool get _canClaim {
    return Username.isAliasValid(_alias.text) &&
        _handle == _HandleStatus.available &&
        _checkedUsername == Username.normalize(_username.text) &&
        !_busy;
  }

  Future<void> _run(Future<void> Function() action) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await action();
    } on UsernameTaken {
      if (!mounted) return;
      final usernameIndex = _steps().indexOf(_Step.username);
      setState(() => _handle = _HandleStatus.taken);
      if (_stepIndex != usernameIndex) _goTo(usernameIndex);
    } on ProfileWriteException catch (error) {
      if (!mounted) return;
      _showMessage(
        error.offline ? tr('sign_in_offline') : tr('onboarding_save_failed'),
      );
    } catch (error, stack) {
      debugPrint('Onboarding failed: $error\n$stack');
      if (!mounted) return;
      _showMessage(tr('onboarding_save_failed'));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _continueFromIntro() {
    if (!_introCaughtUp) return;
    if (_introShown < _introParagraphKeys.length) {
      setState(() {
        _introShown++;
        _introCaughtUp = false;
      });
      return;
    }
    _goTo(_steps().indexOf(_Step.alias));
  }

  void _continueFromAlias() {
    if (!_canContinueAlias) return;
    _goTo(_steps().indexOf(_Step.username));
  }

  Future<void> _saveAndContinue() {
    final alias = _alias.text.trim();
    final username = Username.normalize(_username.text);
    return _run(() async {
      await ref
          .read(userRepositoryProvider)!
          .saveProfile(alias: alias, username: username);
      if (!mounted) return;
      _goTo(_stepIndex + 1);
    });
  }

  /// The username document is created here, together with finishing.
  /// Saving it earlier would hold the name when someone never gets this far.
  Future<void> _finish() {
    return _run(() async {
      await ref.read(userRepositoryProvider)!.completeOnboarding();
    });
  }

  Future<void> _pickApps() async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _listNote = null;
    });
    try {
      final authorization = await ref
          .read(authorizationProvider.notifier)
          .request();
      if (!mounted || !authorization.isAuthorized) return;
      final counts = await ref
          .read(focusShieldBridgeProvider)
          .presentAppPicker(_listId);
      if (!mounted || counts == null) return;
      setState(() {
        _apps = counts.applicationCount;
        _categories = counts.categoryCount;
        _websites = counts.webDomainCount;
        if (counts.applicationNames.isNotEmpty) {
          _names = counts.applicationNames;
        }
        _touchedPicker = true;
      });
    } on FocusShieldException catch (error) {
      if (!mounted) return;
      setState(() => _listNote = describeShieldFailure(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _saveList() {
    final name = storedBlockListName(id: _listId, typed: _listName.text);
    return _run(() async {
      var apps = _apps;
      var categories = _categories;
      var websites = _websites;
      var names = _names;
      if (_touchedPicker) {
        try {
          final counts = await ref
              .read(focusShieldBridgeProvider)
              .commitSelection(_listId);
          if (!mounted) return;
          if (counts == null || counts.total == 0) return;
          apps = counts.applicationCount;
          categories = counts.categoryCount;
          websites = counts.webDomainCount;
          if (counts.applicationNames.isNotEmpty) {
            names = counts.applicationNames;
          }
        } on FocusShieldException catch (error) {
          if (!mounted) return;
          setState(() => _listNote = describeShieldFailure(error));
          return;
        }
      }
      await ref
          .read(focusControllerProvider.notifier)
          .upsertList(
            BlockList(
              id: _listId,
              name: name,
              applicationCount: apps,
              categoryCount: categories,
              webDomainCount: websites,
              applicationNames: names,
              updatedAt: DateTime.now(),
              isFavorite: true,
            ),
          );
      _savedList = true;
      if (!mounted) return;
      _goTo(_steps().indexOf(_Step.ready));
    });
  }

  void _goTo(int index) {
    FocusManager.instance.primaryFocus?.unfocus();
    HapticFeedback.selectionClick();
    setState(() {
      _forward = index > _stepIndex;
      _stepIndex = index;
    });
  }

  Future<void> _confirmSignOut() async {
    final confirmed = await showSignOutSheet(context);
    if (!confirmed || !mounted) return;
    await ref.read(authProvider.notifier).signOut();
  }

  @override
  Widget build(BuildContext context) {
    final loaded = ref.watch(focusRepositoryProvider).hasLoaded;
    final focus = ref.watch(focusControllerProvider);
    if (_includeList == null) {
      // A list saved on the account is not enough. This phone has to have
      // the apps, or onboarding asks for them instead of skipping ahead.
      if (!loaded || !focus.selectionsReady) {
        return const WelcomeFrame(
          child: Center(child: CircularProgressIndicator()),
        );
      }
      _includeList = !focus.lists.any(
        (list) => list.id == defaultBlockListId && !list.isEmpty,
      );
      _prepareDefaultList(focus.lists);
    }

    final steps = _steps();
    final index = _stepIndex.clamp(0, steps.length - 1);
    final step = steps[index];
    final bottom = MediaQuery.viewInsetsOf(context).bottom;

    return WelcomeFrame(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(28, 12, 28, 16 + bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TopBar(
                stepIndex: index,
                stepCount: steps.length,
                showBack: index > 0,
                showSignOut: index > 0,
                busy: _busy,
                onBack: () => _goTo(index - 1),
                onSignOut: _confirmSignOut,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _StepSwitch(
                  step: step,
                  forward: _forward,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: step == _Step.intro
                            ? _body(step, compact: bottom > 0)
                            : SingleChildScrollView(
                                child: _body(step, compact: bottom > 0),
                              ),
                      ),
                      const SizedBox(height: 16),
                      ..._actions(step),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _markIntroCaughtUp() {
    if (!mounted || _introCaughtUp) return;
    setState(() => _introCaughtUp = true);
  }

  Widget _body(_Step step, {required bool compact}) {
    return switch (step) {
      _Step.intro => _IntroMessage(
        shown: _introShown,
        instant: _introCaughtUp && _introShown == _introParagraphKeys.length,
        onCaughtUp: _markIntroCaughtUp,
      ),
      _Step.alias => _AliasBody(
        alias: _alias,
        compact: compact,
        canContinue: _canContinueAlias,
        onChanged: _onAliasChanged,
        onContinue: _continueFromAlias,
      ),
      _Step.username => _UsernameBody(
        username: _username,
        status: _handle,
        compact: compact,
        canContinue: _canClaim,
        onChanged: _onUsernameChanged,
        onContinue: _saveAndContinue,
      ),
      _Step.ready => _ReadyBody(compact: compact),
      _Step.permission => _PermissionBody(compact: compact),
      _Step.blockList => _BlockListBody(
        name: _listName,
        summary: BlockList(
          id: _listId,
          name: _listName.text,
          applicationCount: _apps,
          categoryCount: _categories,
          webDomainCount: _websites,
          updatedAt: DateTime.now(),
        ).summary,
        note: _listNote,
        busy: _busy,
        compact: compact,
        onNameChanged: (_) => setState(() {}),
        onPick: _pickApps,
      ),
    };
  }

  List<Widget> _actions(_Step step) {
    return switch (step) {
      _Step.intro => [
        _PrimaryButton(
          label: tr('onboarding_continue'),
          busy: false,
          enabled: _introCaughtUp,
          hidden: !_introCaughtUp,
          onPressed: _continueFromIntro,
        ),
      ],
      _Step.alias => [
        _PrimaryButton(
          label: tr('onboarding_continue'),
          busy: _busy,
          enabled: _canContinueAlias,
          onPressed: _continueFromAlias,
        ),
      ],
      _Step.username => [
        _PrimaryButton(
          label: tr('onboarding_continue'),
          busy: _busy,
          enabled: _canClaim,
          onPressed: _saveAndContinue,
        ),
      ],
      _Step.ready => [
        _PrimaryButton(
          label: tr('onboarding_ready_start'),
          busy: _busy,
          enabled: !_busy,
          onPressed: _finish,
        ),
      ],
      _Step.permission => [
        _PrimaryButton(
          label: tr('onboarding_continue'),
          busy: _busy,
          enabled: !_busy,
          onPressed: () => _goTo(_stepIndex + 1),
        ),
      ],
      _Step.blockList => [
        _PrimaryButton(
          label: tr('onboarding_continue'),
          busy: _busy,
          enabled:
              !_busy && _selectionCount > 0 && _listName.text.trim().isNotEmpty,
          onPressed: _saveList,
        ),
      ],
    };
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.stepIndex,
    required this.stepCount,
    required this.showBack,
    required this.showSignOut,
    required this.busy,
    required this.onBack,
    required this.onSignOut,
  });

  final int stepIndex;
  final int stepCount;
  final bool showBack;
  final bool showSignOut;
  final bool busy;
  final VoidCallback onBack;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    final style = TextButton.styleFrom(
      foregroundColor: muted,
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
    return SizedBox(
      height: 36,
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: _BarAction(
                shown: showBack,
                label: tr('common_back'),
                icon: CupertinoIcons.chevron_back,
                style: style,
                onPressed: busy ? null : onBack,
              ),
            ),
          ),
          _StepDots(index: stepIndex, count: stepCount),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: showSignOut
                    ? _BarAction(
                        shown: true,
                        label: tr('home_sign_out'),
                        icon: CupertinoIcons.square_arrow_right,
                        alignEnd: true,
                        style: style,
                        onPressed: busy ? null : onSignOut,
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BarAction extends StatelessWidget {
  const _BarAction({
    required this.shown,
    required this.label,
    required this.style,
    required this.onPressed,
    this.icon,
    this.alignEnd = false,
  });

  final bool shown;
  final String label;
  final ButtonStyle style;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    final button = icon == null
        ? TextButton(onPressed: onPressed, style: style, child: Text(label))
        : IconButton(
            tooltip: label,
            onPressed: onPressed,
            style: IconButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
              padding: EdgeInsets.zero,
              fixedSize: const Size(36, 36),
              minimumSize: const Size(36, 36),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: alignEnd
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
            ),
            icon: Icon(icon, size: 22),
          );

    return IgnorePointer(
      ignoring: !shown,
      child: ExcludeSemantics(
        excluding: !shown,
        child: AnimatedOpacity(
          opacity: shown ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: button,
        ),
      ),
    );
  }
}

class _StepDots extends StatelessWidget {
  const _StepDots({required this.index, required this.count});

  final int index;
  final int count;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      label: tr('onboarding_step', args: ['${index + 1}', '$count']),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < count; i++) ...[
            if (i > 0) const SizedBox(width: 6),
            AnimatedContainer(
              duration: _stepDuration,
              curve: Curves.easeOutCubic,
              height: 5,
              width: i == index ? 28 : 8,
              decoration: BoxDecoration(
                color: i <= index ? scheme.primary : FoquiWelcome.track,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StepSwitch extends StatelessWidget {
  const _StepSwitch({
    required this.step,
    required this.forward,
    required this.child,
  });

  final _Step step;
  final bool forward;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final stepKey = ValueKey(step);
    final enter = Offset(forward ? _stepTravel : -_stepTravel, 0);
    return ClipRect(
      child: AnimatedSwitcher(
        duration: _stepDuration,
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        layoutBuilder: (currentChild, previousChildren) {
          return Stack(
            alignment: Alignment.topCenter,
            fit: StackFit.expand,
            children: [...previousChildren, ?currentChild],
          );
        },
        transitionBuilder: (child, animation) {
          final incoming = child.key == stepKey;
          return IgnorePointer(
            ignoring: !incoming,
            child: FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: incoming ? enter : -enter,
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
          );
        },
        child: KeyedSubtree(key: stepKey, child: child),
      ),
    );
  }
}

/// Types one paragraph at a time, a character per tick, like someone writing.
/// A tap finishes the paragraph that's in progress.
class _IntroMessage extends StatefulWidget {
  const _IntroMessage({
    required this.shown,
    required this.instant,
    required this.onCaughtUp,
  });

  /// Paragraphs revealed so far, including the one being typed.
  final int shown;

  /// The whole message is already on screen. Used when coming back.
  final bool instant;
  final VoidCallback onCaughtUp;

  @override
  State<_IntroMessage> createState() => _IntroMessageState();
}

class _IntroMessageState extends State<_IntroMessage> {
  late final List<String> _paragraphs = [
    for (final key in _introParagraphKeys) tr(key),
  ];
  final ScrollController _scroll = ScrollController();
  var _paragraph = 0;
  var _count = 0;
  var _settled = false;
  var _cursorOn = true;
  var _started = false;
  var _reduceMotion = false;
  Timer? _timer;
  Timer? _blink;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    _reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (widget.instant) {
      _showComplete();
      return;
    }
    if (_reduceMotion) {
      _showComplete();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) widget.onCaughtUp();
      });
      return;
    }
    _startBlink();
    _schedule(_introLead);
  }

  @override
  void didUpdateWidget(covariant _IntroMessage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shown == oldWidget.shown) return;
    _timer?.cancel();
    _paragraph = widget.shown - 1;
    _count = 0;
    _settled = false;
    if (_reduceMotion || widget.instant) {
      _showComplete();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) widget.onCaughtUp();
      });
      return;
    }
    _startBlink();
    _schedule(_introNext);
    _follow(force: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _blink?.cancel();
    _scroll.dispose();
    super.dispose();
  }

  void _showComplete() {
    _timer?.cancel();
    _blink?.cancel();
    _paragraph = widget.shown - 1;
    _count = _paragraphs[_paragraph].length;
    _settled = true;
  }

  void _startBlink() {
    _blink?.cancel();
    _cursorOn = true;
    _blink = Timer.periodic(_introBlink, (_) {
      if (!mounted || _settled) return;
      setState(() => _cursorOn = !_cursorOn);
    });
  }

  void _schedule(Duration delay) {
    _timer?.cancel();
    _timer = Timer(delay, _advance);
  }

  void _advance() {
    if (!mounted || _settled) return;
    final text = _paragraphs[_paragraph];
    if (_count >= text.length) {
      _settle();
      return;
    }
    final index = _count;
    setState(() => _count++);
    if (text[index].trim().isNotEmpty) HapticFeedback.selectionClick();
    _schedule(_pace(text, index));
    _follow();
  }

  /// A short pause after punctuation, and a little unevenness on the letters,
  /// so the line feels typed rather than played back at one speed.
  Duration _pace(String text, int index) {
    final char = text[index];
    final next = index + 1 < text.length ? text[index + 1] : '';
    if ((char == '.' || char == '!' || char == '?') &&
        (next.isEmpty || next == ' ')) {
      return const Duration(milliseconds: 280);
    }
    if (char == ',') return const Duration(milliseconds: 150);
    if (char == ' ') return const Duration(milliseconds: 28);
    return Duration(milliseconds: 42 + char.codeUnitAt(0) % 3 * 12);
  }

  void _settle() {
    if (_settled) return;
    _timer?.cancel();
    _blink?.cancel();
    setState(() {
      _settled = true;
      _count = _paragraphs[_paragraph].length;
    });
    widget.onCaughtUp();
  }

  void _follow({bool force = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scroll.hasClients) return;
      final position = _scroll.position;
      if (position.maxScrollExtent <= 0) return;
      final nearBottom = position.pixels >= position.maxScrollExtent - 64;
      if (!force && !nearBottom && position.pixels > 0) return;
      position.jumpTo(position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.bodyLarge?.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      height: 1.45,
      letterSpacing: -0.2,
    );
    final shown = _paragraphs.take(widget.shown).toList();
    return Semantics(
      container: true,
      label: shown.join('\n\n'),
      child: ExcludeSemantics(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _settled ? null : _settle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Row(
                children: [
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: FoquiWelcome.stage,
                    ),
                    child: SizedBox.square(
                      dimension: 52,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(6, 8, 6, 4),
                        child: Image.asset(
                          'assets/images/foqui.png',
                          fit: BoxFit.contain,
                          excludeFromSemantics: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Foqui',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scroll,
                  child: Text.rich(
                    TextSpan(
                      style: style,
                      children: [
                        for (var i = 0; i < shown.length; i++) ...[
                          if (i > 0) const TextSpan(text: '\n\n'),
                          TextSpan(
                            text: i < _paragraph
                                ? _paragraphs[i]
                                : _paragraphs[i].substring(0, _count),
                          ),
                        ],
                        if (!_settled)
                          TextSpan(
                            text: '|',
                            style: TextStyle(
                              color: _cursorOn
                                  ? theme.colorScheme.primary
                                  : Colors.transparent,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AliasBody extends StatelessWidget {
  const _AliasBody({
    required this.alias,
    required this.compact,
    required this.canContinue,
    required this.onChanged,
    required this.onContinue,
  });

  final TextEditingController alias;
  final bool compact;
  final bool canContinue;
  final ValueChanged<String> onChanged;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _StepIntro(
          image: _stepArt[_Step.alias]!,
          title: tr('onboarding_alias_title'),
          body: tr('onboarding_alias_body'),
          compact: compact,
        ),
        TextField(
          controller: alias,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.nickname],
          onChanged: onChanged,
          onSubmitted: (_) {
            if (canContinue) onContinue();
          },
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            labelText: tr('onboarding_alias_label'),
            counterText: '',
          ),
          maxLength: Username.maxAliasLength,
        ),
      ],
    );
  }
}

class _UsernameBody extends StatelessWidget {
  const _UsernameBody({
    required this.username,
    required this.status,
    required this.compact,
    required this.canContinue,
    required this.onChanged,
    required this.onContinue,
  });

  final TextEditingController username;
  final _HandleStatus? status;
  final bool compact;
  final bool canContinue;
  final ValueChanged<String> onChanged;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _StepIntro(
          image: _stepArt[_Step.username]!,
          title: tr('onboarding_username_title'),
          body: tr('onboarding_username_body'),
          compact: compact,
        ),
        TextField(
          controller: username,
          autofocus: true,
          autocorrect: false,
          enableSuggestions: false,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.newUsername],
          onChanged: onChanged,
          onSubmitted: (_) {
            if (canContinue) onContinue();
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
            TextInputFormatter.withFunction((oldValue, newValue) {
              return newValue.copyWith(text: newValue.text.toLowerCase());
            }),
          ],
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          maxLength: Username.maxLength,
          decoration: InputDecoration(
            labelText: tr('onboarding_username_label'),
            prefixText: '@ ',
            prefixStyle: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            counterText: '',
          ),
        ),
        const SizedBox(height: 8),
        _HandleLine(status: status),
      ],
    );
  }
}

class _ReadyBody extends StatelessWidget {
  const _ReadyBody({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _StepIntro(
          image: _stepArt[_Step.ready]!,
          title: tr('onboarding_ready_title'),
          body: tr('onboarding_ready_body'),
          compact: compact,
        ),
      ],
    );
  }
}

class _PermissionBody extends StatelessWidget {
  const _PermissionBody({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _StepIntro(
          image: _stepArt[_Step.permission]!,
          title: tr('onboarding_permission_title'),
          body: tr('onboarding_permission_body'),
          compact: compact,
        ),
      ],
    );
  }
}

class _BlockListBody extends ConsumerWidget {
  const _BlockListBody({
    required this.name,
    required this.summary,
    required this.note,
    required this.busy,
    required this.compact,
    required this.onNameChanged,
    required this.onPick,
  });

  final TextEditingController name;
  final String summary;
  final String? note;
  final bool busy;
  final bool compact;
  final ValueChanged<String> onNameChanged;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final status = ref.watch(authorizationProvider).asData?.value;
    final required =
        status != null &&
        status != FamilyControlsAuthorization.approved &&
        status != FamilyControlsAuthorization.unavailable;
    final shown = switch (status) {
      null || FamilyControlsAuthorization.approved => note,
      FamilyControlsAuthorization.unavailable => tr(
        'onboarding_permission_unavailable',
      ),
      _ => tr('onboarding_permission_required'),
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _StepIntro(
          image: _stepArt[_Step.blockList]!,
          title: tr('onboarding_list_title'),
          body: tr('onboarding_list_body'),
          compact: compact,
        ),
        TextField(
          controller: name,
          textCapitalization: TextCapitalization.sentences,
          onChanged: onNameChanged,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(labelText: tr('common_name')),
        ),
        const SizedBox(height: 12),
        Material(
          color: theme.colorScheme.surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: theme.colorScheme.outlineVariant),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: busy ? null : onPick,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('list_choose_apps'),
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(summary, style: _body(theme)),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (shown != null) ...[
          const SizedBox(height: 12),
          Text(
            shown,
            style: _body(theme)?.copyWith(
              color: required ? const Color(0xFF30D158) : null,
            ),
          ),
        ],
      ],
    );
  }
}

class _HandleLine extends StatelessWidget {
  const _HandleLine({required this.status});

  final _HandleStatus? status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (text, color) = switch (status) {
      null => (
        tr('onboarding_username_rules'),
        theme.colorScheme.onSurfaceVariant,
      ),
      _HandleStatus.invalid => (
        tr('onboarding_username_invalid'),
        theme.colorScheme.error,
      ),
      _HandleStatus.reserved => (
        tr('onboarding_username_reserved'),
        theme.colorScheme.error,
      ),
      _HandleStatus.checking => (
        tr('onboarding_username_checking'),
        theme.colorScheme.onSurfaceVariant,
      ),
      _HandleStatus.available => (
        tr('onboarding_username_available'),
        theme.colorScheme.primary,
      ),
      _HandleStatus.taken => (
        tr('onboarding_username_taken'),
        theme.colorScheme.error,
      ),
      _HandleStatus.failed => (
        tr('onboarding_username_error'),
        theme.colorScheme.error,
      ),
    };
    return Text(
      text,
      style: theme.textTheme.bodyMedium?.copyWith(color: color, height: 1.3),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.busy,
    required this.enabled,
    required this.onPressed,
    this.hidden = false,
  });

  final String label;
  final bool busy;
  final bool enabled;
  final VoidCallback onPressed;
  final bool hidden;

  @override
  Widget build(BuildContext context) {
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    final shown = !hidden;
    return ExcludeSemantics(
      excluding: !shown,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        opacity: !shown ? 0 : (enabled ? 1 : 0.45),
        child: FilledButton(
          onPressed: shown && enabled ? onPressed : null,
          child: busy
              ? SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: onPrimary,
                  ),
                )
              : Text(label),
        ),
      ),
    );
  }
}

TextStyle? _title(ThemeData theme) {
  return theme.textTheme.headlineMedium?.copyWith(
    fontWeight: FontWeight.w800,
    letterSpacing: -0.8,
    height: 1.12,
  );
}

TextStyle? _body(ThemeData theme) {
  return theme.textTheme.bodyLarge?.copyWith(
    color: theme.colorScheme.onSurfaceVariant,
    height: 1.35,
  );
}

class _StepIntro extends StatelessWidget {
  const _StepIntro({
    required this.image,
    required this.title,
    required this.body,
    required this.compact,
  });

  final String image;
  final String title;
  final String body;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _StepArt(image: image, compact: compact),
        Text(title, textAlign: TextAlign.start, style: _title(theme)),
        const SizedBox(height: 10),
        Text(body, textAlign: TextAlign.start, style: _body(theme)),
        const SizedBox(height: 28),
      ],
    );
  }
}

class _StepArt extends StatelessWidget {
  const _StepArt({required this.image, required this.compact});

  final String image;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      alignment: Alignment.topCenter,
      child: compact
          ? const SizedBox(width: double.infinity)
          : Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: SizedBox(
                height: 188,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    const Positioned(
                      bottom: 10,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: FoquiWelcome.stage,
                        ),
                        child: SizedBox.square(dimension: 132),
                      ),
                    ),
                    Positioned.fill(
                      child: Image.asset(
                        image,
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter,
                        excludeFromSemantics: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
