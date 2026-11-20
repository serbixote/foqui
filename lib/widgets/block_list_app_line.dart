import 'package:flutter/material.dart';

import '../l10n/tr.dart';
import '../models/block_list.dart';

/// Categories and websites that sit after the app names.
String blockListExtra(BlockList list) {
  final parts = <String>[];
  if (list.categoryCount > 0) {
    parts.add(
      counted(
        list.categoryCount,
        one: 'count_one_category',
        many: 'count_categories',
      ),
    );
  }
  if (list.webDomainCount > 0) {
    parts.add(
      counted(
        list.webDomainCount,
        one: 'count_one_website',
        many: 'count_websites',
      ),
    );
  }
  if (parts.isEmpty) return '';
  return ' · ${parts.join(' · ')}';
}

/// "3 apps: Twitter, TikTok, ..." with only as many names as [maxWidth] holds.
String fitApplicationLine({
  required int count,
  required List<String> names,
  required String suffix,
  required double maxWidth,
  required TextStyle style,
  TextScaler textScaler = TextScaler.noScaling,
}) {
  final head = counted(count, one: 'count_one_app', many: 'count_apps');
  if (names.isEmpty) {
    return suffix.isEmpty ? head : '$head$suffix';
  }

  final painter = TextPainter(
    textDirection: TextDirection.ltr,
    maxLines: 1,
    textScaler: textScaler,
  );

  bool fits(String text) {
    painter.text = TextSpan(text: text, style: style);
    painter.layout(maxWidth: maxWidth);
    return !painter.didExceedMaxLines && painter.size.width <= maxWidth + 0.5;
  }

  final full = '$head: ${names.join(', ')}$suffix';
  if (fits(full)) return full;

  final shown = <String>[];
  for (final name in names) {
    final next = [...shown, name];
    final candidate = '$head: ${next.join(', ')}, ...$suffix';
    if (!fits(candidate)) break;
    shown.add(name);
  }
  if (shown.isEmpty) {
    final withSuffix = '$head: ...$suffix';
    if (fits(withSuffix)) return withSuffix;
    if (fits('$head: ...')) return '$head: ...';
    return suffix.isEmpty ? head : '$head$suffix';
  }
  return '$head: ${shown.join(', ')}, ...$suffix';
}

class BlockListAppLine extends StatelessWidget {
  const BlockListAppLine({super.key, required this.list});

  final BlockList list;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style =
        theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          height: 1.3,
        ) ??
        TextStyle(color: theme.colorScheme.onSurfaceVariant, height: 1.3);

    if (list.applicationCount <= 0) {
      return Text(list.summary, style: style);
    }

    final suffix = blockListExtra(list);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Text(
          fitApplicationLine(
            count: list.applicationCount,
            names: list.applicationNames,
            suffix: suffix,
            maxWidth: constraints.maxWidth,
            style: style,
            textScaler: MediaQuery.textScalerOf(context),
          ),
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: style,
        );
      },
    );
  }
}
