import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/tr.dart';
import '../models/block_list.dart';
import '../models/focus_session.dart';
import '../state/focus_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/sheet_header.dart';

/// Confirms ending the session in progress. A dismissed sheet keeps it going.
Future<bool> showEndSessionSheet(BuildContext context) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (context) => const EndSessionSheet(),
  ).then((confirmed) => confirmed ?? false);
}

class EndSessionSheet extends ConsumerStatefulWidget {
  const EndSessionSheet({super.key});

  @override
  ConsumerState<EndSessionSheet> createState() => _EndSessionSheetState();
}

class _EndSessionSheetState extends ConsumerState<EndSessionSheet> {
  var _closing = false;
  Timer? _clock;

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

  void _keepGoing() => _close(false);

  void _endSession() => _close(true);

  void _close(bool end) {
    if (_closing) return;
    _closing = true;
    Navigator.of(context).pop(end);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(focusControllerProvider);
    final candidate = state.foregroundSession;
    if (candidate == null || candidate.outcome == SessionOutcome.created) {
      if (!_closing) {
        _closing = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) Navigator.of(context).pop(false);
        });
      }
      return const SizedBox.shrink();
    }
    final session = candidate;
    final counts = sessionMeetsRecordedLength(session, DateTime.now());

    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

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
                children: [
                  Text(
                    tr('end_title'),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    tr(
                      'end_body',
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
                  if (!counts) ...[
                    const SizedBox(height: 16),
                    const ShortSessionNote(),
                  ],
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: _keepGoing,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: Text(tr('end_keep')),
                  ),
                  const SizedBox(height: 4),
                  TextButton(
                    onPressed: _endSession,
                    style: TextButton.styleFrom(
                      foregroundColor: FoquiColors.destructive,
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: Text(tr('end_confirm')),
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

class ShortSessionNote extends StatelessWidget {
  const ShortSessionNote({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: FoquiColors.grouped,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: FoquiColors.violet.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                CupertinoIcons.time,
                size: 18,
                color: FoquiColors.violet,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('end_short_title'),
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tr(
                      'end_short_body',
                      args: ['${minimumRecordedLength.inMinutes}'],
                    ),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                      height: 1.35,
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
