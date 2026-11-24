import 'package:flutter_riverpod/flutter_riverpod.dart';

/// When this device last opened each room's chat. Kept on the phone so
/// reading messages does not write to Firestore.
class ChatSeen extends Notifier<Map<String, DateTime>> {
  @override
  Map<String, DateTime> build() => {};

  void mark(String sessionId, DateTime at) {
    if (sessionId.isEmpty) return;
    final current = state[sessionId];
    if (current != null && !at.isAfter(current)) return;
    state = {...state, sessionId: at};
  }
}

final chatSeenProvider = NotifierProvider<ChatSeen, Map<String, DateTime>>(
  ChatSeen.new,
);
