/// Global usernames. The stored form is the document id in `usernames`,
/// so a uniqueness check is one document read no matter how many people join.
abstract final class Username {
  static const minLength = 3;
  static const maxLength = 20;
  static const maxAliasLength = 40;

  static final format = RegExp(r'^[a-z][a-z0-9_]{2,19}$');

  static const reserved = <String>{
    'admin',
    'foqui',
    'help',
    'moderator',
    'official',
    'support',
    'system',
  };

  static String normalize(String raw) => raw.trim().toLowerCase();

  static bool isFormatValid(String normalized) => format.hasMatch(normalized);

  static bool isReserved(String normalized) => reserved.contains(normalized);

  static bool isValid(String normalized) =>
      isFormatValid(normalized) && !isReserved(normalized);

  static bool isAliasValid(String raw) {
    final alias = raw.trim();
    return alias.isNotEmpty && alias.length <= maxAliasLength;
  }
}
