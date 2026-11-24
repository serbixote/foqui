import 'package:flutter_test/flutter_test.dart';
import 'package:foqui/models/session_chat.dart';

void main() {
  test('a chat keeps the latest 200 messages', () {
    final kept = List.generate(
      maxChatMessages,
      (index) => SessionChatMessage(
        id: '$index',
        uid: 'ada',
        name: 'Ada',
        text: 'note $index',
        at: DateTime.utc(2026, 1, 1, 10, index ~/ 60, index % 60),
      ),
    );
    final added = SessionChatMessage(
      id: 'new',
      uid: 'marco',
      name: 'Marco',
      text: 'here',
      at: DateTime.utc(2026, 1, 1, 12),
    );

    final next = appendChatMessage(kept, added);

    expect(next, hasLength(maxChatMessages));
    expect(next.first.id, '1');
    expect(next.last.id, 'new');
    expect(chatMessageText('  hello  '), 'hello');
    expect(chatMessageText('   '), isNull);
    expect(chatMessageText('a' * (maxChatMessageLength + 1)), isNull);
  });

  test('a red dot is for someone else, after this device last looked', () {
    final at = DateTime.utc(2026, 1, 1, 10);
    expect(
      chatIsUnread(chatAt: at, chatBy: 'ada', userId: 'marco', seenAt: null),
      isTrue,
    );
    expect(
      chatIsUnread(chatAt: at, chatBy: 'marco', userId: 'marco', seenAt: null),
      isFalse,
    );
    expect(
      chatIsUnread(chatAt: at, chatBy: 'ada', userId: 'marco', seenAt: at),
      isFalse,
    );
    expect(
      chatIsUnread(
        chatAt: at.add(const Duration(seconds: 1)),
        chatBy: 'ada',
        userId: 'marco',
        seenAt: at,
      ),
      isTrue,
    );
  });

  test('a chime plays only for a new message while the app is open', () {
    final at = DateTime.utc(2026, 1, 1, 10);
    expect(
      chatShouldChime(
        previousReady: true,
        previousAt: at,
        nextAt: at.add(const Duration(seconds: 1)),
        nextBy: 'ada',
        userId: 'marco',
        chatVisible: false,
        appResumed: true,
      ),
      isTrue,
    );
    expect(
      chatShouldChime(
        previousReady: false,
        previousAt: null,
        nextAt: at,
        nextBy: 'ada',
        userId: 'marco',
        chatVisible: false,
        appResumed: true,
      ),
      isFalse,
    );
    expect(
      chatShouldChime(
        previousReady: true,
        previousAt: at,
        nextAt: at.add(const Duration(seconds: 1)),
        nextBy: 'ada',
        userId: 'marco',
        chatVisible: true,
        appResumed: true,
      ),
      isFalse,
    );
    expect(
      chatShouldChime(
        previousReady: true,
        previousAt: at,
        nextAt: at.add(const Duration(seconds: 1)),
        nextBy: 'marco',
        userId: 'marco',
        chatVisible: false,
        appResumed: true,
      ),
      isFalse,
    );
    expect(
      chatShouldChime(
        previousReady: true,
        previousAt: at,
        nextAt: at.add(const Duration(seconds: 1)),
        nextBy: 'ada',
        userId: 'marco',
        chatVisible: false,
        appResumed: false,
      ),
      isFalse,
    );
  });
}
