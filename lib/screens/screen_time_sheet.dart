import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/tr.dart';
import '../services/focus_shield_bridge.dart';
import '../state/focus_controller.dart';
import '../widgets/sheet_header.dart';

/// Explains why Foqui needs Screen Time. Returns true once access is allowed.
Future<bool> showScreenTimeSheet(BuildContext context) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (context) => const ScreenTimeSheet(),
  ).then((allowed) => allowed ?? false);
}

class ScreenTimeSheet extends ConsumerStatefulWidget {
  const ScreenTimeSheet({super.key});

  @override
  ConsumerState<ScreenTimeSheet> createState() => _ScreenTimeSheetState();
}

class _ScreenTimeSheetState extends ConsumerState<ScreenTimeSheet>
    with WidgetsBindingObserver {
  var _busy = false;
  var _closed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed || !mounted) return;
    ref.read(authorizationProvider.notifier).refresh();
  }

  void _finish() {
    if (_closed || !mounted) return;
    _closed = true;
    Navigator.of(context).pop(true);
  }

  Future<void> _allow(bool openSettings) async {
    if (_busy) return;
    if (openSettings) {
      await ref.read(focusShieldBridgeProvider).openSystemSettings();
      return;
    }
    setState(() => _busy = true);
    try {
      final status = await ref.read(authorizationProvider.notifier).request();
      if (status.isAuthorized) _finish();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final status =
        ref.watch(authorizationProvider).asData?.value ??
        FamilyControlsAuthorization.notDetermined;
    final copy = _copyFor(status, android: blocksWithAccessibility);

    ref.listen(authorizationProvider, (previous, next) {
      if (next.asData?.value.isAuthorized ?? false) _finish();
    });

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.92,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            const SheetGrabber(),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                18,
                20,
                kSheetBottomPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    copy.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    copy.body,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _Point(
                    blocksWithAccessibility
                        ? 'android_point_list'
                        : 'screen_time_point_list',
                  ),
                  const SizedBox(height: 12),
                  _Point(
                    blocksWithAccessibility
                        ? 'android_point_timer'
                        : 'screen_time_point_timer',
                  ),
                  const SizedBox(height: 12),
                  _Point(
                    blocksWithAccessibility
                        ? 'android_point_scope'
                        : 'screen_time_point_scope',
                  ),
                  const SizedBox(height: 22),
                  FilledButton(
                    onPressed: _busy ? null : () => _allow(copy.openSettings),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: _busy
                        ? SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: scheme.onPrimary,
                            ),
                          )
                        : Text(copy.action),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScreenTimeCopy {
  const _ScreenTimeCopy({
    required this.title,
    required this.body,
    required this.action,
    required this.openSettings,
  });

  final String title;
  final String body;
  final String action;
  final bool openSettings;
}

_ScreenTimeCopy _copyFor(
  FamilyControlsAuthorization status, {
  required bool android,
}) {
  return switch (status) {
    FamilyControlsAuthorization.denied => _ScreenTimeCopy(
      title: tr(
        android
            ? 'android_sheet_denied_title'
            : 'screen_time_sheet_denied_title',
      ),
      body: tr(
        android ? 'android_sheet_denied_body' : 'screen_time_sheet_denied_body',
      ),
      action: tr('home_open_settings'),
      openSettings: true,
    ),
    FamilyControlsAuthorization.unknown => _ScreenTimeCopy(
      title: tr(
        android ? 'android_sheet_title' : 'screen_time_sheet_unknown_title',
      ),
      body: tr(
        android ? 'android_sheet_body' : 'screen_time_sheet_unknown_body',
      ),
      action: tr('screen_time_try_again'),
      openSettings: false,
    ),
    _ => _ScreenTimeCopy(
      title: tr(android ? 'android_sheet_title' : 'screen_time_sheet_title'),
      body: tr(android ? 'android_sheet_body' : 'screen_time_sheet_body'),
      action: tr(android ? 'android_home_allow' : 'home_allow_screen_time'),
      openSettings: false,
    ),
  };
}

class _Point extends StatelessWidget {
  const _Point(this.labelKey);

  final String labelKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(
            CupertinoIcons.checkmark,
            size: 16,
            color: scheme.primary,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            tr(labelKey),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurface,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
