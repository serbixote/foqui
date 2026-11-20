import '../l10n/tr.dart';

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
