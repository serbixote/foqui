import 'package:flutter_test/flutter_test.dart';
import 'package:foqui/models/focus_session.dart';
import 'package:foqui/models/shared_session.dart';

void main() {
  test('an invite link yields its code', () {
    const code = '0123456789abcdef0123456789abcdef';
    expect(
      inviteCodeFromUri(
        Uri.parse('https://foqui.theboringbuilders.xyz/join/$code'),
      ),
      code,
    );
    expect(
      inviteCodeFromUri(
        Uri.parse('https://foqui.theboringbuilders.xyz/join/$code/'),
      ),
      code,
    );
    expect(
      inviteCodeFromUri(
        Uri.parse(
          'https://FOQUI.THEBORINGBUILDERS.XYZ/join/${code.toUpperCase()}',
        ),
      ),
      code,
    );
    expect(
      inviteCodeFromUri(Uri.parse('https://foqui.app/join/$code')),
      isNull,
    );
    expect(
      inviteCodeFromUri(
        Uri.parse('https://foqui.theboringbuilders.xyz/join/short'),
      ),
      isNull,
    );
    expect(inviteUrl(code), 'https://foqui.theboringbuilders.xyz/join/$code');
  });

  test('a running session expires when it ends', () {
    final now = DateTime(2026, 1, 1, 10);
    final endsAt = now.add(const Duration(minutes: 25));
    expect(
      sharedExpiry(
        now: now,
        status: SharedSessionStatus.active,
        endsAt: endsAt,
      ),
      endsAt,
    );
    expect(
      sharedExpiry(
        now: now,
        status: SharedSessionStatus.waiting,
        endsAt: endsAt,
      ),
      now.add(sharedInviteLifetime),
    );
    expect(
      sharedExpiry(now: now, status: SharedSessionStatus.active, endsAt: null),
      now.add(sharedInviteLifetime),
    );
  });

  test('a revoked or expired invite cannot be used', () {
    final now = DateTime(2026, 1, 1, 10);
    final invite = SessionInvite(
      code: '0123456789abcdef0123456789abcdef',
      sessionId: 'session',
      createdBy: 'host',
      hostName: 'Ada',
      title: 'Deep work',
      labelEmoji: '🧠',
      durationMinutes: 25,
      createdAt: now,
      expiresAt: now.add(const Duration(hours: 1)),
      revoked: false,
    );
    expect(problemWithInvite(invite, now), isNull);
    expect(
      problemWithInvite(
        SessionInvite(
          code: invite.code,
          sessionId: invite.sessionId,
          createdBy: invite.createdBy,
          hostName: invite.hostName,
          title: invite.title,
          labelEmoji: invite.labelEmoji,
          durationMinutes: invite.durationMinutes,
          createdAt: invite.createdAt,
          expiresAt: invite.expiresAt,
          revoked: true,
        ),
        now,
      ),
      InviteProblem.revoked,
    );
    expect(
      problemWithInvite(invite, now.add(const Duration(hours: 2))),
      InviteProblem.expired,
    );
  });

  test('shared fields round-trip on a local session', () {
    final session = FocusSession(
      id: 'session',
      blockListId: 'deep',
      blockListName: 'Deep work',
      startedAt: DateTime(2026, 1, 1, 10),
      endsAt: DateTime(2026, 1, 1, 10, 25),
      outcome: SessionOutcome.active,
      sharedSessionId: 'room',
      inviteCode: '0123456789abcdef0123456789abcdef',
      sharedHost: true,
    );
    final restored = FocusSession.fromJson(session.toJson());
    expect(restored.sharedSessionId, 'room');
    expect(restored.inviteCode, session.inviteCode);
    expect(restored.sharedHost, isTrue);
    expect(restored.chatEnabled, isFalse);
    expect(
      FocusSession.fromJson(session.copyWith(chatEnabled: true).toJson())
          .chatEnabled,
      isTrue,
    );
    expect(sharedDurationMinutes(session), 25);
    expect(sharedTitleOf(null, fallback: 'Focus'), 'Focus');
    expect(sharedTitleOf('Deep work', fallback: 'Focus'), 'Deep work');
    expect(memberLabel('Ada', 'ada'), 'Ada (ada)');
    expect(memberLabel('Ada', '  '), 'Ada');
    expect(memberLabel('Ada', null), 'Ada');
    expect(
      sharedStatusFor(SessionOutcome.created),
      SharedSessionStatus.waiting,
    );
    expect(sharedStatusFor(SessionOutcome.paused), SharedSessionStatus.active);
    final waiting = FocusSession(
      id: 'waiting',
      blockListId: 'deep',
      blockListName: 'Deep work',
      startedAt: DateTime(2026, 1, 1, 8),
      endsAt: DateTime(2026, 1, 1, 8, 25),
      outcome: SessionOutcome.created,
    );
    expect(sharedRoomStartedAt(waiting), isNull);
    expect(sharedRoomEndsAt(waiting), isNull);
    expect(sharedDurationMinutes(waiting), 25);
    expect(sharedRoomStartedAt(session), session.startedAt);
    expect(sharedRoomEndsAt(session), session.endsAt);
  });

  test('a pause starts only after every member accepts', () {
    const ada = SessionParticipant(uid: 'ada', name: 'Ada', joinedAt: null);
    const bea = SessionParticipant(uid: 'bea', name: 'Bea', joinedAt: null);
    const request = PauseRequest(
      requestedBy: 'ada',
      requestedName: 'Ada',
      createdAt: null,
      accepted: {'ada': true},
    );
    expect(pauseRequestAcceptedByAll(request, const [ada]), isFalse);
    expect(pauseRequestAcceptedByAll(request, const [ada, bea]), isFalse);
    expect(
      pauseRequestAcceptedByAll(
        const PauseRequest(
          requestedBy: 'ada',
          requestedName: 'Ada',
          createdAt: null,
          accepted: {'ada': true, 'bea': true},
        ),
        const [ada, bea],
      ),
      isTrue,
    );
  });
}
