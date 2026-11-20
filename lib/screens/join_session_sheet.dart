import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/tr.dart';
import '../models/block_list.dart';
import '../models/focus_session.dart';
import '../models/shared_session.dart';
import '../repositories/invite.dart';
import '../services/focus_shield_bridge.dart';
import '../state/focus_controller.dart';
import '../state/profile.dart';
import '../theme/app_theme.dart';
import '../widgets/sheet_header.dart';
import 'screen_time_sheet.dart';

Future<void> showJoinSessionSheet(
  BuildContext context, {
  required String code,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (context) => JoinSessionSheet(code: code),
  );
}

class JoinSessionSheet extends ConsumerStatefulWidget {
  const JoinSessionSheet({super.key, required this.code});

  final String code;

  @override
  ConsumerState<JoinSessionSheet> createState() => _JoinSessionSheetState();
}

class _JoinSessionSheetState extends ConsumerState<JoinSessionSheet> {
  SessionInvite? _invite;
  SharedSession? _shared;
  InviteProblem? _problem;
  var _loading = true;
  var _member = false;
  var _busy = false;
  String? _listId;

  @override
  void initState() {
    super.initState();
    Future<void>(() => _load());
  }

  Future<void> _load() async {
    final repository = ref.read(inviteRepositoryProvider);
    if (repository == null) {
      _fail(InviteProblem.failed);
      return;
    }
    try {
      final invite = await repository.fetchInvite(widget.code);
      if (!mounted) return;
      if (invite == null) {
        _fail(InviteProblem.missing);
        return;
      }
      final problem = problemWithInvite(invite, DateTime.now());
      if (problem != null) {
        _fail(problem);
        return;
      }
      final existing = await repository.readSession(invite.sessionId);
      if (!mounted) return;
      setState(() {
        _invite = invite;
        _shared = existing;
        _member = existing != null;
        _loading = false;
        _listId = _preferredListId();
      });
    } catch (error, stack) {
      debugPrint('Could not open the invitation: $error\n$stack');
      _fail(InviteProblem.failed);
    }
  }

  void _fail(InviteProblem problem) {
    if (!mounted) return;
    setState(() {
      _problem = problem;
      _loading = false;
    });
  }

  String? _preferredListId() {
    return preferredJoinListId(ref.read(focusControllerProvider).lists);
  }

  List<BlockList> _usableLists() {
    return [
      for (final list in ref.read(focusControllerProvider).lists)
        if (!list.isEmpty) list,
    ];
  }

  Future<void> _join() async {
    final invite = _invite;
    final repository = ref.read(inviteRepositoryProvider);
    final alias = ref.read(userProfileProvider).asData?.value.alias?.trim();
    if (invite == null ||
        repository == null ||
        alias == null ||
        alias.isEmpty) {
      _fail(InviteProblem.failed);
      return;
    }
    setState(() => _busy = true);
    try {
      try {
        await repository.join(invite: invite, name: alias);
      } on FirebaseException catch (error) {
        if (error.code != 'already-exists') rethrow;
      }
      final session = await repository.readSession(invite.sessionId);
      if (!mounted) return;
      setState(() {
        _shared = session ?? _shared;
        _member = true;
        _busy = false;
        _listId ??= _preferredListId();
      });
    } on FirebaseException catch (error, stack) {
      debugPrint('Could not join the session: $error\n$stack');
      _fail(
        error.code == 'permission-denied'
            ? InviteProblem.ended
            : InviteProblem.failed,
      );
    } catch (error, stack) {
      debugPrint('Could not join the session: $error\n$stack');
      _fail(InviteProblem.failed);
    }
  }

  Future<void> _start(SharedSession shared) async {
    final invite = _invite;
    final listId = _listId;
    if (invite == null || listId == null || _busy) return;
    setState(() => _busy = true);
    try {
      final started = await ref
          .read(focusControllerProvider.notifier)
          .startJoinedSession(
            listId: listId,
            shared: shared,
            inviteCode: invite.code,
          );
      if (!mounted) return;
      if (started) {
        Navigator.of(context).pop();
        return;
      }
      setState(() => _busy = false);
    } on FocusShieldException catch (error, stack) {
      debugPrint('Could not start the joined session: $error\n$stack');
      if (!mounted) return;
      setState(() => _busy = false);
      if (error.code == 'NOT_AUTHORIZED') {
        await showScreenTimeSheet(context);
      }
    } catch (error, stack) {
      debugPrint('Could not start the joined session: $error\n$stack');
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final invite = _invite;
    final watched = ref.watch(
      sharedSessionProvider(_member ? (invite?.sessionId ?? '') : ''),
    );
    final shared = watched.asData?.value ?? _shared;
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(bottom: kSheetBottomPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            const SheetGrabber(),
            SheetHeader(title: tr('invite_title')),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: _loading
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 48),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : _problem != null
                  ? _Message(text: _problemLabel(_problem!))
                  : _body(theme, invite!, shared),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(ThemeData theme, SessionInvite invite, SharedSession? shared) {
    final length = invite.durationMinutes == null
        ? tr('session_open')
        : formatSessionLength(Duration(minutes: invite.durationMinutes!));
    final focus = ref.watch(focusControllerProvider);
    final alreadyHere = _alreadyHere(focus, invite.sessionId);
    final blocked = focus.activeSession != null || focus.pausedSession != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          invite.labelEmoji == null
              ? invite.title
              : '${invite.labelEmoji}  ${invite.title}',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          tr('invite_from', args: [invite.hostName]),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          length,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 24),
        if (!_member)
          FilledButton(
            onPressed: _busy ? null : _join,
            child: Text(_busy ? tr('common_saving') : tr('invite_join')),
          )
        else if (alreadyHere)
          const _Message(textKey: 'invite_already')
        else if (shared == null || shared.isOver)
          _Message(text: tr('invite_ended'))
        else if (!shared.canStart)
          _Message(text: tr('invite_waiting'))
        else if (blocked)
          _Message(text: tr('invite_busy'))
        else
          _startBlock(shared),
      ],
    );
  }

  Widget _startBlock(SharedSession shared) {
    final lists = _usableLists();
    if (lists.isEmpty) return _Message(text: tr('invite_no_lists'));
    final selected = _listId ?? lists.first.id;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          tr('invite_choose_list'),
          style: Theme.of(context).textTheme.titleSmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        for (final list in lists) ...[
          _ListChoice(
            name: blockListTitle(id: list.id, name: list.name),
            detail: list.summary,
            selected: list.id == selected,
            onTap: _busy
                ? null
                : () {
                    HapticFeedback.selectionClick();
                    setState(() => _listId = list.id);
                  },
          ),
          const SizedBox(height: 8),
        ],
        const SizedBox(height: 8),
        FilledButton(
          onPressed: _busy ? null : () => _start(shared),
          child: Text(_busy ? tr('common_saving') : tr('session_start_focus')),
        ),
      ],
    );
  }

  bool _alreadyHere(FocusState focus, String sessionId) {
    for (final session in focus.sessions) {
      if (session.sharedSessionId != sessionId) continue;
      switch (session.outcome) {
        case SessionOutcome.created:
        case SessionOutcome.active:
        case SessionOutcome.paused:
          return true;
        case SessionOutcome.completed:
        case SessionOutcome.endedEarly:
          continue;
      }
    }
    return false;
  }
}

String _problemLabel(InviteProblem problem) {
  switch (problem) {
    case InviteProblem.missing:
      return tr('invite_missing');
    case InviteProblem.revoked:
      return tr('invite_revoked');
    case InviteProblem.expired:
      return tr('invite_expired');
    case InviteProblem.ended:
      return tr('invite_ended');
    case InviteProblem.failed:
      return tr('invite_failed');
  }
}

class _Message extends StatelessWidget {
  const _Message({this.text, this.textKey})
    : assert(text != null || textKey != null);

  final String? text;
  final String? textKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text ?? tr(textKey!),
        style: theme.textTheme.bodyLarge?.copyWith(height: 1.35),
      ),
    );
  }
}

class _ListChoice extends StatelessWidget {
  const _ListChoice({
    required this.name,
    required this.detail,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final String detail;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: FoquiColors.grouped,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Icon(
                selected
                    ? CupertinoIcons.checkmark_circle_fill
                    : CupertinoIcons.circle,
                size: 22,
                color: selected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      detail,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
