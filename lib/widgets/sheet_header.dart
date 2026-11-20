import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../l10n/tr.dart';

/// Space under the last control so sheet content does not sit on the edge.
const double kSheetBottomPadding = 36;

class SheetGrabber extends StatelessWidget {
  const SheetGrabber({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 36,
        height: 5,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outline,
          borderRadius: BorderRadius.circular(99),
        ),
      ),
    );
  }
}

class SheetHeader extends StatelessWidget {
  const SheetHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
    this.actionEnabled = true,
    this.onBack,
    this.trailing,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool actionEnabled;
  final VoidCallback? onBack;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        onBack == null ? 20 : 4,
        onBack == null ? 12 : 4,
        trailing == null ? 12 : 16,
        4,
      ),
      child: Row(
        children: [
          if (onBack != null)
            IconButton(
              tooltip: tr('common_back'),
              visualDensity: VisualDensity.compact,
              onPressed: onBack,
              icon: const Icon(CupertinoIcons.chevron_back),
            ),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
          ),
          ?trailing,
          if (actionLabel != null)
            TextButton(
              onPressed: actionEnabled ? onAction : null,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textStyle: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                ),
              ),
              child: Text(actionLabel!),
            ),
        ],
      ),
    );
  }
}
