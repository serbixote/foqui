import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/tr.dart';
import '../models/block_list.dart';
import '../models/focus_label.dart';
import '../models/focus_session.dart';
import '../models/session_duration.dart';
import '../state/focus_controller.dart';
import '../widgets/sheet_header.dart';
import '../widgets/surface_card.dart';
import 'block_list_sheet.dart';
import 'duration_sheet.dart';
import 'label_sheet.dart';

enum SessionSheetAction { start, create }

class StartSessionChoice {
  const StartSessionChoice({
    required this.listId,
    required this.minutes,
    required this.action,
    required this.label,
  });

  final String listId;

  /// Null when the session has no set length.
  final int? minutes;

  final SessionSheetAction action;

  /// Label this session is for. Chosen before the session is saved.
  final FocusLabel label;
}

enum _SheetPage { form, lists, labels }

const _sectionSlide = Duration(milliseconds: 350);

Future<StartSessionChoice?> showStartSessionSheet(BuildContext context) {
  return showModalBottomSheet<StartSessionChoice>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (context) => const StartSessionSheet(),
  );
}

class StartSessionSheet extends ConsumerStatefulWidget {
  const StartSessionSheet({super.key});

  @override
  ConsumerState<StartSessionSheet> createState() => _StartSessionSheetState();
}

class _StartSessionSheetState extends ConsumerState<StartSessionSheet> {
  int? _minutes;
  var _durationChosen = false;
  String? _listId;
  String? _labelId;
  var _page = _SheetPage.form;
  var _forward = true;

  BlockList? _selectedList(FocusState state) {
    final preferred = _listId ?? _preferredListId(state);
    if (preferred == null) return null;
    for (final list in state.lists) {
      if (list.id == preferred) return list;
    }
    return null;
  }

  FocusLabel _selectedLabel(FocusState state) {
    final preferred = _labelId;
    if (preferred != null) {
      for (final label in state.labels) {
        if (label.id == preferred) return label;
      }
    }
    return state.labels.first;
  }

  String? _preferredListId(FocusState state) {
    final favorite = state.favoriteList;
    if (favorite != null && !favorite.isEmpty) return favorite.id;
    return null;
  }

  int? _resolvedMinutes(int? stored) => _durationChosen ? _minutes : stored;

  void _chooseDuration(int? minutes) {
    HapticFeedback.selectionClick();
    setState(() {
      _durationChosen = true;
      _minutes = minutes;
    });
  }

  Future<void> _pickCustomDuration(int? current) async {
    final minutes = await showDurationSheet(context, initial: current ?? 25);
    if (minutes == null) return;
    setState(() {
      _durationChosen = true;
      _minutes = minutes;
    });
  }

  void _openListPicker() => _openSection(_SheetPage.lists);

  void _openLabelPicker() => _openSection(_SheetPage.labels);

  void _openSection(_SheetPage page) {
    setState(() {
      _forward = true;
      _page = page;
    });
  }

  void _showForm() {
    _forward = false;
    _page = _SheetPage.form;
  }

  void _closePicker() => setState(_showForm);

  void _submit(SessionSheetAction action) {
    final current = ref.read(focusControllerProvider);
    final selected = _selectedList(current);
    if (selected == null || selected.isEmpty) {
      _openListPicker();
      return;
    }
    Navigator.pop(
      context,
      _choice(
        list: selected,
        label: _selectedLabel(current),
        minutes: _resolvedMinutes(current.durationMinutes),
        action: action,
      ),
    );
  }

  StartSessionChoice _choice({
    required BlockList list,
    required FocusLabel label,
    required int? minutes,
    required SessionSheetAction action,
  }) {
    return StartSessionChoice(
      listId: list.id,
      minutes: minutes,
      action: action,
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(focusControllerProvider);
    final minutes = _resolvedMinutes(state.durationMinutes);
    final selected = _selectedList(state);
    final label = _selectedLabel(state);

    ref.listen(focusControllerProvider, (previous, next) {
      final knownLists = {
        for (final list in previous?.lists ?? const <BlockList>[]) list.id,
      };
      for (final list in next.lists) {
        if (!knownLists.contains(list.id) && !list.isEmpty) {
          setState(() {
            _listId = list.id;
            _showForm();
          });
          return;
        }
      }
      final knownLabels = {
        for (final existing in previous?.customLabels ?? const <FocusLabel>[])
          existing.id,
      };
      for (final created in next.customLabels) {
        if (!knownLabels.contains(created.id)) {
          setState(() {
            _labelId = created.id;
            _showForm();
          });
          return;
        }
      }
    });

    final Widget page;
    switch (_page) {
      case _SheetPage.lists:
        page = _BlockListPicker(
          lists: state.lists,
          selectedId: selected?.id,
          onBack: _closePicker,
          onSelect: (list) {
            HapticFeedback.selectionClick();
            setState(() {
              _listId = list.id;
              _showForm();
            });
          },
        );
      case _SheetPage.labels:
        page = _LabelPicker(
          labels: state.labels,
          selectedId: label.id,
          onBack: _closePicker,
          onSelect: (picked) {
            HapticFeedback.selectionClick();
            setState(() {
              _labelId = picked.id;
              _showForm();
            });
          },
        );
      case _SheetPage.form:
        page = _SessionForm(
          minutes: minutes,
          selected: selected,
          label: label,
          onChooseDuration: _chooseDuration,
          onPickCustom: () => _pickCustomDuration(minutes),
          onOpenLists: _openListPicker,
          onOpenLabels: _openLabelPicker,
          onStart: () => _submit(SessionSheetAction.start),
          onCreate: () => _submit(SessionSheetAction.create),
        );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        const SheetGrabber(),
        _SheetSectionTransition(page: _page, forward: _forward, child: page),
      ],
    );
  }
}

/// Slides a picker in over the session form, and back out again.
///
/// The new section comes in from the right while the form shifts left, and
/// the reverse plays on the way back. Height stays on the form so the sheet
/// does not resize under the push.
class _SheetSectionTransition extends StatefulWidget {
  const _SheetSectionTransition({
    required this.page,
    required this.forward,
    required this.child,
  });

  final _SheetPage page;
  final bool forward;
  final Widget child;

  @override
  State<_SheetSectionTransition> createState() =>
      _SheetSectionTransitionState();
}

class _SheetSectionTransitionState extends State<_SheetSectionTransition>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _motion;
  Widget? _outgoing;
  var _movingForward = true;
  double? _formHeight;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _sectionSlide,
      value: 1,
    );
    _motion = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastEaseInToSlowEaseOut,
    );
    _controller.addStatusListener(_onStatus);
  }

  void _onStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed || _outgoing == null || !mounted) {
      return;
    }
    setState(() => _outgoing = null);
  }

  void _rememberFormHeight(double height) {
    if (widget.page != _SheetPage.form || _outgoing != null) return;
    final current = _formHeight;
    if (current != null && (current - height).abs() < 0.5) return;
    setState(() => _formHeight = height);
  }

  @override
  void didUpdateWidget(covariant _SheetSectionTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.page == oldWidget.page) return;
    _outgoing = oldWidget.child;
    _movingForward = widget.forward;
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_onStatus);
    _motion.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;
    final previous = _outgoing;
    final formHeight = _formHeight;
    final lockHeight =
        formHeight != null &&
        (widget.page != _SheetPage.form || previous != null);
    final incoming = _pageFrame(surface, widget.child, lockHeight);
    final Widget body;
    if (previous == null) {
      body = incoming;
    } else {
      final leaving = _pageFrame(surface, previous, lockHeight);
      final forward = _movingForward;
      body = AnimatedBuilder(
        animation: _motion,
        builder: (context, _) {
          final travel = _motion.value;
          final entering = FractionalTranslation(
            translation: Offset.lerp(
              forward ? const Offset(1, 0) : const Offset(-1 / 3, 0),
              Offset.zero,
              travel,
            )!,
            child: forward ? _edgeShadow(incoming) : incoming,
          );
          final exiting = Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: FractionalTranslation(
              translation: Offset.lerp(
                Offset.zero,
                forward ? const Offset(-1 / 3, 0) : const Offset(1, 0),
                travel,
              )!,
              child: forward ? leaving : _edgeShadow(leaving),
            ),
          );
          return Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.hardEdge,
            children: forward ? [exiting, entering] : [entering, exiting],
          );
        },
      );
    }

    if (lockHeight) return body;
    return _FormHeightReporter(onChanged: _rememberFormHeight, child: body);
  }

  Widget _pageFrame(Color surface, Widget child, bool lockHeight) {
    final page = ColoredBox(
      color: surface,
      child: lockHeight
          ? Align(alignment: Alignment.topCenter, child: child)
          : child,
    );
    return RepaintBoundary(
      child: lockHeight ? SizedBox(height: _formHeight, child: page) : page,
    );
  }

  Widget _edgeShadow(Widget child) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x29000000),
            blurRadius: 16,
            offset: Offset(-8, 0),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _FormHeightReporter extends StatefulWidget {
  const _FormHeightReporter({required this.onChanged, required this.child});

  final ValueChanged<double> onChanged;
  final Widget child;

  @override
  State<_FormHeightReporter> createState() => _FormHeightReporterState();
}

class _FormHeightReporterState extends State<_FormHeightReporter> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final box = context.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) return;
      widget.onChanged(box.size.height);
    });
    return widget.child;
  }
}

class _SessionForm extends StatelessWidget {
  const _SessionForm({
    required this.minutes,
    required this.selected,
    required this.label,
    required this.onChooseDuration,
    required this.onPickCustom,
    required this.onOpenLists,
    required this.onOpenLabels,
    required this.onStart,
    required this.onCreate,
  });

  final int? minutes;
  final BlockList? selected;
  final FocusLabel label;
  final ValueChanged<int?> onChooseDuration;
  final VoidCallback onPickCustom;
  final VoidCallback onOpenLists;
  final VoidCallback onOpenLabels;
  final VoidCallback? onStart;
  final VoidCallback? onCreate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final custom = minutes != null && !sessionPresets.contains(minutes);
    final muted = theme.textTheme.titleSmall?.copyWith(
      fontWeight: FontWeight.w600,
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, kSheetBottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(tr('session_duration'), style: muted),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 12,
            children: [
              _DurationChoice(
                label: tr('session_until_end'),
                selected: minutes == null,
                onTap: () => onChooseDuration(null),
              ),
              for (final preset in sessionPresets)
                _DurationChoice(
                  label: minutesLabel(preset),
                  selected: minutes == preset,
                  onTap: () => onChooseDuration(preset),
                ),
              _DurationChoice(
                label: custom ? minutesLabel(minutes!) : tr('session_other'),
                selected: custom,
                onTap: onPickCustom,
              ),
            ],
          ),
          const SizedBox(height: 32),
          _ChoiceRow(
            title: tr('session_label'),
            value: localizedLabelName(id: label.id, name: label.name),
            emoji: label.emoji,
            onTap: onOpenLabels,
          ),
          const SizedBox(height: 14),
          _ChoiceRow(
            title: tr('session_block_list'),
            value: selected?.name ?? tr('session_none'),
            muted: selected == null,
            onTap: onOpenLists,
          ),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: onStart,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(64),
            ),
            child: Text(tr('session_start')),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onCreate,
            style: TextButton.styleFrom(minimumSize: const Size.fromHeight(48)),
            child: Text(tr('session_create')),
          ),
        ],
      ),
    );
  }
}

class _ChoiceRow extends StatelessWidget {
  const _ChoiceRow({
    required this.title,
    required this.value,
    required this.onTap,
    this.emoji,
    this.muted = false,
  });

  final String title;
  final String value;
  final String? emoji;
  final bool muted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final valueStyle = theme.textTheme.bodyLarge?.copyWith(
      color: muted ? scheme.onSurfaceVariant : scheme.onSurface,
      fontWeight: FontWeight.w600,
    );
    return Material(
      color: scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Row(
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (emoji != null) ...[
                      Text(
                        emoji!,
                        style: const TextStyle(fontSize: 18, height: 1),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Flexible(
                      child: Text(
                        value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: valueStyle,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                CupertinoIcons.chevron_right,
                size: 16,
                color: scheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BlockListPicker extends StatelessWidget {
  const _BlockListPicker({
    required this.lists,
    required this.selectedId,
    required this.onBack,
    required this.onSelect,
  });

  final List<BlockList> lists;
  final String? selectedId;
  final VoidCallback onBack;
  final ValueChanged<BlockList> onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SheetHeader(
          title: tr('session_block_list'),
          onBack: onBack,
          trailing: _SheetAddButton(
            tooltip: tr('lists_new_list'),
            onPressed: () => showBlockListSheet(context),
          ),
        ),
        Flexible(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, kSheetBottomPadding),
            children: [
              if (lists.isEmpty)
                Text(
                  tr('session_no_lists'),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.35,
                  ),
                )
              else
                SurfaceGroup(
                  dividerIndent: 52,
                  children: [
                    for (final list in lists)
                      _ListChoice(
                        list: list,
                        selected: list.id == selectedId && !list.isEmpty,
                        onTap: () {
                          if (list.isEmpty) {
                            showBlockListSheet(context, existing: list);
                            return;
                          }
                          onSelect(list);
                        },
                        onEdit: () =>
                            showBlockListSheet(context, existing: list),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LabelPicker extends StatelessWidget {
  const _LabelPicker({
    required this.labels,
    required this.selectedId,
    required this.onBack,
    required this.onSelect,
  });

  final List<FocusLabel> labels;
  final String selectedId;
  final VoidCallback onBack;
  final ValueChanged<FocusLabel> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SheetHeader(
          title: tr('session_label'),
          onBack: onBack,
          trailing: _SheetAddButton(
            tooltip: tr('lists_new_label'),
            onPressed: () => showLabelSheet(context),
          ),
        ),
        Flexible(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, kSheetBottomPadding),
            children: [
              SurfaceGroup(
                dividerIndent: 52,
                children: [
                  for (final label in labels)
                    _LabelChoice(
                      label: label,
                      selected: label.id == selectedId,
                      onTap: () => onSelect(label),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SheetAddButton extends StatelessWidget {
  const _SheetAddButton({required this.tooltip, required this.onPressed});

  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(
        CupertinoIcons.plus,
        size: 26,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class _LabelChoice extends StatelessWidget {
  const _LabelChoice({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final FocusLabel label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Row(
          children: [
            Icon(
              selected
                  ? CupertinoIcons.checkmark_circle_fill
                  : CupertinoIcons.circle,
              color: selected ? scheme.primary : scheme.onSurfaceVariant,
            ),
            const SizedBox(width: 14),
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
          ],
        ),
      ),
    );
  }
}

class _ListChoice extends StatelessWidget {
  const _ListChoice({
    required this.list,
    required this.selected,
    required this.onTap,
    required this.onEdit,
  });

  final BlockList list;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 4, 12),
        child: Row(
          children: [
            Icon(
              selected
                  ? CupertinoIcons.checkmark_circle_fill
                  : CupertinoIcons.circle,
              color: selected ? scheme.primary : scheme.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    list.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    list.summary,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: tr('lists_edit'),
              visualDensity: VisualDensity.compact,
              onPressed: onEdit,
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

class _DurationChoice extends StatelessWidget {
  const _DurationChoice({
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
    return Material(
      color: selected
          ? scheme.primary.withValues(alpha: 0.12)
          : scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashFactory: NoSplash.splashFactory,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: selected ? scheme.primary : scheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
