import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

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
import 'app_shell.dart';
import 'sign_in_screen.dart';

const _uuid = Uuid();
const _usernamePause = Duration(milliseconds: 400);

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

enum _Step { alias, username, permission, blockList }

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
    text: tr('session_focus_fallback'),
  );
  String? _listId;

  late int _stepIndex = widget.profile.username == null ? 0 : 2;
  bool? _includeList;
  Timer? _usernameTimer;
  var _usernameGeneration = 0;
  String? _checkedUsername;
  _HandleStatus? _handle;
  var _busy = false;
  var _apps = 0;
  var _categories = 0;
  var _websites = 0;
  var _names = const <String>[];
  var _touchedPicker = false;
  var _savedList = false;
  String? _permissionNote;
  String? _listNote;

  int get _selectionCount => _apps + _categories + _websites;

  String _requireListId() => _listId ??= _uuid.v4();

  /// Fills the step with the list already on the account when it has no apps.
  void _adoptEmptyList(List<BlockList> lists) {
    BlockList? repair;
    for (final list in lists) {
      if (!list.isEmpty) continue;
      if (repair == null || (list.isFavorite && !repair.isFavorite)) {
        repair = list;
      }
    }
    if (repair == null) return;
    _listId = repair.id;
    _listName.text = repair.name;
  }

  @override
  void initState() {
    super.initState();
    final existing = widget.profile.username;
    if (existing != null && existing == Username.normalize(_username.text)) {
      _handle = _HandleStatus.available;
      _checkedUsername = existing;
    }
  }

  @override
  void dispose() {
    _usernameTimer?.cancel();
    final listId = _listId;
    if (listId != null && _touchedPicker && !_savedList) {
      unawaited(ref.read(focusShieldBridgeProvider).discardDraft(listId));
    }
    _alias.dispose();
    _username.dispose();
    _listName.dispose();
    super.dispose();
  }

  List<_Step> _steps() {
    return [
      _Step.alias,
      _Step.username,
      if (_includeList ?? false) _Step.blockList,
      _Step.permission,
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
    if (normalized == widget.profile.username) {
      setState(() {
        _handle = _HandleStatus.available;
        _checkedUsername = normalized;
      });
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
      setState(() => _handle = _HandleStatus.taken);
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

  void _continueFromAlias() {
    if (!_canContinueAlias) return;
    _goTo(1);
  }

  Future<void> _claimAndContinue() {
    final alias = _alias.text.trim();
    final username = Username.normalize(_username.text);
    return _run(() async {
      await ref
          .read(userRepositoryProvider)!
          .claimProfile(alias: alias, username: username);
      if (!mounted) return;
      _goTo(2);
    });
  }

  Future<void> _allowScreenTime() {
    return _run(() async {
      final current = ref.read(authorizationProvider).asData?.value;
      if (current != null &&
          (current.isAuthorized ||
              current == FamilyControlsAuthorization.unavailable)) {
        await _leavePermission();
        return;
      }
      final status = await ref.read(authorizationProvider.notifier).request();
      if (!mounted) return;
      if (status.isAuthorized) {
        await _leavePermission();
        return;
      }
      setState(() {
        _permissionNote = switch (status) {
          FamilyControlsAuthorization.unavailable => tr(
            'onboarding_permission_unavailable',
          ),
          FamilyControlsAuthorization.denied => tr('shield_not_authorized'),
          _ => tr('home_screen_time_unknown'),
        };
      });
    });
  }

  Future<void> _leavePermission() async {
    await ref.read(userRepositoryProvider)!.completeOnboarding();
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
      if (!mounted) return;
      if (!authorization.isAuthorized) {
        setState(() {
          _listNote = authorization == FamilyControlsAuthorization.unavailable
              ? tr('onboarding_permission_unavailable')
              : tr('shield_not_authorized');
        });
        return;
      }
      final counts = await ref
          .read(focusShieldBridgeProvider)
          .presentAppPicker(_requireListId());
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
    final name = _listName.text.trim();
    return _run(() async {
      var apps = _apps;
      var categories = _categories;
      var websites = _websites;
      var names = _names;
      if (_touchedPicker) {
        try {
          final counts = await ref
              .read(focusShieldBridgeProvider)
              .commitSelection(_requireListId());
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
              id: _requireListId(),
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
      _goTo(_steps().indexOf(_Step.permission));
    });
  }

  void _goTo(int index) {
    FocusManager.instance.primaryFocus?.unfocus();
    HapticFeedback.selectionClick();
    setState(() => _stepIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final loaded = ref.watch(focusRepositoryProvider).hasLoaded;
    final focus = ref.watch(focusControllerProvider);
    if (_includeList == null) {
      // A list saved on the account is not enough. This phone has to have
      // the apps, or onboarding asks for them instead of skipping ahead.
      if (!loaded || !focus.selectionsReady) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      _includeList = !focus.lists.any((list) => !list.isEmpty);
      _adoptEmptyList(focus.lists);
    }

    final steps = _steps();
    final index = _stepIndex.clamp(0, steps.length - 1);
    final step = steps[index];
    final bottom = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(28, 12, 28, 16 + bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TopBar(
                showBack: index > 0,
                showSignOut: index == 0,
                busy: _busy,
                onBack: () => _goTo(index - 1),
                onSignOut: () => ref.read(authProvider.notifier).signOut(),
              ),
              const SizedBox(height: 12),
              _StepDots(index: index, count: steps.length),
              const SizedBox(height: 28),
              Expanded(child: SingleChildScrollView(child: _body(step))),
              const SizedBox(height: 16),
              ..._actions(step),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(_Step step) {
    return switch (step) {
      _Step.alias => _AliasBody(
        alias: _alias,
        canContinue: _canContinueAlias,
        onChanged: _onAliasChanged,
        onContinue: _continueFromAlias,
      ),
      _Step.username => _UsernameBody(
        username: _username,
        status: _handle,
        canContinue: _canClaim,
        onChanged: _onUsernameChanged,
        onContinue: _claimAndContinue,
      ),
      _Step.permission => _PermissionBody(note: _permissionNote),
      _Step.blockList => _BlockListBody(
        name: _listName,
        summary: BlockList(
          id: _requireListId(),
          name: _listName.text,
          applicationCount: _apps,
          categoryCount: _categories,
          webDomainCount: _websites,
          updatedAt: DateTime.now(),
        ).summary,
        note: _listNote,
        busy: _busy,
        onNameChanged: (_) => setState(() {}),
        onPick: _pickApps,
      ),
    };
  }

  List<Widget> _actions(_Step step) {
    return switch (step) {
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
          onPressed: _claimAndContinue,
        ),
      ],
      _Step.permission => [
        _PermissionActions(
          busy: _busy,
          onAllow: _allowScreenTime,
          onSkip: () => _run(_leavePermission),
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
    required this.showBack,
    required this.showSignOut,
    required this.busy,
    required this.onBack,
    required this.onSignOut,
  });

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
          if (showBack)
            TextButton(
              onPressed: busy ? null : onBack,
              style: style,
              child: Text(tr('common_back')),
            ),
          const Spacer(),
          if (showSignOut)
            TextButton(
              onPressed: busy ? null : onSignOut,
              style: style,
              child: Text(tr('home_sign_out')),
            ),
        ],
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
    final active = Theme.of(context).colorScheme.primary;
    return Semantics(
      label: tr('onboarding_step', args: ['${index + 1}', '$count']),
      child: Row(
        children: [
          for (var i = 0; i < count; i++) ...[
            if (i > 0) const SizedBox(width: 6),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 4,
              width: i == index ? 28 : 12,
              decoration: BoxDecoration(
                color: i <= index ? active : FoquiColors.raised,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AliasBody extends StatelessWidget {
  const _AliasBody({
    required this.alias,
    required this.canContinue,
    required this.onChanged,
    required this.onContinue,
  });

  final TextEditingController alias;
  final bool canContinue;
  final ValueChanged<String> onChanged;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(tr('onboarding_alias_title'), style: _title(theme)),
        const SizedBox(height: 10),
        Text(tr('onboarding_alias_body'), style: _body(theme)),
        const SizedBox(height: 28),
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
    required this.canContinue,
    required this.onChanged,
    required this.onContinue,
  });

  final TextEditingController username;
  final _HandleStatus? status;
  final bool canContinue;
  final ValueChanged<String> onChanged;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(tr('onboarding_username_title'), style: _title(theme)),
        const SizedBox(height: 10),
        Text(tr('onboarding_username_body'), style: _body(theme)),
        const SizedBox(height: 28),
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

class _PermissionBody extends ConsumerWidget {
  const _PermissionBody({required this.note});

  final String? note;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final status = ref.watch(authorizationProvider).asData?.value;
    final message =
        note ??
        (status == FamilyControlsAuthorization.unavailable
            ? tr('onboarding_permission_unavailable')
            : null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(tr('onboarding_permission_title'), style: _title(theme)),
        const SizedBox(height: 10),
        Text(tr('onboarding_permission_body'), style: _body(theme)),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(message, style: _body(theme)),
        ],
      ],
    );
  }
}

class _PermissionActions extends ConsumerWidget {
  const _PermissionActions({
    required this.busy,
    required this.onAllow,
    required this.onSkip,
  });

  final bool busy;
  final VoidCallback onAllow;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(authorizationProvider).asData?.value;
    final ready =
        status != null &&
        (status.isAuthorized ||
            status == FamilyControlsAuthorization.unavailable);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _PrimaryButton(
          label: ready
              ? tr('onboarding_continue')
              : tr('onboarding_permission_allow'),
          busy: busy,
          enabled: !busy,
          onPressed: onAllow,
        ),
        const SizedBox(height: 4),
        _SkipButton(
          label: tr('onboarding_permission_skip'),
          onPressed: busy ? null : onSkip,
        ),
      ],
    );
  }
}

class _BlockListBody extends StatelessWidget {
  const _BlockListBody({
    required this.name,
    required this.summary,
    required this.note,
    required this.busy,
    required this.onNameChanged,
    required this.onPick,
  });

  final TextEditingController name;
  final String summary;
  final String? note;
  final bool busy;
  final ValueChanged<String> onNameChanged;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(tr('onboarding_list_title'), style: _title(theme)),
        const SizedBox(height: 10),
        Text(tr('onboarding_list_body'), style: _body(theme)),
        const SizedBox(height: 28),
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
          borderRadius: BorderRadius.circular(14),
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
        if (note != null) ...[
          const SizedBox(height: 12),
          Text(note!, style: _body(theme)),
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
        FoquiColors.destructive,
      ),
      _HandleStatus.reserved => (
        tr('onboarding_username_reserved'),
        FoquiColors.destructive,
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
        FoquiColors.destructive,
      ),
      _HandleStatus.failed => (
        tr('onboarding_username_error'),
        FoquiColors.destructive,
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
  });

  final String label;
  final bool busy;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: enabled ? 1 : 0.45,
      child: FilledButton(
        onPressed: enabled ? onPressed : null,
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
    );
  }
}

class _SkipButton extends StatelessWidget {
  const _SkipButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        minimumSize: const Size.fromHeight(48),
      ),
      child: Text(label),
    );
  }
}

TextStyle? _title(ThemeData theme) {
  return theme.textTheme.headlineMedium?.copyWith(
    fontWeight: FontWeight.w800,
    letterSpacing: -0.8,
    height: 1.1,
  );
}

TextStyle? _body(ThemeData theme) {
  return theme.textTheme.bodyLarge?.copyWith(
    color: theme.colorScheme.onSurfaceVariant,
    height: 1.35,
  );
}
