import 'package:flutter_test/flutter_test.dart';
import 'package:foqui/data/label_emojis.dart';

void main() {
  test('each supported language can search the grinning face', () {
    const queries = {
      'en': 'grin',
      'de': 'grinsen',
      'es': 'sonrisa',
      'fr': 'sourire',
      'pt': 'rindo',
    };
    for (final entry in queries.entries) {
      final matches = matchingLabelEmojis(entry.key, entry.value, null);
      expect(
        matches.map((emoji) => emoji.emoji),
        contains('😀'),
        reason: entry.key,
      );
    }
  });

  test('an unknown language falls back to the english keywords', () {
    expect(
      matchingLabelEmojis('ja', 'grinning face', null).map((e) => e.emoji),
      contains('😀'),
    );
  });

  test('a saved icon outside the catalog stays visible with no query', () {
    final matches = matchingLabelEmojis('en', '', 'not-an-emoji');
    expect(matches.first.emoji, 'not-an-emoji');
    expect(
      matches.skip(1).map((emoji) => emoji.emoji),
      isNot(contains('not-an-emoji')),
    );
  });

  test('every query word has to match', () {
    expect(matchingLabelEmojis('en', 'grin zzzqqq', null), isEmpty);
  });
}
