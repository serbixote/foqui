import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/tr.dart';
import '../models/block_list.dart';
import '../models/focus_label.dart';
import '../models/focus_session.dart';
import '../services/focus_shield_bridge.dart';
import '../state/auth.dart';
import '../state/focus_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/floating_tab_bar.dart';
import '../widgets/screen_header.dart';
import '../widgets/session_bar_button.dart';
import '../widgets/sheet_header.dart';
import '../widgets/surface_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
  static const _pageSize = 10;

  var _shown = _pageSize;
  var _starting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      finishSessionIfDue(ref);
    });
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
    finishSessionIfDue(ref);
  }

  Future<void> _confirmSignOut() async {
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => const _SignOutSheet(),
    );
    if (confirmed != true || !mounted) return;
    try {
      final open = ref.read(focusControllerProvider).foregroundSession;
      if (open != null && open.outcome != SessionOutcome.created) {
        await ref.read(focusControllerProvider.notifier).endSession();
      }
    } catch (error, stack) {
      debugPrint('Could not end the session before sign-out: $error\n$stack');
    }
    if (!mounted) return;
    await ref.read(authProvider.notifier).signOut();
  }

  Future<void> _startSession() async {
    if (_starting) return;
    await beginFocusSession(
      context,
      ref,
      onCommit: () {
        if (mounted) setState(() => _starting = true);
      },
    );
    if (mounted) setState(() => _starting = false);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(focusControllerProvider);
    final authorization = ref.watch(authorizationProvider);
    final past = [
      for (final session in state.sessions.reversed)
        if (session.outcome != SessionOutcome.active &&
            session.outcome != SessionOutcome.paused &&
            session.outcome != SessionOutcome.created)
          session,
    ];
    final shown = past.take(_shown);
    final hasMore = past.length > _shown;

    final chrome = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ScreenHeader(
          title: 'Foqui',
          subtitle: tr('home_subtitle'),
          leading: Image.asset(
            'assets/images/foqui.png',
            height: 36,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
            excludeFromSemantics: true,
          ),
          trailing: IconButton(
            tooltip: tr('home_sign_out'),
            constraints: const BoxConstraints.tightFor(width: 36, height: 36),
            padding: EdgeInsets.zero,
            onPressed: _confirmSignOut,
            icon: const Icon(CupertinoIcons.square_arrow_right, size: 22),
          ),
        ),
        authorization.when(
          data: (status) => status.isAuthorized
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: _PermissionBanner(status: status),
                ),
          loading: () => const SizedBox.shrink(),
          error: (_, _) => const Padding(
            padding: EdgeInsets.only(top: 20),
            child: _PermissionBanner(
              status: FamilyControlsAuthorization.unknown,
            ),
          ),
        ),
      ],
    );

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Expanded(
            child: past.isEmpty
                ? CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                        sliver: SliverToBoxAdapter(child: chrome),
                      ),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: kEmptyContentPadding,
                          child: Align(
                            alignment: kEmptyContentAlignment,
                            child: _HomeEmpty(
                              busy: _starting,
                              onStart: _startSession,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView(
                    padding: EdgeInsets.fromLTRB(
                      20,
                      16,
                      20,
                      hasMore ? 12 : kFloatingContentInset,
                    ),
                    children: [
                      chrome,
                      const SizedBox(height: 16),
                      _SectionHeader(title: tr('home_recent')),
                      const SizedBox(height: 10),
                      SurfaceGroup(
                        children: [
                          for (final session in shown)
                            _HistoryTile(
                              session: session,
                              labels: state.labels,
                            ),
                        ],
                      ),
                    ],
                  ),
          ),
          if (hasMore)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                0,
                20,
                kFloatingBarBottomGap + kFloatingTabBarHeight + 12,
              ),
              child: TextButton(
                onPressed: () => setState(() => _shown += _pageSize),
                child: Text(tr('home_load_more')),
              ),
            ),
        ],
      ),
    );
  }
}

class _SignOutSheet extends StatelessWidget {
  const _SignOutSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        const SheetGrabber(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, kSheetBottomPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                tr('home_sign_out'),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                tr('home_sign_out_body'),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => Navigator.pop(context, false),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
                child: Text(tr('home_sign_out_stay')),
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(
                  foregroundColor: FoquiColors.destructive,
                  minimumSize: const Size.fromHeight(48),
                ),
                child: Text(tr('home_sign_out')),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<void> finishSessionIfDue(WidgetRef ref) {
  return ref.read(focusControllerProvider.notifier).completeIfDue();
}

/// Home placeholder when nothing has finished yet.
class _HomeEmpty extends StatelessWidget {
  const _HomeEmpty({required this.busy, required this.onStart});

  final bool busy;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          // The artwork's clear space is wider on the right, so the
          // character sits left of the box. Nudge it onto the column's axis.
          offset: const Offset(7, 0),
          child: Image.asset(
            'assets/images/foqui.png',
            height: 120,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
            excludeFromSemantics: true,
          ),
        ),
        Transform.translate(
          // Pull the copy into the artwork's empty lower margin.
          offset: const Offset(0, -6),
          child: Column(
            children: [
              Text(
                tr('home_empty_title'),
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 260),
                child: Text(
                  tr('home_empty_body'),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              FilledButton(
                onPressed: busy ? null : onStart,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(0, 52),
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: busy ? 0 : 1,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(CupertinoIcons.play_fill, size: 16),
                          const SizedBox(width: 8),
                          Text(tr('home_empty_start')),
                        ],
                      ),
                    ),
                    if (busy)
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          color: scheme.onPrimary,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _PermissionBanner extends ConsumerWidget {
  const _PermissionBanner({required this.status});

  final FamilyControlsAuthorization status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final unavailable = status == FamilyControlsAuthorization.unavailable;
    final denied = status == FamilyControlsAuthorization.denied;
    final (lead, detail) = switch (status) {
      FamilyControlsAuthorization.unavailable => (
        tr('home_screen_time_simulator_lead'),
        tr('home_screen_time_simulator'),
      ),
      FamilyControlsAuthorization.denied => (
        tr('home_screen_time_denied_lead'),
        tr('home_screen_time_denied'),
      ),
      FamilyControlsAuthorization.unknown => (
        tr('home_screen_time_unknown_lead'),
        tr('home_screen_time_unknown'),
      ),
      _ => (tr('home_screen_time_needed_lead'), tr('home_screen_time_needed')),
    };
    final action = denied
        ? tr('home_open_settings')
        : status == FamilyControlsAuthorization.unknown
        ? tr('screen_time_try_again')
        : tr('home_allow_screen_time');

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SurfaceCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: FoquiColors.destructive.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    CupertinoIcons.lock_fill,
                    size: 16,
                    color: FoquiColors.destructive,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    tr('home_screen_time'),
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text.rich(
              TextSpan(
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.35),
                children: [
                  TextSpan(
                    text: lead,
                    style: TextStyle(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: ' $detail',
                    style: TextStyle(color: scheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            if (!unavailable) ...[
              const SizedBox(height: 14),
              FilledButton(
                onPressed: () async {
                  if (denied) {
                    await ref
                        .read(focusShieldBridgeProvider)
                        .openSystemSettings();
                    return;
                  }
                  await ref.read(authorizationProvider.notifier).request();
                },
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                child: Text(action),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Title and icon a past session should show.
///
/// A label that still exists wins, so an edit shows up here. A label that was
/// removed leaves Focus Time in its place.
String? _labelTitle(FocusSession session, List<FocusLabel> labels) {
  if (!session.hasLabel) return null;
  final current = _labelNow(session, labels) ?? _focusTimeLabel(labels);
  final emoji = current.emoji;
  final name = localizedLabelName(id: current.id, name: current.name);
  if (emoji.isEmpty) return name;
  return '$emoji $name';
}

FocusLabel? _labelNow(FocusSession session, List<FocusLabel> labels) {
  final id = session.labelId;
  if (id == null) return null;
  for (final label in labels) {
    if (label.id == id) return label;
  }
  return null;
}

FocusLabel _focusTimeLabel(List<FocusLabel> labels) {
  for (final label in labels) {
    if (label.id == focusTimeLabelId) return label;
  }
  return kBuiltInFocusLabels.first;
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.session, required this.labels});

  final FocusSession session;
  final List<FocusLabel> labels;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final length = sessionLengthLabel(session);
    final label = _labelTitle(session, labels);
    final stamp = formatSessionStamp(session.startedAt, DateTime.now());
    final detail = [
      if (label != null)
        blockListTitle(id: session.blockListId, name: session.blockListName),
      length,
      stamp,
      session.outcomeLabel,
    ].join(' · ');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ??
                blockListTitle(
                  id: session.blockListId,
                  name: session.blockListName,
                ),
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            detail,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
