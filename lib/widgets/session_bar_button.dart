import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/tr.dart';
import '../models/focus_session.dart';
import '../screens/screen_time_sheet.dart';
import '../screens/start_session_sheet.dart';
import '../services/focus_shield_bridge.dart';
import '../state/focus_controller.dart';
import 'floating_chrome.dart';
import 'floating_tab_bar.dart';

/// Session action that floats beside the tab bar on every screen.
///
/// The start control pulses until two sessions have each run for more than
/// a minute.
class SessionBarButton extends ConsumerStatefulWidget {
  const SessionBarButton({super.key});

  @override
  ConsumerState<SessionBarButton> createState() => _SessionBarButtonState();
}

class _SessionBarButtonState extends ConsumerState<SessionBarButton>
    with SingleTickerProviderStateMixin {
  var _busy = false;
  var _pulseOn = false;
  var _pulseSyncQueued = false;
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  bool _wantsPulse(FocusState state) {
    if (MediaQuery.disableAnimationsOf(context)) return false;
    if (state.foregroundSession != null) return false;
    return sessionsStartedLongerThanOneMinute(state.sessions, DateTime.now()) <
        2;
  }

  void _queuePulseSync() {
    if (_pulseSyncQueued) return;
    _pulseSyncQueued = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pulseSyncQueued = false;
      if (!mounted) return;
      _syncPulse(_wantsPulse(ref.read(focusControllerProvider)));
    });
  }

  void _syncPulse(bool on) {
    if (on != _pulseOn) setState(() => _pulseOn = on);
    if (on) {
      if (!_pulse.isAnimating) _pulse.repeat(reverse: true);
      return;
    }
    if (_pulse.isAnimating || _pulse.value != 0) {
      _pulse
        ..stop()
        ..value = 0;
    }
  }

  Future<void> _start() async {
    if (_busy) return;
    await beginFocusSession(
      context,
      ref,
      onCommit: () {
        if (mounted) setState(() => _busy = true);
      },
    );
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final state = ref.watch(focusControllerProvider);
    final nudge = _wantsPulse(state);
    if (nudge != _pulseOn) _queuePulseSync();
    if (state.foregroundSession != null) {
      return const SizedBox(
        width: kFloatingTabBarHeight,
        height: kFloatingTabBarHeight,
      );
    }

    final button = FloatingChrome(
      isDark: isDark,
      shape: const CircleBorder(),
      color: scheme.primary,
      shadowAlpha: 0.18,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: _busy ? null : _start,
        child: SizedBox(
          width: kFloatingTabBarHeight,
          height: kFloatingTabBarHeight,
          child: Center(
            child: _busy
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: scheme.onPrimary,
                    ),
                  )
                : Transform.translate(
                    // The play triangle's weight sits left of its bounds.
                    offset: const Offset(2, 0),
                    child: Icon(
                      CupertinoIcons.play_fill,
                      size: 24,
                      color: scheme.onPrimary,
                    ),
                  ),
          ),
        ),
      ),
    );

    return Tooltip(
      message: tr('session_start_focus'),
      child: _pulseOn
          ? _StartButtonPulse(
              animation: _pulse,
              color: scheme.primary,
              child: button,
            )
          : button,
    );
  }
}

/// Screen Time has to be allowed before a session can be set up.
/// Unavailable covers the simulator, which still opens the session sheet.
Future<bool> _screenTimeReady(BuildContext context, WidgetRef ref) async {
  var status = FamilyControlsAuthorization.unknown;
  try {
    status = await ref.read(authorizationProvider.future);
  } catch (_) {
    status = FamilyControlsAuthorization.unknown;
  }
  if (!context.mounted) return false;
  if (status.isAuthorized ||
      status == FamilyControlsAuthorization.unavailable) {
    return true;
  }
  return showScreenTimeSheet(context);
}

/// Opens the session sheet, then starts or creates what was chosen.
///
/// [onCommit] runs once a choice is confirmed, before the session is saved,
/// so a button can show that the request is in flight.
Future<void> beginFocusSession(
  BuildContext context,
  WidgetRef ref, {
  VoidCallback? onCommit,
}) async {
  if (!await _screenTimeReady(context, ref)) return;
  if (!context.mounted) return;
  final choice = await showStartSessionSheet(context);
  if (choice == null || !context.mounted) return;
  onCommit?.call();
  try {
    final controller = ref.read(focusControllerProvider.notifier);
    if (choice.action == SessionSheetAction.create) {
      await controller.createSession(
        listId: choice.listId,
        minutes: choice.minutes,
        label: choice.label,
      );
    } else {
      await controller.startSession(
        listId: choice.listId,
        minutes: choice.minutes,
        label: choice.label,
      );
    }
    HapticFeedback.mediumImpact();
  } on FocusShieldException catch (error, stack) {
    debugPrint('Could not start the session: $error\n$stack');
    if (!context.mounted) return;
    if (error.code == 'NOT_AUTHORIZED') {
      await showScreenTimeSheet(context);
    }
  }
}

class _StartButtonPulse extends StatelessWidget {
  const _StartButtonPulse({
    required this.animation,
    required this.color,
    required this.child,
  });

  final Animation<double> animation;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final t = Curves.easeInOut.transform(animation.value);
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            IgnorePointer(
              child: Transform.scale(
                scale: 1 + (0.16 * t),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withValues(alpha: 0.16 * (1 - t)),
                  ),
                  child: const SizedBox(
                    width: kFloatingTabBarHeight,
                    height: kFloatingTabBarHeight,
                  ),
                ),
              ),
            ),
            Transform.scale(scale: 1 + (0.025 * t), child: child),
          ],
        );
      },
      child: child,
    );
  }
}
