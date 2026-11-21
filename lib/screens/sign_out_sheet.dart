import 'package:flutter/material.dart';

import '../l10n/tr.dart';
import '../theme/app_theme.dart';
import '../widgets/sheet_header.dart';

/// Asks before signing out. A dismissed sheet keeps the person signed in.
Future<bool> showSignOutSheet(BuildContext context) {
  return showModalBottomSheet<bool>(
    context: context,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (context) => const SignOutSheet(),
  ).then((confirmed) => confirmed ?? false);
}

class SignOutSheet extends StatelessWidget {
  const SignOutSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        const SheetGrabber(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, kSheetBottomPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                tr('home_sign_out'),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                tr('home_sign_out_body'),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => Navigator.pop(context, false),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
                child: Text(tr('home_sign_out_stay')),
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(
                  foregroundColor: FoquiColors.destructive,
                  minimumSize: const Size.fromHeight(48),
                ),
                child: Text(tr('home_sign_out')),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
