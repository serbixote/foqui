import 'package:flutter/material.dart';

import '../l10n/tr.dart';
import '../models/focus_session.dart';
import '../models/session_duration.dart';
import '../widgets/sheet_header.dart';

Future<int?> showDurationSheet(BuildContext context, {required int initial}) {
  return showModalBottomSheet<int>(
    context: context,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (context) => _DurationSheet(initial: clampSessionMinutes(initial)),
  );
}

class _DurationSheet extends StatefulWidget {
  const _DurationSheet({required this.initial});

  final int initial;

  @override
  State<_DurationSheet> createState() => _DurationSheetState();
}

class _DurationSheetState extends State<_DurationSheet> {
  late int _minutes = widget.initial;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        const SheetGrabber(),
        SheetHeader(
          title: tr('duration_title'),
          actionLabel: tr('common_done'),
          onAction: () => Navigator.pop(context, _minutes),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, kSheetBottomPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                minutesLabel(_minutes),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.8,
                  height: 1.05,
                ),
              ),
              Slider(
                min: minSessionMinutes.toDouble(),
                max: maxSessionMinutes.toDouble(),
                divisions: (maxSessionMinutes - minSessionMinutes) ~/ 5,
                value: _minutes.toDouble(),
                label: minutesLabel(_minutes),
                onChanged: (value) => setState(() => _minutes = value.round()),
              ),
              Text(
                tr('duration_minimum', args: ['$minSessionMinutes']),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
