import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/tr.dart';
import '../models/block_list.dart';
import '../models/focus_session.dart';
import '../state/focus_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/sheet_header.dart';
import 'end_session_sheet.dart';

/// Asks before a pause request goes out to the other members.
Future<bool> showPauseRequestSheet(BuildContext context) {
  return _showSheet(context, const _PauseRequestSheet());
}

/// Confirms leaving a shared session. The other members keep going.
Future<bool> showLeaveSessionSheet(BuildContext context) {
  return _showSheet(context, const _LeaveSessionSheet());
}

Future<bool> _showSheet(BuildContext context, Widget sheet) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (context) => sheet,
  ).then((confirmed) => confirmed ?? false);
}

class _PauseRequestSheet extends StatelessWidget {
  const _PauseRequestSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return _SheetFrame(
      children: [
        Text(
          tr('pause_request_title'),
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          tr('pause_request_body'),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
          child: Text(tr('pause_request_confirm')),
        ),
        const SizedBox(height: 4),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(minimumSize: const Size.fromHeight(48)),
          child: Text(tr('end_keep')),
        ),
      ],
    );
  }
}

class _LeaveSessionSheet extends ConsumerStatefulWidget {
  const _LeaveSessionSheet();

  @override
  ConsumerState<_LeaveSessionSheet> createState() => _LeaveSessionSheetState();
}

class _LeaveSessionSheetState extends ConsumerState<_LeaveSessionSheet> {
  var _closing = false;
  Timer? _clock;
  FocusSession? _visible;

  @override
  void initState() {
    super.initState();
    _clock = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _clock?.cancel();
    super.dispose();
  }

  /// Pops this sheet once. A second pop removes the page underneath it,
  /// and the navigator behind that page is black.
  void _close(bool leave) {
    if (_closing) return;
    final route = ModalRoute.of(context);
    if (route != null && !route.isCurrent) return;
    _closing = true;
    Navigator.of(context).pop(leave);
  }

  void _dismissIfSessionGone() {
    if (_closing) return;
    final route = ModalRoute.of(context);
    if (route == null || !route.isCurrent) return;
    _closing = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final active = ModalRoute.of(context);
      if (active == null || !active.isCurrent) return;
      Navigator.of(context).pop(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(focusControllerProvider);
    final candidate = state.foregroundSession;
    final live =
        candidate != null && candidate.outcome != SessionOutcome.created;
    if (live) {
      _visible = candidate;
    } else {
      _dismissIfSessionGone();
    }
    final session = live ? candidate : _visible;
    if (session == null) {
      return const ColoredBox(
        color: FoquiColors.surface,
        child: SizedBox(width: double.infinity, height: 48),
      );
    }
    final counts = sessionMeetsRecordedLength(session, DateTime.now());
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return _SheetFrame(
      children: [
        Text(
          tr('leave_title'),
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          tr(
            'leave_body',
            args: [
              blockListTitle(
                id: session.blockListId,
                name: session.blockListName,
              ),
            ],
          ),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
            height: 1.35,
          ),
        ),
        if (!counts) ...[const SizedBox(height: 16), const ShortSessionNote()],
        const SizedBox(height: 20),
        FilledButton(
          onPressed: () => _close(false),
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
          child: Text(tr('end_keep')),
        ),
        const SizedBox(height: 4),
        TextButton(
          onPressed: () => _close(true),
          style: TextButton.styleFrom(
            foregroundColor: FoquiColors.destructive,
            minimumSize: const Size.fromHeight(48),
          ),
          child: Text(tr('leave_confirm')),
        ),
      ],
    );
  }
}

class _SheetFrame extends StatelessWidget {
  const _SheetFrame({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.92,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            const SheetGrabber(),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                18,
                20,
                kSheetBottomPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
