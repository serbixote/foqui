import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/tr.dart';
import '../models/focus_label.dart';
import '../models/focus_session.dart';
import '../screens/end_session_sheet.dart';
import '../screens/screen_time_sheet.dart';
import '../services/focus_shield_bridge.dart';
import '../state/focus_controller.dart';
import '../theme/app_theme.dart';
import 'sheet_header.dart';

const _liveGreen = Color(0xFF30D158);

/// People in the session. Shared sessions will replace this list.
List<String> get _sessionMembers => [tr('session_you')];

/// Session sheet over the app.
///
/// The shell keeps this over every screen while a session is on screen, and
/// the sheet uses the height under the status bar. A session that has not
/// been started yet uses the same sheet with the clock held. Starting it is
/// what makes the timer run.
class SessionLiveActivity extends ConsumerStatefulWidget {
  const SessionLiveActivity({super.key});

  @override
  ConsumerState<SessionLiveActivity> createState() =>
      _SessionLiveActivityState();
}

class _SessionLiveActivityState extends ConsumerState<SessionLiveActivity>
    with TickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );
  late final AnimationController _slide = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );
  Timer? _ticker;
  var _live = false;
  var _waiting = false;
  var _paused = false;
  var _open = false;
  var _busy = false;
  var _pausing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _sync(ref.read(focusControllerProvider).foregroundSession);
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _pulse.dispose();
    _slide.dispose();
    super.dispose();
  }

  void _sync(FocusSession? session) {
    final live = session != null;
    final waiting = session?.outcome == SessionOutcome.created;
    final paused = session?.outcome == SessionOutcome.paused;
    final open =
        session?.outcome == SessionOutcome.active && session?.endsAt == null;
    if (live == _live &&
        waiting == _waiting &&
        paused == _paused &&
        open == _open) {
      return;
    }
    _live = live;
    _waiting = waiting;
    _paused = paused;
    _open = open;

    if (live && !waiting && !paused) {
      if (!_pulse.isAnimating) _pulse.repeat(reverse: true);
      _ticker ??= Timer.periodic(const Duration(seconds: 1), (_) {
        unawaited(_tick());
      });
    } else {
      _pulse
        ..stop()
        ..value = 0;
      _ticker?.cancel();
      _ticker = null;
    }

    if (open) {
      if (!_slide.isAnimating) _slide.repeat();
    } else {
      _slide
        ..stop()
        ..value = 0;
    }
  }

  Future<void> _tick() async {
    if (!mounted) return;
    final session = ref.read(focusControllerProvider).activeSession;
    final endsAt = session?.endsAt;
    if (session != null && endsAt != null && !endsAt.isAfter(DateTime.now())) {
      await ref.read(focusControllerProvider.notifier).completeIfDue();
      return;
    }
    setState(() {});
  }

  Future<void> _begin(FocusSession session) async {
    setState(() => _busy = true);
    try {
      await ref
          .read(focusControllerProvider.notifier)
          .startSession(sessionId: session.id);
      HapticFeedback.mediumImpact();
    } on FocusShieldException catch (error, stack) {
      debugPrint('Could not start the session: $error\n$stack');
      if (!mounted) return;
      if (error.code == 'NOT_AUTHORIZED') {
        await showScreenTimeSheet(context);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _cancel(FocusSession session) async {
    setState(() => _busy = true);
    try {
      await ref
          .read(focusControllerProvider.notifier)
          .discardSession(session.id);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _pause(FocusSession session) async {
    setState(() {
      _busy = true;
      _pausing = true;
    });
    try {
      final controller = ref.read(focusControllerProvider.notifier);
      if (session.outcome == SessionOutcome.paused) {
        await controller.resumeSession();
      } else {
        await controller.pauseSession();
      }
      HapticFeedback.mediumImpact();
    } on FocusShieldException catch (error, stack) {
      debugPrint('Could not resume the session: $error\n$stack');
      if (!mounted) return;
      if (error.code == 'NOT_AUTHORIZED') {
        await showScreenTimeSheet(context);
      }
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
          _pausing = false;
        });
      }
    }
  }

  Future<void> _end() async {
    final confirmed = await showEndSessionSheet(context);
    if (!confirmed || !mounted) return;
    setState(() => _busy = true);
    try {
      await ref.read(focusControllerProvider.notifier).endSession();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final focus = ref.watch(focusControllerProvider);
    final session = focus.foregroundSession;
    final labels = focus.labels;
    final waiting = session?.outcome == SessionOutcome.created;
    ref.listen(focusControllerProvider, (previous, next) {
      _sync(next.foregroundSession);
    });

    if (session == null) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final shownAt = _shownAt(session, now);
    final paused = session.outcome == SessionOutcome.paused;
    final progress = _progress(session, shownAt);
    final running = !waiting && !paused;

    return Semantics(
      container: true,
      label: tr(
        'session_semantics',
        args: [
          _labelName(session, labels),
          session.outcomeLabel,
          session.blockListName,
        ],
      ),
      child: Material(
        color: scheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          side: BorderSide(color: FoquiColors.hairline),
        ),
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              const SheetGrabber(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _BlockingCard(name: session.blockListName),
                    const SizedBox(height: 22),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: _ElapsedClock(
                              elapsed: _elapsed(session, shownAt),
                              total: _total(session),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        _StatusLine(
                          label: session.outcomeLabel,
                          live: running,
                          pulse: _pulse,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _LiveProgressBar(
                      value: progress,
                      slide: _slide,
                      color: FoquiColors.violet,
                      track: const Color(0xFF4A4A4E),
                    ),
                    const SizedBox(height: 22),
                    _SessionHeading(
                      labels: labels,
                      selected: _selectedLabel(session, labels),
                      onSelected: (index) {
                        if (index < 0 || index >= labels.length) return;
                        unawaited(
                          ref
                              .read(focusControllerProvider.notifier)
                              .setSessionLabel(
                                sessionId: session.id,
                                label: labels[index],
                              ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
                  children: [_MemberList(names: _sessionMembers)],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                child: waiting
                    ? _WaitingActions(
                        busy: _busy,
                        onStart: () => _begin(session),
                        onCancel: () => _cancel(session),
                      )
                    : _RunningActions(
                        busy: _busy,
                        pausing: _pausing,
                        paused: paused,
                        onPause: () => _pause(session),
                        onStop: _end,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime _shownAt(FocusSession session, DateTime now) {
    if (session.outcome == SessionOutcome.paused) {
      return session.pausedAt ?? now;
    }
    return now;
  }

  double? _progress(FocusSession? session, DateTime now) {
    if (session == null) return 0;
    if (session.outcome == SessionOutcome.created) return 0;
    final endsAt = session.endsAt;
    if (endsAt == null) return null;
    final total = endsAt.difference(session.startedAt).inMilliseconds;
    if (total <= 0) return 1;
    final elapsed = now.difference(session.startedAt).inMilliseconds;
    return (elapsed / total).clamp(0.0, 1.0);
  }

  /// Time already spent. A session that has not started yet stays at zero.
  String _elapsed(FocusSession session, DateTime now) {
    if (session.outcome == SessionOutcome.created) {
      return formatRemaining(Duration.zero);
    }
    final span = now.difference(session.startedAt);
    return formatRemaining(span.isNegative ? Duration.zero : span);
  }

  /// Length chosen for the session, as a clock. Null when none was set.
  String? _total(FocusSession session) {
    final endsAt = session.endsAt;
    if (endsAt == null) return null;
    final span = endsAt.difference(session.startedAt);
    if (!span.isNegative && span > Duration.zero) {
      return formatRemaining(span);
    }
    return null;
  }
}

String _labelName(FocusSession session, List<FocusLabel> labels) {
  final index = _selectedLabel(session, labels);
  if (labels.isEmpty) {
    return localizedLabelName(id: session.labelId, name: session.labelName);
  }
  final label = labels[index];
  return localizedLabelName(id: label.id, name: label.name);
}

class _RunningActions extends StatelessWidget {
  const _RunningActions({
    required this.busy,
    required this.pausing,
    required this.paused,
    required this.onPause,
    required this.onStop,
  });

  final bool busy;
  final bool pausing;
  final bool paused;
  final VoidCallback onPause;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Tooltip(
            message: paused
                ? tr('session_resume_action')
                : tr('session_pause_action'),
            child: FilledButton.icon(
              onPressed: busy ? null : onPause,
              style: FilledButton.styleFrom(
                backgroundColor: FoquiColors.raised,
                foregroundColor: scheme.onSurface,
                disabledBackgroundColor: FoquiColors.raised,
                disabledForegroundColor: scheme.onSurface.withValues(
                  alpha: 0.4,
                ),
                minimumSize: const Size.fromHeight(52),
              ),
              icon: pausing
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.2,
                        color: scheme.onSurface,
                      ),
                    )
                  : Icon(
                      paused ? CupertinoIcons.play_fill : CupertinoIcons.pause,
                      size: 16,
                    ),
              label: Text(paused ? tr('session_resume') : tr('session_pause')),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Tooltip(
            message: tr('end_confirm'),
            child: FilledButton.icon(
              onPressed: busy ? null : onStop,
              style: FilledButton.styleFrom(
                backgroundColor: FoquiColors.destructive,
                foregroundColor: Colors.white,
                disabledBackgroundColor: FoquiColors.destructive.withValues(
                  alpha: 0.4,
                ),
                disabledForegroundColor: Colors.white,
                minimumSize: const Size.fromHeight(52),
              ),
              icon: busy && !pausing
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(CupertinoIcons.stop_fill, size: 16),
              label: Text(tr('session_stop')),
            ),
          ),
        ),
      ],
    );
  }
}

class _WaitingActions extends StatelessWidget {
  const _WaitingActions({
    required this.busy,
    required this.onStart,
    required this.onCancel,
  });

  final bool busy;
  final VoidCallback onStart;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton.icon(
          onPressed: busy ? null : onStart,
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
          icon: busy
              ? SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: onPrimary,
                  ),
                )
              : const Icon(CupertinoIcons.play_fill, size: 16),
          label: Text(tr('sign_in_start')),
        ),
        const SizedBox(height: 4),
        TextButton(
          onPressed: busy ? null : onCancel,
          child: Text(tr('common_cancel')),
        ),
      ],
    );
  }
}

int _selectedLabel(FocusSession session, List<FocusLabel> labels) {
  if (labels.isEmpty) return 0;
  final id = session.labelId;
  if (id == null) return 0;
  final index = labels.indexWhere((label) => label.id == id);
  return index < 0 ? 0 : index;
}

const _labelPadLeft = 12.0;
const _emojiSlot = 32.0;
const _emojiGap = 10.0;

/// Label and the menu for changing it.
class _SessionHeading extends StatefulWidget {
  const _SessionHeading({
    required this.labels,
    required this.selected,
    required this.onSelected,
  });

  final List<FocusLabel> labels;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  State<_SessionHeading> createState() => _SessionHeadingState();
}

class _SessionHeadingState extends State<_SessionHeading> {
  var _open = false;
  int? _pending;
  Timer? _commit;

  @override
  void dispose() {
    _commit?.cancel();
    super.dispose();
  }

  void _toggle() {
    HapticFeedback.selectionClick();
    setState(() => _open = !_open);
  }

  void _choose(int index) {
    HapticFeedback.selectionClick();
    if (index == widget.selected && _pending == null) {
      setState(() => _open = false);
      return;
    }
    setState(() => _pending = index);
    _commit?.cancel();
    _commit = Timer(const Duration(milliseconds: 320), () {
      if (!mounted) return;
      widget.onSelected(index);
      setState(() {
        _pending = null;
        _open = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final labels = widget.labels;
    if (labels.isEmpty) return const SizedBox.shrink();
    final selected = widget.selected.clamp(0, labels.length - 1).toInt();
    final label = labels[selected];
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Tooltip(
          message: tr('session_choose_label'),
          child: Material(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: _toggle,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(_labelPadLeft, 8, 14, 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: _emojiSlot,
                      height: _emojiSlot,
                      child: Center(
                        child: Text(
                          label.emoji,
                          style: const TextStyle(fontSize: 24, height: 1),
                        ),
                      ),
                    ),
                    const SizedBox(width: _emojiGap),
                    Expanded(
                      child: Text(
                        localizedLabelName(id: label.id, name: label.name),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                          height: 1.1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      _open
                          ? CupertinoIcons.chevron_up
                          : CupertinoIcons.chevron_down,
                      size: 16,
                      color: scheme.onSurface,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: _open
              ? Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: _LabelMenu(
                    labels: labels,
                    selected: _pending ?? selected,
                    onChoose: _choose,
                  ),
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }
}

class _StatusLine extends StatelessWidget {
  const _StatusLine({
    required this.label,
    required this.live,
    required this.pulse,
  });

  final String label;
  final bool live;
  final Animation<double> pulse;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _LiveDot(
          pulse: pulse,
          color: live ? _liveGreen : FoquiColors.secondaryLabel,
          animate: live,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
            height: 1.1,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class _LabelMenu extends StatelessWidget {
  const _LabelMenu({
    required this.labels,
    required this.selected,
    required this.onChoose,
  });

  final List<FocusLabel> labels;
  final int selected;
  final ValueChanged<int> onChoose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nameStyle = theme.textTheme.titleSmall?.copyWith(
      fontWeight: FontWeight.w600,
    );
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 240),
      child: Material(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        clipBehavior: Clip.antiAlias,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < labels.length; i++)
                InkWell(
                  onTap: () => onChoose(i),
                  child: ColoredBox(
                    color: i == selected
                        ? theme.colorScheme.primary.withValues(alpha: 0.16)
                        : Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        _labelPadLeft,
                        12,
                        14,
                        12,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: _emojiSlot,
                            child: Text(
                              labels[i].emoji,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20, height: 1),
                            ),
                          ),
                          const SizedBox(width: _emojiGap),
                          Expanded(
                            child: Text(
                              localizedLabelName(
                                id: labels[i].id,
                                name: labels[i].name,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: nameStyle,
                            ),
                          ),
                          if (i == selected)
                            Icon(
                              CupertinoIcons.checkmark,
                              size: 16,
                              color: theme.colorScheme.primary,
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

class _ElapsedClock extends StatelessWidget {
  const _ElapsedClock({required this.elapsed, required this.total});

  final String elapsed;
  final String? total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const figures = [FontFeature.tabularFigures()];
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          elapsed,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: 34,
            fontWeight: FontWeight.w700,
            letterSpacing: -1,
            height: 1,
            fontFeatures: figures,
            color: theme.colorScheme.onSurface,
          ),
        ),
        if (total != null)
          Text(
            ' / $total',
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.3,
              height: 1,
              fontFeatures: figures,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
      ],
    );
  }
}

/// Foqui, cropped in so the character fills the blocking card.
class _FoquiMark extends StatelessWidget {
  const _FoquiMark();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 56,
      height: 52,
      child: ClipRect(
        child: OverflowBox(
          maxWidth: 96,
          maxHeight: 88,
          alignment: Alignment(-0.22, 0.12),
          child: Image(
            image: AssetImage('assets/images/foqui.png'),
            width: 96,
            height: 88,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
            excludeFromSemantics: true,
          ),
        ),
      ),
    );
  }
}

class _BlockingCard extends StatelessWidget {
  const _BlockingCard({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: FoquiColors.separator),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const _FoquiMark(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                width: 1,
                height: 40,
                child: ColoredBox(color: FoquiColors.separator),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('session_blocking'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: scheme.onSurfaceVariant,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: scheme.primary.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Icon(
                          CupertinoIcons.lock_fill,
                          size: 13,
                          color: scheme.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                    ],
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

/// Present so a session can be shared later. Tapping it does nothing yet.
class _ShareButton extends StatelessWidget {
  const _ShareButton();

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tr('session_share'),
      child: TextButton.icon(
        onPressed: () {},
        style: TextButton.styleFrom(
          visualDensity: VisualDensity.compact,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          minimumSize: const Size(0, 36),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        icon: const Icon(CupertinoIcons.square_arrow_up, size: 18),
        label: Text(tr('session_share')),
      ),
    );
  }
}

class _MemberList extends StatelessWidget {
  const _MemberList({required this.names});

  final List<String> names;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nameStyle = theme.textTheme.labelMedium?.copyWith(
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      height: 1.3,
      color: theme.colorScheme.onSurface,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                tr('session_members', args: ['${names.length}']),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.1,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const _ShareButton(),
          ],
        ),
        const SizedBox(height: 10),
        for (var i = 0; i < names.length; i++) ...[
          if (i > 0) const SizedBox(height: 8),
          _MemberRow(name: names[i], nameStyle: nameStyle),
        ],
      ],
    );
  }
}

class _MemberRow extends StatelessWidget {
  const _MemberRow({required this.name, required this.nameStyle});

  final String name;
  final TextStyle? nameStyle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.22),
            shape: BoxShape.circle,
          ),
          child: Icon(
            CupertinoIcons.person_fill,
            size: 16,
            color: scheme.primary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: nameStyle,
          ),
        ),
      ],
    );
  }
}

class _LiveDot extends StatelessWidget {
  const _LiveDot({
    required this.pulse,
    required this.color,
    required this.animate,
  });

  final Animation<double> pulse;
  final Color color;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final dot = Container(
      key: const Key('session-status-dot'),
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
    if (!animate) {
      return SizedBox(width: 16, height: 16, child: Center(child: dot));
    }
    return AnimatedBuilder(
      animation: pulse,
      builder: (context, child) {
        final t = Curves.easeInOut.transform(pulse.value);
        return SizedBox(
          width: 16,
          height: 16,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 8 + (8 * t),
                height: 8 + (8 * t),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.28 * (1 - t)),
                  shape: BoxShape.circle,
                ),
              ),
              child!,
            ],
          ),
        );
      },
      child: dot,
    );
  }
}

class _LiveProgressBar extends StatelessWidget {
  const _LiveProgressBar({
    required this.value,
    required this.slide,
    required this.color,
    required this.track,
  });

  /// Null draws a moving segment for sessions with no end time.
  final double? value;
  final Animation<double> slide;
  final Color color;
  final Color track;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(99),
      child: SizedBox(
        height: 6,
        child: value == null
            ? AnimatedBuilder(
                animation: slide,
                builder: (context, _) => _Track(
                  value: null,
                  slide: slide.value,
                  color: color,
                  track: track,
                ),
              )
            : TweenAnimationBuilder<double>(
                tween: Tween<double>(end: value!.clamp(0, 1).toDouble()),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                builder: (context, animated, _) => _Track(
                  value: animated,
                  slide: 0,
                  color: color,
                  track: track,
                ),
              ),
      ),
    );
  }
}

class _Track extends StatelessWidget {
  const _Track({
    required this.value,
    required this.slide,
    required this.color,
    required this.track,
  });

  final double? value;
  final double slide;
  final Color color;
  final Color track;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final fill = (width * (value ?? 0)).clamp(0.0, width).toDouble();
        return Stack(
          children: [
            Positioned.fill(child: ColoredBox(color: track)),
            if (value != null)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: fill,
                child: ColoredBox(color: color),
              )
            else
              _SlidingSegment(width: width, slide: slide, color: color),
          ],
        );
      },
    );
  }
}

class _SlidingSegment extends StatelessWidget {
  const _SlidingSegment({
    required this.width,
    required this.slide,
    required this.color,
  });

  final double width;
  final double slide;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final segment = width * 0.34;
    final dx = (width + segment) * slide - segment;
    return Stack(
      children: [
        Positioned(
          left: dx,
          width: segment,
          top: 0,
          bottom: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0),
                  color,
                  color.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
