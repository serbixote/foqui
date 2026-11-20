import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/tr.dart';
import '../models/block_list.dart';
import '../models/focus_label.dart';
import '../state/focus_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/block_list_app_line.dart';
import '../widgets/empty_state.dart';
import '../widgets/floating_tab_bar.dart';
import '../widgets/screen_header.dart';
import '../widgets/sheet_header.dart';
import '../widgets/surface_card.dart';
import 'block_list_sheet.dart';
import 'label_sheet.dart';

Future<void> showBlockListInfo(BuildContext context) {
  return _showSectionInfo(
    context,
    title: tr('lists_title'),
    body: tr('lists_about'),
  );
}

Future<void> showLabelInfo(BuildContext context) {
  return _showSectionInfo(
    context,
    title: tr('lists_labels'),
    body: tr('lists_about_label'),
  );
}

Future<void> _showSectionInfo(
  BuildContext context, {
  required String title,
  required String body,
}) {
  return showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (context) {
      final theme = Theme.of(context);
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          const SheetGrabber(),
          SheetHeader(title: title),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, kSheetBottomPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  body,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  child: Text(tr('lists_got_it')),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

class BlockListsScreen extends ConsumerStatefulWidget {
  const BlockListsScreen({super.key});

  @override
  ConsumerState<BlockListsScreen> createState() => _BlockListsScreenState();
}

class _BlockListsScreenState extends ConsumerState<BlockListsScreen> {
  var _labels = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(focusControllerProvider);

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, kFloatingContentInset),
        children: [
          ScreenHeader(
            title: _labels ? tr('lists_labels') : tr('lists_title'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: _labels ? tr('lists_what_label') : tr('lists_what'),
                  constraints: const BoxConstraints.tightFor(
                    width: 36,
                    height: 36,
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () => _labels
                      ? showLabelInfo(context)
                      : showBlockListInfo(context),
                  icon: const Icon(CupertinoIcons.info_circle, size: 22),
                ),
                IconButton(
                  tooltip: _labels
                      ? tr('lists_new_label')
                      : tr('lists_new_list'),
                  constraints: const BoxConstraints.tightFor(
                    width: 36,
                    height: 36,
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () => _labels
                      ? showLabelSheet(context)
                      : showBlockListSheet(context),
                  icon: Icon(
                    CupertinoIcons.plus,
                    size: 22,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _ViewTabs(
            labels: _labels,
            onSelected: (labels) {
              if (labels == _labels) return;
              HapticFeedback.selectionClick();
              setState(() => _labels = labels);
            },
          ),
          const SizedBox(height: 20),
          if (_labels)
            for (var i = 0; i < state.labels.length; i++) ...[
              if (i > 0) const SizedBox(height: 10),
              SurfaceCard(radius: 14, child: _LabelRow(label: state.labels[i])),
            ]
          else if (state.lists.isEmpty)
            EmptyState(
              icon: CupertinoIcons.square_stack_3d_up,
              message: tr('lists_empty'),
            )
          else
            for (var i = 0; i < state.lists.length; i++) ...[
              if (i > 0) const SizedBox(height: 10),
              SurfaceCard(child: _BlockListTile(list: state.lists[i])),
            ],
        ],
      ),
    );
  }
}

class _ViewTabs extends StatelessWidget {
  const _ViewTabs({required this.labels, required this.onSelected});

  final bool labels;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final tabWidth = constraints.maxWidth / 2;
            return SizedBox(
              height: 36,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    left: labels ? tabWidth : 0,
                    width: tabWidth,
                    top: 0,
                    bottom: 0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: FoquiColors.raised,
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      _ViewTab(
                        label: tr('lists_title'),
                        selected: !labels,
                        onTap: () => onSelected(false),
                      ),
                      _ViewTab(
                        label: tr('lists_labels'),
                        selected: labels,
                        onTap: () => onSelected(true),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ViewTab extends StatelessWidget {
  const _ViewTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
              color: selected ? scheme.onSurface : scheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

class _LabelRow extends StatelessWidget {
  const _LabelRow({required this.label});

  final FocusLabel label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final editable = !isBuiltInLabel(label.id);
    final row = Padding(
      padding: EdgeInsets.fromLTRB(22, 14, editable ? 4 : 22, 14),
      child: Row(
        children: [
          Text(label.emoji, style: const TextStyle(fontSize: 20, height: 1)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              localizedLabelName(id: label.id, name: label.name),
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (editable)
            IconButton(
              tooltip: tr('lists_edit_label'),
              visualDensity: VisualDensity.compact,
              onPressed: () => showLabelSheet(context, existing: label),
              icon: Icon(
                CupertinoIcons.pencil,
                size: 18,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
    if (!editable) return row;
    return InkWell(
      onTap: () => showLabelSheet(context, existing: label),
      child: row,
    );
  }
}

class _BlockListTile extends ConsumerWidget {
  const _BlockListTile({required this.list});

  final BlockList list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return InkWell(
      onTap: () => showBlockListSheet(context, existing: list),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 4, 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blockListTitle(id: list.id, name: list.name),
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  BlockListAppLine(list: list),
                ],
              ),
            ),
            IconButton(
              tooltip: list.isFavorite
                  ? tr('lists_default')
                  : tr('lists_make_default'),
              visualDensity: VisualDensity.compact,
              onPressed: () {
                HapticFeedback.selectionClick();
                ref.read(focusControllerProvider.notifier).setFavorite(list.id);
              },
              icon: Icon(
                list.isFavorite
                    ? CupertinoIcons.star_fill
                    : CupertinoIcons.star,
                size: 18,
                color: list.isFavorite
                    ? scheme.primary
                    : scheme.onSurfaceVariant,
              ),
            ),
            IconButton(
              tooltip: tr('lists_edit'),
              visualDensity: VisualDensity.compact,
              onPressed: () => showBlockListSheet(context, existing: list),
              icon: Icon(
                CupertinoIcons.pencil,
                size: 18,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
