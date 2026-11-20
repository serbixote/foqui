import 'package:characters/characters.dart';

import '../l10n/tr.dart';

/// Uppercases the first letter and leaves the rest of the name as written.
String capitalizeLabelName(String name) {
  final trimmed = name.trim();
  if (trimmed.isEmpty) return trimmed;
  final characters = trimmed.characters;
  return characters.first.toUpperCase() + characters.skip(1).string;
}

/// The label sessions fall back to when another label is deleted.
const focusTimeLabelId = 'focus-time';

/// A name a focus session can wear.
class FocusLabel {
  const FocusLabel({
    required this.id,
    required this.emoji,
    required this.name,
    required this.createdAt,
    this.deleted = false,
  });

  final String id;
  final String emoji;
  final String name;
  final DateTime createdAt;

  /// A removed built-in label. Kept so it does not reappear from the defaults.
  final bool deleted;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emoji': emoji,
      'name': name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      if (deleted) 'deleted': true,
    };
  }

  factory FocusLabel.fromJson(Map<String, dynamic> json) {
    return FocusLabel(
      id: json['id'] as String,
      emoji: json['emoji'] as String,
      name: json['name'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      deleted: json['deleted'] as bool? ?? false,
    );
  }
}

/// True for a label every account starts with. Those stay fixed.
bool isBuiltInLabel(String id) {
  for (final label in kBuiltInFocusLabels) {
    if (label.id == id) return true;
  }
  return false;
}

/// Labels every account starts with. New ones are stored after these.
final kBuiltInFocusLabels = [
  FocusLabel(
    id: focusTimeLabelId,
    emoji: '🎯',
    name: 'Focus Time',
    createdAt: _builtIn,
  ),
  FocusLabel(
    id: 'study-session',
    emoji: '📚',
    name: 'Study session',
    createdAt: _builtIn,
  ),
  FocusLabel(
    id: 'deep-work',
    emoji: '🧠',
    name: 'Deep work',
    createdAt: _builtIn,
  ),
  FocusLabel(
    id: 'couple-time',
    emoji: '💛',
    name: 'Couple time',
    createdAt: _builtIn,
  ),
  FocusLabel(
    id: 'family-time',
    emoji: '🏡',
    name: 'Family time',
    createdAt: _builtIn,
  ),
];

final _builtIn = DateTime.utc(2026, 1, 1);

const builtInLabelKeys = {
  focusTimeLabelId: 'label_focus_time',
  'study-session': 'label_study',
  'deep-work': 'label_deep_work',
  'couple-time': 'label_couple',
  'family-time': 'label_family',
};

/// Built-in names follow the current language. A renamed or custom label stays
/// as it was saved.
String localizedLabelName({String? id, String? name}) {
  final key = id == null ? null : builtInLabelKeys[id];
  if (key == null) return name ?? tr('session_focus_fallback');
  final canonical = kBuiltInFocusLabels
      .firstWhere((label) => label.id == id)
      .name;
  if (name != null && name != canonical) return name;
  return tr(key);
}
