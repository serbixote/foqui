import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../l10n/tr.dart';
import '../models/block_list.dart';
import '../services/focus_shield_bridge.dart';
import '../state/focus_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/sheet_header.dart';

const _uuid = Uuid();

Future<void> showBlockListSheet(BuildContext context, {BlockList? existing}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (context) => BlockListSheet(existing: existing),
  );
}

class BlockListSheet extends ConsumerStatefulWidget {
  const BlockListSheet({super.key, this.existing});

  final BlockList? existing;

  @override
  ConsumerState<BlockListSheet> createState() => _BlockListSheetState();
}

class _BlockListSheetState extends ConsumerState<BlockListSheet> {
  late final String _id = widget.existing?.id ?? _uuid.v4();
  late final TextEditingController _name = TextEditingController(
    text: widget.existing?.name ?? '',
  );
  late int _apps = widget.existing?.applicationCount ?? 0;
  late int _categories = widget.existing?.categoryCount ?? 0;
  late int _websites = widget.existing?.webDomainCount ?? 0;
  late List<String> _names = widget.existing?.applicationNames ?? const [];
  var _touchedPicker = false;
  var _saved = false;
  var _busy = false;

  int get _total => _apps + _categories + _websites;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _discardDraftIfNeeded() {
    if (_saved || !_touchedPicker || !mounted) return;
    unawaited(ref.read(focusShieldBridgeProvider).discardDraft(_id));
  }

  Future<void> _pickApps() async {
    final authorization = await ref
        .read(authorizationProvider.notifier)
        .request();
    if (!mounted) return;
    if (!authorization.isAuthorized) return;

    try {
      final counts = await ref
          .read(focusShieldBridgeProvider)
          .presentAppPicker(_id);
      if (!mounted || counts == null) return;
      setState(() {
        _apps = counts.applicationCount;
        _categories = counts.categoryCount;
        _websites = counts.webDomainCount;
        if (counts.applicationNames.isNotEmpty) {
          _names = counts.applicationNames;
        }
        _touchedPicker = true;
      });
    } on FocusShieldException {
      // Toasts are disabled for now.
    }
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty || _total == 0 || _busy) return;
    setState(() => _busy = true);
    try {
      var apps = _apps;
      var categories = _categories;
      var websites = _websites;
      var names = _names;
      if (_touchedPicker) {
        final counts = await ref
            .read(focusShieldBridgeProvider)
            .commitSelection(_id);
        if (!mounted) return;
        if (counts == null || counts.total == 0) return;
        apps = counts.applicationCount;
        categories = counts.categoryCount;
        websites = counts.webDomainCount;
        if (counts.applicationNames.isNotEmpty) names = counts.applicationNames;
      }

      await ref
          .read(focusControllerProvider.notifier)
          .upsertList(
            BlockList(
              id: _id,
              name: name,
              applicationCount: apps,
              categoryCount: categories,
              webDomainCount: websites,
              applicationNames: names,
              updatedAt: DateTime.now(),
            ),
          );
      _saved = true;
      if (!mounted) return;
      Navigator.pop(context);
    } on FocusShieldException {
      // Toasts are disabled for now.
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(tr('list_delete_title')),
          content: Text(tr('list_delete_body')),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(tr('common_cancel')),
            ),
            TextButton(
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
    try {
      await ref.read(focusControllerProvider.notifier).deleteList(_id);
      _saved = true;
      if (!mounted) return;
      Navigator.pop(context);
    } on FocusShieldException {
      // Toasts are disabled for now.
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    final summary = BlockList(
      id: _id,
      name: _name.text,
      applicationCount: _apps,
      categoryCount: _categories,
      webDomainCount: _websites,
      updatedAt: DateTime.now(),
    ).summary;
    final canSave = _name.text.trim().isNotEmpty && _total > 0 && !_busy;

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) _discardDraftIfNeeded();
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            const SheetGrabber(),
            SheetHeader(
              title: widget.existing == null ? tr('list_new') : tr('list_edit'),
              actionLabel: _busy ? tr('common_saving') : tr('common_save'),
              actionEnabled: canSave,
              onAction: _save,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                8,
                20,
                kSheetBottomPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _name,
                    textCapitalization: TextCapitalization.sentences,
                    autofocus: widget.existing == null,
                    onChanged: (_) => setState(() {}),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      labelText: tr('common_name'),
                      hintText: tr('label_deep_work'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Material(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(14),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: _busy ? null : _pickApps,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tr('list_choose_apps'),
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    summary,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              CupertinoIcons.chevron_right,
                              size: 18,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (widget.existing != null)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: _busy ? null : _delete,
                        style: TextButton.styleFrom(
                          foregroundColor: FoquiColors.destructive,
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                        ),
                        child: Text(tr('list_delete')),
                      ),
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
