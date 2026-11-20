import 'dart:async';
import 'dart:io' show Platform;

import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/shared_session.dart';
import '../screens/join_session_sheet.dart';
import 'auth.dart';
import 'profile.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class PendingInvite {
  const PendingInvite({required this.code, required this.id});

  final String code;
  final int id;
}

class PendingInviteController extends Notifier<PendingInvite?> {
  @override
  PendingInvite? build() => null;

  void remember(String code) {
    state = PendingInvite(code: code, id: (state?.id ?? 0) + 1);
  }
}

final pendingInviteProvider =
    NotifierProvider<PendingInviteController, PendingInvite?>(
      PendingInviteController.new,
    );

/// True once a signed-in, onboarded person can open the join sheet.
final inviteReadyProvider = Provider<bool>((ref) {
  final pending = ref.watch(pendingInviteProvider);
  final auth = ref.watch(authProvider);
  if (pending == null || Firebase.apps.isEmpty || !auth.isLoggedIn) {
    return false;
  }
  final profile = ref.watch(userProfileProvider);
  return destinationFor(profile) == SignedInDestination.ready;
});

/// Listens for `/join/{code}` links and opens the preview after sign-in.
class InviteLinkBinding extends ConsumerStatefulWidget {
  const InviteLinkBinding({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<InviteLinkBinding> createState() => _InviteLinkBindingState();
}

class _InviteLinkBindingState extends ConsumerState<InviteLinkBinding> {
  StreamSubscription<Uri>? _subscription;
  var _showing = false;
  String? _shownCode;
  DateTime? _shownAt;

  @override
  void initState() {
    super.initState();
    if (Platform.environment.containsKey('FLUTTER_TEST')) return;
    unawaited(_listen());
  }

  Future<void> _listen() async {
    try {
      final links = AppLinks();
      final initial = await links.getInitialLink();
      _remember(initial);
      _subscription = links.uriLinkStream.listen(_remember);
    } catch (error, stack) {
      debugPrint('Invite links are unavailable: $error\n$stack');
    }
  }

  void _remember(Uri? uri) {
    if (!mounted || uri == null) return;
    final code = inviteCodeFromUri(uri);
    if (code == null) return;
    ref.read(pendingInviteProvider.notifier).remember(code);
  }

  void _maybePresent() {
    if (_showing || !ref.read(inviteReadyProvider)) return;
    final pending = ref.read(pendingInviteProvider);
    if (pending == null) return;
    final shownAt = _shownAt;
    if (_shownCode == pending.code &&
        shownAt != null &&
        DateTime.now().difference(shownAt) < const Duration(seconds: 2)) {
      return;
    }
    unawaited(_present(pending));
  }

  Future<void> _present(PendingInvite invite) async {
    _showing = true;
    _shownCode = invite.code;
    _shownAt = DateTime.now();
    try {
      final ready = await _whenNavigatorReady();
      if (!ready) return;
      final context = rootNavigatorKey.currentContext;
      if (context == null || !context.mounted) return;
      await showJoinSessionSheet(context, code: invite.code);
    } finally {
      _showing = false;
    }
  }

  Future<bool> _whenNavigatorReady() async {
    for (var attempt = 0; attempt < 10; attempt++) {
      if (!mounted) return false;
      if (rootNavigatorKey.currentContext != null) return true;
      await Future<void>.delayed(const Duration(milliseconds: 50));
    }
    return rootNavigatorKey.currentContext != null;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(inviteReadyProvider, (previous, next) {
      if (next) _maybePresent();
    });
    ref.listen(pendingInviteProvider, (previous, next) {
      if (next != null) _maybePresent();
    });
    return widget.child;
  }
}
