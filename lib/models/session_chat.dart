/// How many messages a session chat keeps.
///
/// The chat is one document. Dropping older messages keeps that document
/// far under Firestore's size limit for a session that runs long.
const maxChatMessages = 200;

/// Longest message a person can send, in characters.
const maxChatMessageLength = 200;

class SessionChatMessage {
  const SessionChatMessage({
    required this.id,
    required this.uid,
    required this.name,
    required this.text,
    required this.at,
  });

  final String id;
  final String uid;
  final String name;
  final String text;
  final DateTime at;
}

/// Trimmed message text, or null when there is nothing to send.
String? chatMessageText(String raw) {
  final text = raw.trim();
  if (text.isEmpty || text.length > maxChatMessageLength) return null;
  return text;
}

/// [messages] followed by [message], keeping only the latest [maxChatMessages].
List<SessionChatMessage> appendChatMessage(
  List<SessionChatMessage> messages,
  SessionChatMessage message,
) {
  final next = [...messages, message];
  if (next.length <= maxChatMessages) return next;
  return next.sublist(next.length - maxChatMessages);
}

/// True when someone else has written since this device last opened the chat.
bool chatIsUnread({
  required DateTime? chatAt,
  required String? chatBy,
  required String userId,
  required DateTime? seenAt,
}) {
  if (chatAt == null || chatBy == null || chatBy.isEmpty || chatBy == userId) {
    return false;
  }
  if (seenAt == null) return true;
  return chatAt.isAfter(seenAt);
}

/// A sound for a message that arrived while this app is open and the chat
/// page is not.
bool chatShouldChime({
  required bool previousReady,
  required DateTime? previousAt,
  required DateTime nextAt,
  required String nextBy,
  required String userId,
  required bool chatVisible,
  required bool appResumed,
}) {
  if (!previousReady || chatVisible || !appResumed) return false;
  if (nextBy.isEmpty || nextBy == userId) return false;
  if (previousAt != null && !nextAt.isAfter(previousAt)) return false;
  return true;
}
