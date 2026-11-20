const aliasField = 'alias';
const usernameField = 'username';
const onboardedField = 'onboarded';
const usernameOwnerField = 'uid';

class UserProfile {
  const UserProfile({this.alias, this.username, this.onboarded = false});

  final String? alias;
  final String? username;
  final bool onboarded;

  factory UserProfile.fromMap(Map<String, dynamic>? data) {
    if (data == null) return const UserProfile();
    final alias = data[aliasField];
    final username = data[usernameField];
    return UserProfile(
      alias: alias is String && alias.isNotEmpty ? alias : null,
      username: username is String && username.isNotEmpty ? username : null,
      onboarded: data[onboardedField] == true,
    );
  }
}

class UsernameTaken implements Exception {
  const UsernameTaken();
}

class ProfileWriteException implements Exception {
  const ProfileWriteException({this.offline = false});

  final bool offline;
}
