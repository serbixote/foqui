import 'label_emoji_catalog.dart';

/// One emoji the label picker can show and search.
class LabelEmoji {
  const LabelEmoji(this.emoji, this.keywords);

  final String emoji;

  /// Lowercase words used by search. A query token matches when it is
  /// contained in any of these words.
  final List<String> keywords;
}

final _byLanguage = <String, List<LabelEmoji>>{};

/// Emojis for [languageCode], falling back to English.
List<LabelEmoji> labelEmojisFor(String languageCode) {
  return _byLanguage.putIfAbsent(languageCode, () {
    final catalog = labelEmojiCatalog[languageCode] ?? labelEmojiCatalog['en']!;
    final seen = <String>{};
    final emojis = <LabelEmoji>[];
    for (final line in catalog.split('\n')) {
      if (line.isEmpty) continue;
      final separator = line.indexOf('|');
      if (separator <= 0) continue;
      final emoji = line.substring(0, separator);
      if (!seen.add(emoji)) continue;
      emojis.add(
        LabelEmoji(emoji, [
          for (final word in line.substring(separator + 1).split('|'))
            if (word.isNotEmpty) word.toLowerCase(),
        ]),
      );
    }
    return emojis;
  });
}

/// Emojis whose keywords contain every whitespace-separated token in [query].
///
/// An empty query returns the full list. When that list does not already
/// contain [current], it is placed first so an existing label icon stays
/// visible.
List<LabelEmoji> matchingLabelEmojis(
  String languageCode,
  String query,
  String? current,
) {
  final all = labelEmojisFor(languageCode);
  final tokens = query
      .trim()
      .toLowerCase()
      .split(RegExp(r'\s+'))
      .where((token) => token.isNotEmpty)
      .toList();
  final matches = tokens.isEmpty
      ? all
      : [
          for (final emoji in all)
            if (_matches(emoji, tokens)) emoji,
        ];
  if (tokens.isEmpty &&
      current != null &&
      current.isNotEmpty &&
      !matches.any((emoji) => emoji.emoji == current)) {
    return [LabelEmoji(current, const []), ...matches];
  }
  return matches;
}

bool _matches(LabelEmoji emoji, List<String> tokens) {
  return tokens.every(
    (token) => emoji.keywords.any((word) => word.contains(token)),
  );
}
