import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/tr.dart';
import '../models/block_list.dart';
import '../models/focus_label.dart';
import '../models/focus_stats.dart';
import '../state/focus_controller.dart';
import '../widgets/empty_state.dart';
import '../widgets/floating_tab_bar.dart';
import '../widgets/screen_header.dart';
import '../widgets/surface_card.dart';

class StatsScreen extends ConsumerStatefulWidget {
  const StatsScreen({super.key});

  @override
  ConsumerState<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends ConsumerState<StatsScreen> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!mounted) return;
      if (ref.read(focusControllerProvider).activeSession == null) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focus = ref.watch(focusControllerProvider);
    final sessions = focus.sessions;
    final stats = summarizeFocus(
      sessions,
      DateTime.now(),
      labels: focus.labels,
    );

    final header = ScreenHeader(
      title: tr('stats_title'),
      subtitle: tr('stats_subtitle'),
    );

    if (stats.sessionCount == 0) {
      return SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              sliver: SliverToBoxAdapter(child: header),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: kEmptyContentPadding,
                child: Align(
                  alignment: kEmptyContentAlignment,
                  child: EmptyState(
                    icon: CupertinoIcons.chart_bar,
                    message: tr('stats_empty'),
                    messageInset: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, kFloatingContentInset),
        children: [
          header,
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  label: tr('stats_today'),
                  value: formatFocusTotal(stats.today),
                  caption: stats.todaySessions == 0
                      ? tr('stats_nothing_yet')
                      : _sessionsLabel(stats.todaySessions),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  label: tr('stats_this_week'),
                  value: formatFocusTotal(
                    stats.week.fold(
                      Duration.zero,
                      (total, day) => total + day.focused,
                    ),
                  ),
                  caption: _weekCaption(stats),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  label: tr('stats_streak'),
                  value: _daysLabel(stats.streakDays),
                  caption: stats.streakDays == 0
                      ? tr('stats_no_streak')
                      : stats.streakIncludesToday
                      ? tr('stats_streak_today')
                      : tr('stats_streak_yesterday'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  label: tr('stats_stayed'),
                  value: _stayedValue(stats),
                  caption: _stayedCaption(stats),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SectionHeader(title: tr('stats_last_7_days')),
          const SizedBox(height: 10),
          _WeekChart(days: stats.week),
          if (stats.byLabel.isNotEmpty) ...[
            const SizedBox(height: 16),
            _SectionHeader(title: tr('stats_by_label')),
            const SizedBox(height: 10),
            SurfaceGroup(
              children: [
                for (final label in stats.byLabel)
                  _ShareTile(
                    emoji: label.emoji,
                    title: localizedLabelName(id: label.id, name: label.name),
                    detail: _sessionsLabel(label.sessions),
                    value: formatFocusTotal(label.focused),
                    share: _share(label.focused, stats.byLabel.first.focused),
                  ),
              ],
            ),
          ],
          if (stats.byList.isNotEmpty) ...[
            const SizedBox(height: 16),
            _SectionHeader(title: tr('stats_by_list')),
            const SizedBox(height: 10),
            SurfaceGroup(
              children: [
                for (final list in stats.byList)
                  _ShareTile(
                    title: blockListTitle(id: list.id, name: list.name),
                    detail: _sessionsLabel(list.sessions),
                    value: formatFocusTotal(list.focused),
                    share: _share(list.focused, stats.byList.first.focused),
                  ),
              ],
            ),
          ],
          const SizedBox(height: 16),
          _SectionHeader(title: tr('stats_all_time')),
          const SizedBox(height: 10),
          SurfaceGroup(
            children: [
              _StatRow(
                label: tr('stats_total_focused'),
                value: formatFocusTotal(stats.focused),
              ),
              _StatRow(
                label: tr('stats_sessions'),
                value: '${stats.sessionCount}',
              ),
              _StatRow(
                label: tr('stats_finished'),
                value: '${stats.finishedCount}',
              ),
              _StatRow(
                label: tr('stats_ended_early'),
                value: '${stats.endedEarlyCount}',
              ),
              _StatRow(
                label: tr('stats_longest'),
                value: formatFocusTotal(stats.longest),
              ),
              if (stats.focused > Duration.zero)
                _StatRow(
                  label: tr('stats_average'),
                  value: formatFocusTotal(stats.average),
                ),
              if (stats.givenBack > Duration.zero)
                _StatRow(
                  label: tr('stats_given_back'),
                  value: formatFocusTotal(stats.givenBack),
                ),
              if (stats.bestDay case final best?)
                _StatRow(
                  label: tr('stats_best_day'),
                  value: _bestDayLabel(best),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

double _share(Duration focused, Duration largest) {
  if (largest.inSeconds <= 0 || focused.inSeconds <= 0) return 0;
  return focused.inSeconds / largest.inSeconds;
}

String _sessionsLabel(int count) {
  return counted(count, one: 'stats_one_session', many: 'stats_sessions_count');
}

String _weekCaption(FocusStats stats) {
  final days = _daysLabel(stats.weekDays);
  return '${_sessionsLabel(stats.weekSessions)} · $days';
}

String _stayedValue(FocusStats stats) {
  if (stats.ranCount == 0) return '—';
  return '${(stats.stayedCount * 100 / stats.ranCount).round()}%';
}

String _stayedCaption(FocusStats stats) {
  final ran = stats.ranCount;
  final stayed = stats.stayedCount;
  if (ran == 0) return tr('stats_not_started_yet');
  if (stayed == ran) {
    return ran == 1
        ? tr('stats_one_session')
        : tr('stats_all_sessions', args: ['$ran']);
  }
  return tr('stats_stayed_of', args: ['$stayed', '$ran']);
}

String _bestDayLabel(DayFocus day) {
  return tr(
    'stats_best_day_value',
    args: [weekdayShort(day.day.weekday), formatFocusTotal(day.focused)],
  );
}

String _daysLabel(int days) {
  return counted(days, one: 'stats_one_day', many: 'stats_days_count');
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.caption,
  });

  final String label;
  final String value;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;
    return SurfaceCard(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(color: muted),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              maxLines: 1,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.7,
                height: 1.15,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            caption,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: muted,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _WeekChart extends StatelessWidget {
  const _WeekChart({required this.days});

  final List<DayFocus> days;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final maxSeconds = days.fold<int>(
      0,
      (largest, day) =>
          day.focused.inSeconds > largest ? day.focused.inSeconds : largest,
    );

    return SurfaceCard(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 12),
      child: SizedBox(
        height: 156,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final day in days)
              Expanded(
                child: _DayBar(
                  day: day,
                  maxSeconds: maxSeconds,
                  color: scheme.primary,
                  track: scheme.outlineVariant,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DayBar extends StatelessWidget {
  const _DayBar({
    required this.day,
    required this.maxSeconds,
    required this.color,
    required this.track,
  });

  final DayFocus day;
  final int maxSeconds;
  final Color color;
  final Color track;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final today = _isToday(day.day);
    final seconds = day.focused.inSeconds;
    final fraction = maxSeconds == 0 ? 0.0 : seconds / maxSeconds;
    final visible = fraction <= 0 ? 0.0 : fraction.clamp(0.08, 1.0);
    final barColor = seconds <= 0
        ? track
        : today
        ? color
        : color.withValues(alpha: 0.45);
    final label = weekdayShort(day.day.weekday);

    return Semantics(
      label: tr(
        'stats_day_semantics',
        args: [
          label,
          monthShort(day.day.month),
          '${day.day.day}',
          formatFocusTotal(day.focused),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  heightFactor: seconds <= 0 ? 0.035 : visible,
                  widthFactor: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: today ? FontWeight.w700 : FontWeight.w500,
                color: today
                    ? theme.colorScheme.onSurface
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool _isToday(DateTime day) {
  final now = DateTime.now();
  return day.year == now.year && day.month == now.month && day.day == now.day;
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShareTile extends StatelessWidget {
  const _ShareTile({
    required this.title,
    required this.detail,
    required this.value,
    required this.share,
    this.emoji = '',
  });

  final String title;
  final String detail;
  final String value;
  final double share;
  final String emoji;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final hasEmoji = emoji.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (hasEmoji) ...[
                Text(emoji, style: const TextStyle(fontSize: 18, height: 1)),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Padding(
            padding: EdgeInsets.only(left: hasEmoji ? 26 : 0),
            child: Text(
              detail,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: share,
              minHeight: 4,
              backgroundColor: scheme.outlineVariant,
              color: scheme.primary,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
        ],
      ),
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
