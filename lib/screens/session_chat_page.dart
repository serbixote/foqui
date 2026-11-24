import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../l10n/tr.dart';
import '../models/session_chat.dart';
import '../repositories/invite.dart';
import '../state/auth.dart';
import '../state/focus_controller.dart';
import '../state/profile.dart';
import '../theme/app_theme.dart';
import '../widgets/sheet_header.dart';

const _uuid = Uuid();

/// Messages for the open session, inside the session sheet.
class SessionChatPage extends ConsumerStatefulWidget {
  const SessionChatPage({
    super.key,
    required this.sessionId,
    required this.onBack,
  });

  final String sessionId;
  final VoidCallback onBack;

  @override
  ConsumerState<SessionChatPage> createState() => _SessionChatPageState();
}

class _SessionChatPageState extends ConsumerState<SessionChatPage> {
  final TextEditingController _input = TextEditingController();
  final List<SessionChatMessage> _pending = [];

  @override
  void initState() {
    super.initState();
    _input.addListener(_onInput);
  }

  void _onInput() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _input.removeListener(_onInput);
    _input.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = chatMessageText(_input.text);
    if (text == null) return;
    final alias = Firebase.apps.isEmpty
        ? null
        : ref.read(userProfileProvider).asData?.value.alias;
    if (alias == null || alias.trim().isEmpty) return;
    final message = SessionChatMessage(
      id: _uuid.v4().replaceAll('-', ''),
      uid: ref.read(authProvider).userId ?? '',
      name: alias,
      text: text,
      at: DateTime.now(),
    );
    setState(() => _pending.add(message));
    _input.clear();
    try {
      final sent = await ref
          .read(focusControllerProvider.notifier)
          .sendSharedChat(text, id: message.id, at: message.at);
      if (!sent) _restore(message, text);
    } catch (error, stack) {
      debugPrint('Could not send the message: $error\n$stack');
      _restore(message, text);
    }
  }

  void _restore(SessionChatMessage message, String text) {
    if (!mounted) return;
    setState(() {
      _pending.remove(message);
      if (_input.text.isEmpty) _input.text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final userId = ref.watch(authProvider).userId ?? '';
    // Widget tests sign in without Firebase. The profile read needs it.
    final alias = Firebase.apps.isEmpty
        ? null
        : ref.watch(userProfileProvider).asData?.value.alias?.trim();
    final asyncMessages = ref.watch(sessionChatProvider(widget.sessionId));
    final stored = asyncMessages.asData?.value ?? const <SessionChatMessage>[];
    final storedIds = {for (final message in stored) message.id};
    if (_pending.any((message) => storedIds.contains(message.id))) {
      final confirmed = storedIds;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() {
          _pending.removeWhere((message) => confirmed.contains(message.id));
        });
      });
    }
    final messages = [
      ...stored,
      for (final message in _pending)
        if (!storedIds.contains(message.id)) message,
    ];
    final waiting =
        asyncMessages.isLoading && !asyncMessages.hasValue && messages.isEmpty;
    final draft = chatMessageText(_input.text);
    final canSend = draft != null && alias != null && alias.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SheetHeader(title: tr('session_chat'), onBack: widget.onBack),
        Expanded(
          child: waiting
              ? const Center(child: CircularProgressIndicator())
              : messages.isEmpty
              ? Center(
                  child: Text(
                    tr('session_chat_empty'),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                )
              : ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[messages.length - 1 - index];
                    return _Bubble(
                      message: message,
                      mine: message.uid == userId,
                      sent: storedIds.contains(message.id),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: _input,
                  minLines: 1,
                  maxLines: 4,
                  maxLength: maxChatMessageLength,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.send,
                  onSubmitted: canSend ? (_) => _send() : null,
                  style: theme.textTheme.bodyLarge,
                  cursorColor: scheme.primary,
                  decoration: InputDecoration(
                    hintText: tr('session_chat_hint'),
                    filled: true,
                    fillColor: FoquiColors.grouped,
                    counter: const SizedBox.shrink(),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                tooltip: tr('session_chat_send'),
                onPressed: canSend ? _send : null,
                icon: Icon(
                  CupertinoIcons.arrow_up_circle_fill,
                  size: 32,
                  color: canSend ? scheme.primary : scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.message,
    required this.mine,
    required this.sent,
  });

  final SessionChatMessage message;
  final bool mine;
  final bool sent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final time = TimeOfDay.fromDateTime(message.at.toLocal()).format(context);
    final bubble = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 280),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: mine
              ? scheme.primary.withValues(alpha: 0.28)
              : FoquiColors.grouped,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!mine)
                Text(
                  message.name,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              Text(message.text, style: theme.textTheme.bodyLarge),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    time,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  if (mine && sent) ...[
                    const SizedBox(width: 3),
                    Icon(
                      CupertinoIcons.checkmark,
                      size: 11,
                      color: scheme.onSurfaceVariant,
                      semanticLabel: tr('session_chat_sent'),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
        child: bubble,
      ),
    );
  }
}
