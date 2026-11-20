import '../l10n/tr.dart';

/// The block list every account has. It can be edited, not deleted.
const defaultBlockListId = 'default';

/// Stored name of [defaultBlockListId] before someone renames it.
const defaultBlockListName = 'Default';

/// A new account's block list. It starts as the preferred list.
BlockList defaultBlockList({bool isFavorite = true, DateTime? updatedAt}) {
  return BlockList(
    id: defaultBlockListId,
    name: defaultBlockListName,
    applicationCount: 0,
    categoryCount: 0,
    webDomainCount: 0,
    updatedAt: updatedAt ?? DateTime.now(),
    isFavorite: isFavorite,
  );
}

/// Inserts the account's block list when it is missing.
///
/// An existing preferred list keeps that role. Otherwise the new list is
/// the one new sessions and joins preselect.
List<BlockList> ensureDefaultBlockList(List<BlockList> lists) {
  if (lists.any((list) => list.id == defaultBlockListId)) return lists;
  final preferred = lists.any((list) => list.isFavorite);
  return [defaultBlockList(isFavorite: !preferred), ...lists];
}

/// Oldest first, so a list you just added stays at the bottom.
int compareBlockLists(BlockList a, BlockList b) {
  return a.updatedAt.compareTo(b.updatedAt);
}

/// The list a join preselects: the preferred one, when it has something to block.
String? preferredJoinListId(Iterable<BlockList> lists) {
  String? firstUsable;
  for (final list in lists) {
    if (list.isEmpty) continue;
    if (list.isFavorite) return list.id;
    firstUsable ??= list.id;
  }
  return firstUsable;
}

/// The name to show. The untouched default list follows the current language.
String blockListTitle({required String id, required String name}) {
  if (id == defaultBlockListId && name == defaultBlockListName) {
    return tr('list_default_name');
  }
  return name;
}

/// Keeps the default list's stored name canonical when it was not renamed.
String storedBlockListName({required String id, required String typed}) {
  final name = typed.trim();
  if (id == defaultBlockListId &&
      (name == defaultBlockListName || name == tr('list_default_name'))) {
    return defaultBlockListName;
  }
  return name;
}

class BlockList {
  const BlockList({
    required this.id,
    required this.name,
    required this.applicationCount,
    required this.categoryCount,
    required this.webDomainCount,
    required this.updatedAt,
    this.applicationNames = const [],
    this.isFavorite = false,
  });

  final String id;
  final String name;
  final int applicationCount;
  final int categoryCount;
  final int webDomainCount;
  final DateTime updatedAt;
  final List<String> applicationNames;

  /// The list preselected when a new session starts. At most one list is set.
  final bool isFavorite;

  int get selectionCount => applicationCount + categoryCount + webDomainCount;

  bool get isEmpty => selectionCount == 0;

  String get summary {
    if (isEmpty) return tr('count_nothing');
    final parts = <String>[
      if (applicationCount > 0)
        counted(applicationCount, one: 'count_one_app', many: 'count_apps'),
      if (categoryCount > 0)
        counted(
          categoryCount,
          one: 'count_one_category',
          many: 'count_categories',
        ),
      if (webDomainCount > 0)
        counted(
          webDomainCount,
          one: 'count_one_website',
          many: 'count_websites',
        ),
    ];
    return parts.join(' · ');
  }

  BlockList copyWith({
    String? name,
    int? applicationCount,
    int? categoryCount,
    int? webDomainCount,
    DateTime? updatedAt,
    List<String>? applicationNames,
    bool? isFavorite,
  }) {
    return BlockList(
      id: id,
      name: name ?? this.name,
      applicationCount: applicationCount ?? this.applicationCount,
      categoryCount: categoryCount ?? this.categoryCount,
      webDomainCount: webDomainCount ?? this.webDomainCount,
      updatedAt: updatedAt ?? this.updatedAt,
      applicationNames: applicationNames ?? this.applicationNames,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'applicationCount': applicationCount,
      'categoryCount': categoryCount,
      'webDomainCount': webDomainCount,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'applicationNames': applicationNames,
      'isFavorite': isFavorite,
    };
  }

  factory BlockList.fromJson(Map<String, dynamic> json) {
    final names = json['applicationNames'];
    return BlockList(
      id: json['id'] as String,
      name: json['name'] as String,
      applicationCount: json['applicationCount'] as int? ?? 0,
      categoryCount: json['categoryCount'] as int? ?? 0,
      webDomainCount: json['webDomainCount'] as int? ?? 0,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updatedAt'] as int),
      applicationNames: names is List
          ? [
              for (final name in names)
                if (name is String) name,
            ]
          : const [],
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }
}
