import 'focus_session.dart';
import 'session_duration.dart';

const inviteHost = 'foqui.theboringbuilders.xyz';

/// How long a link stays usable when the session has no fixed end yet.
const sharedInviteLifetime = Duration(hours: 24);

const _inviteCodePattern = r'^[0-9a-f]{32}$';
final _inviteCode = RegExp(_inviteCodePattern);

enum SharedSessionStatus { waiting, active, ended }

class SharedSession {
  const SharedSession({
    required this.id,
    required this.hostId,
    required this.hostName,
    required this.title,
    required this.labelEmoji,
    required this.durationMinutes,
    required this.status,
    required this.startedAt,
    required this.endsAt,
    required this.createdAt,
    required this.expiresAt,
  });

  final String id;
  final String hostId;
  final String hostName;
  final String title;
  final String? labelEmoji;
  final int? durationMinutes;
  final SharedSessionStatus status;
  final DateTime? startedAt;
  final DateTime? endsAt;
  final DateTime? createdAt;
  final DateTime expiresAt;

  bool get isOver =>
      status == SharedSessionStatus.ended || !expiresAt.isAfter(DateTime.now());

  bool get canStart =>
      status == SharedSessionStatus.active &&
      (endsAt == null || endsAt!.isAfter(DateTime.now()));
}

class SessionInvite {
  const SessionInvite({
    required this.code,
    required this.sessionId,
    required this.createdBy,
    required this.hostName,
    required this.title,
    required this.labelEmoji,
    required this.durationMinutes,
    required this.createdAt,
    required this.expiresAt,
    required this.revoked,
  });

  final String code;
  final String sessionId;
  final String createdBy;
  final String hostName;
  final String title;
  final String? labelEmoji;
  final int? durationMinutes;
  final DateTime? createdAt;
  final DateTime expiresAt;
  final bool revoked;

  String get url => inviteUrl(code);
}

class SessionParticipant {
  const SessionParticipant({
    required this.uid,
    required this.name,
    required this.joinedAt,
    this.username,
  });

  final String uid;

  /// Alias shown for this member.
  final String name;
  final DateTime? joinedAt;

  /// Account username, without a leading @.
  final String? username;
}

/// Alias, with the username in parentheses when the room has one.
String memberLabel(String alias, String? username) {
  final handle = username?.trim();
  if (handle == null || handle.isEmpty) return alias;
  return '$alias ($handle)';
}

/// A pause the group has been asked to accept.
///
/// [accepted] includes the person who asked. The pause starts once every
/// current member is in that map.
class PauseRequest {
  const PauseRequest({
    required this.requestedBy,
    required this.requestedName,
    required this.createdAt,
    required this.accepted,
  });

  final String requestedBy;
  final String requestedName;
  final DateTime? createdAt;
  final Map<String, bool> accepted;

  bool hasAccepted(String uid) => accepted[uid] == true;
}

/// True when every current member has accepted [request].
///
/// A room of one does not use a group pause.
bool pauseRequestAcceptedByAll(
  PauseRequest request,
  List<SessionParticipant> members,
) {
  if (members.length < 2) return false;
  for (final member in members) {
    if (!request.hasAccepted(member.uid)) return false;
  }
  return true;
}

class CreatedInvite {
  const CreatedInvite({required this.sessionId, required this.code});

  final String sessionId;
  final String code;

  String get url => inviteUrl(code);
}

enum InviteProblem { missing, revoked, expired, ended, failed }

String inviteUrl(String code) => 'https://$inviteHost/join/$code';

String? inviteCodeFromUri(Uri uri) {
  if (uri.scheme != 'https' || uri.host.toLowerCase() != inviteHost) {
    return null;
  }
  final segments = [
    for (final part in uri.pathSegments)
      if (part.isNotEmpty) part,
  ];
  if (segments.length != 2 || segments.first != 'join') return null;
  final code = segments[1].toLowerCase();
  if (!_inviteCode.hasMatch(code)) return null;
  return code;
}

bool validInviteCode(String code) => _inviteCode.hasMatch(code);

SharedSessionStatus sharedStatusFor(SessionOutcome outcome) {
  switch (outcome) {
    case SessionOutcome.created:
      return SharedSessionStatus.waiting;
    case SessionOutcome.active:
    case SessionOutcome.paused:
      return SharedSessionStatus.active;
    case SessionOutcome.completed:
    case SessionOutcome.endedEarly:
      return SharedSessionStatus.ended;
  }
}

int? sharedDurationMinutes(FocusSession session) {
  final end = session.endsAt;
  if (end == null) return null;
  final minutes = end.difference(session.startedAt).inMinutes;
  if (minutes < minSessionMinutes || minutes > maxSessionMinutes) return null;
  return minutes;
}

/// Start time stored on the shared room.
///
/// A session that has not been started keeps a local start only so the planned
/// length can be measured. That clock has not begun. Writing it would make the
/// room look underway, and a start that is no longer "now" is rejected.
DateTime? sharedRoomStartedAt(FocusSession session) {
  if (session.outcome == SessionOutcome.created) return null;
  return session.startedAt;
}

/// End time stored on the shared room.
///
/// Same as [sharedRoomStartedAt]: the local end of a session that has not
/// started is the planned length, not a deadline. An end that is already past
/// is rejected, so the share button would do nothing.
DateTime? sharedRoomEndsAt(FocusSession session) {
  if (session.outcome == SessionOutcome.created) return null;
  return session.endsAt;
}

/// Active sessions expire when they end. Waiting and open ones last a day.
DateTime sharedExpiry({
  required DateTime now,
  required SharedSessionStatus status,
  DateTime? endsAt,
}) {
  if (status == SharedSessionStatus.active && endsAt != null) return endsAt;
  return now.add(sharedInviteLifetime);
}

String sharedTitleOf(String? name, {required String fallback}) {
  final trimmed = name?.trim();
  final title = (trimmed == null || trimmed.isEmpty) ? fallback : trimmed;
  if (title.length <= 80) return title;
  return title.substring(0, 80);
}

String? sharedEmojiOf(String? emoji) {
  final trimmed = emoji?.trim();
  if (trimmed == null || trimmed.isEmpty) return null;
  if (trimmed.length <= 32) return trimmed;
  return trimmed.substring(0, 32);
}

InviteProblem? problemWithInvite(SessionInvite invite, DateTime now) {
  if (invite.revoked) return InviteProblem.revoked;
  if (!invite.expiresAt.isAfter(now)) return InviteProblem.expired;
  return null;
}

SharedSessionStatus sharedStatusFrom(String? raw) {
  for (final status in SharedSessionStatus.values) {
    if (status.name == raw) return status;
  }
  return SharedSessionStatus.ended;
}
