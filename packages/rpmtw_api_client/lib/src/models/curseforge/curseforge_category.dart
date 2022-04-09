import 'dart:convert';

class CurseForgeCategory {
  final int id;
  final int gameId;
  final String name;
  final String? slug;
  final String? url;
  final String iconUrl;
  final String dateModified;
  final bool? isClass;
  final int? classId;
  final int? parentCategoryId;
  const CurseForgeCategory({
    required this.id,
    required this.gameId,
    required this.name,
    required this.slug,
    required this.url,
    required this.iconUrl,
    required this.dateModified,
    required this.isClass,
    required this.classId,
    required this.parentCategoryId,
  });

  CurseForgeCategory copyWith({
    int? id,
    int? gameId,
    String? name,
    String? slug,
    String? url,
    String? iconUrl,
    String? dateModified,
    bool? isClass,
    int? classId,
    int? parentCategoryId,
  }) {
    return CurseForgeCategory(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      url: url ?? this.url,
      iconUrl: iconUrl ?? this.iconUrl,
      dateModified: dateModified ?? this.dateModified,
      isClass: isClass ?? this.isClass,
      classId: classId ?? this.classId,
      parentCategoryId: parentCategoryId ?? this.parentCategoryId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gameId': gameId,
      'name': name,
      'slug': slug,
      'url': url,
      'iconUrl': iconUrl,
      'dateModified': dateModified,
      'isClass': isClass,
      'classId': classId,
      'parentCategoryId': parentCategoryId,
    };
  }

  factory CurseForgeCategory.fromMap(Map<String, dynamic> map) {
    return CurseForgeCategory(
      id: map['id'],
      gameId: map['gameId'],
      name: map['name'],
      slug: map['slug'],
      url: map['url'],
      iconUrl: map['iconUrl'],
      dateModified: map['dateModified'],
      isClass: map['isClass'],
      classId: map['classId'],
      parentCategoryId: map['parentCategoryId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeCategory.fromJson(String source) =>
      CurseForgeCategory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CurseForgeModCategory(id: $id, gameId: $gameId, name: $name, slug: $slug, url: $url, iconUrl: $iconUrl, dateModified: $dateModified, isClass: $isClass, classId: $classId, parentCategoryId: $parentCategoryId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurseForgeCategory &&
        other.id == id &&
        other.gameId == gameId &&
        other.name == name &&
        other.slug == slug &&
        other.url == url &&
        other.iconUrl == iconUrl &&
        other.dateModified == dateModified &&
        other.isClass == isClass &&
        other.classId == classId &&
        other.parentCategoryId == parentCategoryId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        gameId.hashCode ^
        name.hashCode ^
        slug.hashCode ^
        url.hashCode ^
        iconUrl.hashCode ^
        dateModified.hashCode ^
        isClass.hashCode ^
        classId.hashCode ^
        parentCategoryId.hashCode;
  }
}
