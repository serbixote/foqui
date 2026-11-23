import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/label_emojis.dart';
import '../models/focus_label.dart';
import '../l10n/tr.dart';
import '../state/focus_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/motion.dart';
import '../widgets/sheet_header.dart';

Future<void> showLabelSheet(BuildContext context, {FocusLabel? existing}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (context) => LabelSheet(existing: existing),
  );
}

class LabelSheet extends ConsumerStatefulWidget {
  const LabelSheet({super.key, this.existing});

  final FocusLabel? existing;

  @override
  ConsumerState<LabelSheet> createState() => _LabelSheetState();
}

const _fallbackPickerHeight = 292.0;

class _LabelSheetState extends ConsumerState<LabelSheet> {
  final TextEditingController _name = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _searchFocus = FocusNode();
  String? _icon;
  var _pickerOpen = false;
  var _expectKeyboard = true;
  var _keyboardInset = 0.0;
  var _busy = false;
  var _showMissing = false;

  @override
  void initState() {
    super.initState();
    _name.text = widget.existing?.name ?? '';
    _icon = widget.existing?.emoji;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _nameFocus.requestFocus();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;
    if (keyboard > _keyboardInset) _keyboardInset = keyboard;
    if (_keyboardInset > 0 && keyboard >= _keyboardInset) {
      _expectKeyboard = false;
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _nameFocus.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  double get _room =>
      _keyboardInset > 0 ? _keyboardInset : _fallbackPickerHeight;

  void _togglePicker() {
    final open = !_pickerOpen;
    setState(() {
      _pickerOpen = open;
      _expectKeyboard = !open;
    });
    if (open) {
      _nameFocus.unfocus();
    } else {
      _nameFocus.requestFocus();
    }
  }

  void _choose(String icon) {
    setState(() {
      _icon = icon;
      _pickerOpen = false;
      _expectKeyboard = true;
    });
    _nameFocus.requestFocus();
  }

  /// Keeps the sheet the same height while the keyboard and the icon picker
  /// trade places, so the top edge does not bounce.
  ({double picker, double padding}) _sheetFoot(double keyboard) {
    final room = _room;
    if (_searchFocus.hasFocus) {
      return (picker: room, padding: keyboard);
    }

    if (_pickerOpen) {
      final known = _keyboardInset > 0 ? _keyboardInset : room;
      final slot = math.max(keyboard, known);
      return (picker: math.max(0.0, slot - keyboard), padding: keyboard);
    }

    if (_expectKeyboard && _keyboardInset > 0) {
      return (
        picker: math.max(0.0, _keyboardInset - keyboard),
        padding: keyboard,
      );
    }

    return (picker: 0, padding: keyboard);
  }

  bool get _iconMissing => _icon == null || _icon!.isEmpty;

  bool get _nameMissing => _name.text.trim().isEmpty;

  /// An edit with the same icon and name would save nothing.
  bool get _unchanged {
    final existing = widget.existing;
    if (existing == null) return false;
    return _icon == existing.emoji &&
        capitalizeLabelName(_name.text) == existing.name;
  }

  bool get _canSave => !_busy && !_unchanged;

  /// Default labels stay. Sessions from a deleted label move onto Focus Time.
  bool get _canDelete {
    final existing = widget.existing;
    return existing != null && !isBuiltInLabel(existing.id) && !_busy;
  }

  void _submit() {
    if (!_canSave) return;
    if (_iconMissing || _nameMissing) {
      setState(() => _showMissing = true);
      if (_nameMissing) _nameFocus.requestFocus();
      return;
    }
    _save();
  }

  Future<void> _save() async {
    final icon = _icon;
    final name = _name.text.trim();
    if (icon == null || icon.isEmpty || name.isEmpty || _busy) return;
    setState(() => _busy = true);
    try {
      final labels = ref.read(focusControllerProvider.notifier);
      final existing = widget.existing;
      if (existing == null) {
        await labels.addLabel(emoji: icon, name: name);
      } else {
        await labels.updateLabel(id: existing.id, emoji: icon, name: name);
      }
      if (!mounted) return;
      Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _confirmDelete() async {
    final existing = widget.existing;
    if (existing == null || !_canDelete) return;
    final focusTime = _focusTime(ref.read(focusControllerProvider).labels);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(tr('label_delete_title')),
          content: Text(
            tr(
              'label_delete_body',
              namedArgs: {
                'name': localizedLabelName(
                  id: focusTime.id,
                  name: focusTime.name,
                ),
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(tr('common_cancel')),
            ),
            TextButton(
              key: const Key('label-delete-confirm'),
              style: TextButton.styleFrom(
                foregroundColor: FoquiColors.destructive,
              ),
              onPressed: () => Navigator.pop(context, true),
              child: Text(tr('common_delete')),
            ),
          ],
        );
      },
    );
    if (confirmed != true || !mounted) return;
    setState(() => _busy = true);
    try {
      await ref.read(focusControllerProvider.notifier).deleteLabel(existing.id);
      if (!mounted) return;
      Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  FocusLabel _focusTime(List<FocusLabel> labels) {
    for (final label in labels) {
      if (label.id == focusTimeLabelId) return label;
    }
    return kBuiltInFocusLabels.first;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;
    final foot = _sheetFoot(keyboard);
    final searching = _searchFocus.hasFocus;
    final nameUnset = _showMissing && _nameMissing;
    final iconUnset = _showMissing && _iconMissing;

    return Padding(
      padding: EdgeInsets.only(bottom: foot.padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          const SheetGrabber(),
          SheetHeader(
            title: widget.existing == null
                ? tr('lists_new_label')
                : tr('lists_edit_label'),
            trailing: _deleteAction(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _LabelIconButton(
                    icon: _icon,
                    open: _pickerOpen,
                    missing: iconUnset,
                    onTap: _togglePicker,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      key: const Key('label-name'),
                      controller: _name,
                      focusNode: _nameFocus,
                      autofocus: true,
                      textCapitalization: TextCapitalization.sentences,
                      onTap: () {
                        if (!_pickerOpen && !_searchFocus.hasFocus) return;
                        setState(() {
                          _pickerOpen = false;
                          _expectKeyboard = true;
                        });
                      },
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _submit(),
                      onChanged: (_) => setState(() {}),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        labelText: tr('common_name'),
                        hintText: tr('label_hint'),
                        enabledBorder: nameUnset ? _missingBorder : null,
                        focusedBorder: nameUnset ? _missingBorder : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FilledButton(
              key: const Key('label-save'),
              onPressed: _canSave ? _submit : null,
              style: FilledButton.styleFrom(
                disabledBackgroundColor: _busy
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withValues(alpha: 0.12),
                disabledForegroundColor: _busy
                    ? Colors.white
                    : theme.colorScheme.onSurface.withValues(alpha: 0.38),
              ),
              child: _busy
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(tr('common_save')),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final available = constraints.maxHeight.isFinite
                      ? math.max(0.0, constraints.maxHeight)
                      : foot.picker;
                  final height = math.min(foot.picker, available);
                  // Lay the grid out in the space it actually has. A short
                  // slot still clips instead of painting past the top.
                  final layout = searching
                      ? math.max(height, 180.0)
                      : math.max(height, _room);
                  return _IconPickerSlot(
                    height: height,
                    layoutHeight: layout,
                    ignore: !_pickerOpen,
                    child: _LabelIconPicker(
                      selected: _icon,
                      searchFocus: _searchFocus,
                      onSelected: _choose,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: kSheetBottomPadding),
        ],
      ),
    );
  }

  /// A label you created can be removed from the corner. Save stays below.
  Widget? _deleteAction() {
    final existing = widget.existing;
    if (existing == null || isBuiltInLabel(existing.id)) return null;
    return IconButton(
      key: const Key('label-delete'),
      tooltip: tr('common_delete'),
      visualDensity: VisualDensity.compact,
      onPressed: _canDelete ? _confirmDelete : null,
      icon: const Icon(
        CupertinoIcons.trash,
        size: 22,
        color: FoquiColors.destructive,
      ),
    );
  }
}

final _missingBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: BorderSide(
    color: FoquiColors.destructive.withValues(alpha: 0.55),
    width: 1.5,
  ),
);

class _LabelIconButton extends StatelessWidget {
  const _LabelIconButton({
    required this.icon,
    required this.open,
    required this.missing,
    required this.onTap,
  });

  final String? icon;
  final bool open;
  final bool missing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final icon = this.icon;

    return Tooltip(
      message: tr('label_choose_icon'),
      child: SizedBox(
        width: 64,
        child: Material(
          color: scheme.surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: open
                  ? scheme.primary
                  : missing
                  ? FoquiColors.destructive.withValues(alpha: 0.55)
                  : Colors.transparent,
              width: 1.5,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            key: const Key('label-emoji'),
            onTap: onTap,
            child: Center(
              child: MotionSwap(
                switchKey: icon ?? '',
                alignment: Alignment.center,
                child: icon == null
                    ? Icon(
                        CupertinoIcons.smiley,
                        size: 26,
                        color: scheme.onSurfaceVariant,
                      )
                    : Text(
                        icon,
                        style: const TextStyle(fontSize: 28, height: 1),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IconPickerSlot extends StatelessWidget {
  const _IconPickerSlot({
    required this.height,
    required this.layoutHeight,
    required this.ignore,
    required this.child,
  });

  final double height;
  final double layoutHeight;
  final bool ignore;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (height <= 0) return const SizedBox(width: double.infinity);
    final layout = math.max(height, layoutHeight);
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.topCenter,
          minHeight: layout,
          maxHeight: layout,
          child: IgnorePointer(
            ignoring: ignore,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class _LabelIconPicker extends StatefulWidget {
  const _LabelIconPicker({
    required this.selected,
    required this.searchFocus,
    required this.onSelected,
  });

  final String? selected;
  final FocusNode searchFocus;
  final ValueChanged<String> onSelected;

  @override
  State<_LabelIconPicker> createState() => _LabelIconPickerState();
}

class _LabelIconPickerState extends State<_LabelIconPicker> {
  final TextEditingController _query = TextEditingController();

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final icons = matchingLabelEmojis(
      Localizations.localeOf(context).languageCode,
      _query.text,
      widget.selected,
    );

    return Material(
      color: scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
            child: TextField(
              key: const Key('label-icon-search'),
              controller: _query,
              focusNode: widget.searchFocus,
              onChanged: (_) => setState(() {}),
              style: theme.textTheme.bodyMedium,
              cursorColor: scheme.primary,
              decoration: InputDecoration(
                isDense: true,
                hintText: tr('label_search'),
                hintStyle: TextStyle(color: scheme.onSurfaceVariant),
                prefixIcon: Icon(
                  CupertinoIcons.search,
                  size: 18,
                  color: scheme.onSurfaceVariant,
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 36,
                  minHeight: 36,
                ),
                filled: true,
                fillColor: scheme.surface,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: scheme.primary, width: 1.5),
                ),
              ),
            ),
          ),
          Expanded(
            child: icons.isEmpty
                ? Center(
                    child: Text(
                      tr('label_search_empty'),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  )
                : GridView.builder(
                    primary: false,
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                        ),
                    itemCount: icons.length,
                    itemBuilder: (context, index) {
                      final icon = icons[index].emoji;
                      final chosen = icon == widget.selected;
                      return Material(
                        color: chosen
                            ? scheme.primary.withValues(alpha: 0.22)
                            : Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: chosen ? scheme.primary : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          key: Key('label-icon-$icon'),
                          onTap: () => widget.onSelected(icon),
                          child: Center(
                            child: Text(
                              icon,
                              style: const TextStyle(fontSize: 24, height: 1),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
