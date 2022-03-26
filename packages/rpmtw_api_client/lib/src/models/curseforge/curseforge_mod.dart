import "dart:convert";

import "package:collection/collection.dart";

class CurseForgeMod {
  final int id;
  final int gameId;
  final String name;
  final String slug;
  final CurseForgeModLinks links;
  final String summary;
  final int status;
  final int downloadCount;
  final bool isFeatured;
  final int primaryCategoryId;
  final List<CurseForgeModCategorie> categories;
  final int classId;
  final List<CurseForgeModAuthor> authors;
  final CurseForgeModLogo logo;
  final List<CurseForgeModScreenshot> screenshots;
  final int mainFileId;
  final List<CurseForgeModLatestFile> latestFiles;
  final List<CurseForgeModLatestFilesIndexe> latestFilesIndexes;
  final String dateCreated;
  final String dateModified;
  final String dateReleased;
  final bool allowModDistribution;
  final int gamePopularityRank;
  CurseForgeMod({
    required this.id,
    required this.gameId,
    required this.name,
    required this.slug,
    required this.links,
    required this.summary,
    required this.status,
    required this.downloadCount,
    required this.isFeatured,
    required this.primaryCategoryId,
    required this.categories,
    required this.classId,
    required this.authors,
    required this.logo,
    required this.screenshots,
    required this.mainFileId,
    required this.latestFiles,
    required this.latestFilesIndexes,
    required this.dateCreated,
    required this.dateModified,
    required this.dateReleased,
    required this.allowModDistribution,
    required this.gamePopularityRank,
  });

  CurseForgeMod copyWith({
    int? id,
    int? gameId,
    String? name,
    String? slug,
    CurseForgeModLinks? links,
    String? summary,
    int? status,
    int? downloadCount,
    bool? isFeatured,
    int? primaryCategoryId,
    List<CurseForgeModCategorie>? categories,
    int? classId,
    List<CurseForgeModAuthor>? authors,
    CurseForgeModLogo? logo,
    List<CurseForgeModScreenshot>? screenshots,
    int? mainFileId,
    List<CurseForgeModLatestFile>? latestFiles,
    List<CurseForgeModLatestFilesIndexe>? latestFilesIndexes,
    String? dateCreated,
    String? dateModified,
    String? dateReleased,
    bool? allowModDistribution,
    int? gamePopularityRank,
  }) {
    return CurseForgeMod(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      links: links ?? this.links,
      summary: summary ?? this.summary,
      status: status ?? this.status,
      downloadCount: downloadCount ?? this.downloadCount,
      isFeatured: isFeatured ?? this.isFeatured,
      primaryCategoryId: primaryCategoryId ?? this.primaryCategoryId,
      categories: categories ?? this.categories,
      classId: classId ?? this.classId,
      authors: authors ?? this.authors,
      logo: logo ?? this.logo,
      screenshots: screenshots ?? this.screenshots,
      mainFileId: mainFileId ?? this.mainFileId,
      latestFiles: latestFiles ?? this.latestFiles,
      latestFilesIndexes: latestFilesIndexes ?? this.latestFilesIndexes,
      dateCreated: dateCreated ?? this.dateCreated,
      dateModified: dateModified ?? this.dateModified,
      dateReleased: dateReleased ?? this.dateReleased,
      allowModDistribution: allowModDistribution ?? this.allowModDistribution,
      gamePopularityRank: gamePopularityRank ?? this.gamePopularityRank,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "gameId": gameId,
      "name": name,
      "slug": slug,
      "links": links.toMap(),
      "summary": summary,
      "status": status,
      "downloadCount": downloadCount,
      "isFeatured": isFeatured,
      "primaryCategoryId": primaryCategoryId,
      "categories": categories.map((x) => x.toMap()).toList(),
      "classId": classId,
      "authors": authors.map((x) => x.toMap()).toList(),
      "logo": logo.toMap(),
      "screenshots": screenshots.map((x) => x.toMap()).toList(),
      "mainFileId": mainFileId,
      "latestFiles": latestFiles.map((x) => x.toMap()).toList(),
      "latestFilesIndexes": latestFilesIndexes.map((x) => x.toMap()).toList(),
      "dateCreated": dateCreated,
      "dateModified": dateModified,
      "dateReleased": dateReleased,
      "allowModDistribution": allowModDistribution,
      "gamePopularityRank": gamePopularityRank,
    };
  }

  factory CurseForgeMod.fromMap(Map<String, dynamic> map) {
    return CurseForgeMod(
      id: map["id"]?.toInt() ?? 0,
      gameId: map["gameId"]?.toInt() ?? 0,
      name: map["name"] ?? "",
      slug: map["slug"] ?? "",
      links: CurseForgeModLinks.fromMap(map["links"]),
      summary: map["summary"] ?? "",
      status: map["status"]?.toInt() ?? 0,
      downloadCount: map["downloadCount"]?.toInt() ?? 0,
      isFeatured: map["isFeatured"] ?? false,
      primaryCategoryId: map["primaryCategoryId"]?.toInt() ?? 0,
      categories: List<CurseForgeModCategorie>.from(
          map["categories"]?.map((x) => CurseForgeModCategorie.fromMap(x))),
      classId: map["classId"]?.toInt() ?? 0,
      authors: List<CurseForgeModAuthor>.from(
          map["authors"]?.map((x) => CurseForgeModAuthor.fromMap(x))),
      logo: CurseForgeModLogo.fromMap(map["logo"]),
      screenshots: List<CurseForgeModScreenshot>.from(
          map["screenshots"]?.map((x) => CurseForgeModScreenshot.fromMap(x))),
      mainFileId: map["mainFileId"]?.toInt() ?? 0,
      latestFiles: List<CurseForgeModLatestFile>.from(
          map["latestFiles"]?.map((x) => CurseForgeModLatestFile.fromMap(x))),
      latestFilesIndexes: List<CurseForgeModLatestFilesIndexe>.from(
          map["latestFilesIndexes"]
              ?.map((x) => CurseForgeModLatestFilesIndexe.fromMap(x))),
      dateCreated: map["dateCreated"] ?? "",
      dateModified: map["dateModified"] ?? "",
      dateReleased: map["dateReleased"] ?? "",
      allowModDistribution: map["allowModDistribution"] ?? false,
      gamePopularityRank: map["gamePopularityRank"]?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeMod.fromJson(String source) =>
      CurseForgeMod.fromMap(json.decode(source));

  @override
  String toString() {
    return "CurseForgeMod(id: $id, gameId: $gameId, name: $name, slug: $slug, links: $links, summary: $summary, status: $status, downloadCount: $downloadCount, isFeatured: $isFeatured, primaryCategoryId: $primaryCategoryId, categories: $categories, classId: $classId, authors: $authors, logo: $logo, screenshots: $screenshots, mainFileId: $mainFileId, latestFiles: $latestFiles, latestFilesIndexes: $latestFilesIndexes, dateCreated: $dateCreated, dateModified: $dateModified, dateReleased: $dateReleased, allowModDistribution: $allowModDistribution, gamePopularityRank: $gamePopularityRank)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is CurseForgeMod &&
        other.id == id &&
        other.gameId == gameId &&
        other.name == name &&
        other.slug == slug &&
        other.links == links &&
        other.summary == summary &&
        other.status == status &&
        other.downloadCount == downloadCount &&
        other.isFeatured == isFeatured &&
        other.primaryCategoryId == primaryCategoryId &&
        listEquals(other.categories, categories) &&
        other.classId == classId &&
        listEquals(other.authors, authors) &&
        other.logo == logo &&
        listEquals(other.screenshots, screenshots) &&
        other.mainFileId == mainFileId &&
        listEquals(other.latestFiles, latestFiles) &&
        listEquals(other.latestFilesIndexes, latestFilesIndexes) &&
        other.dateCreated == dateCreated &&
        other.dateModified == dateModified &&
        other.dateReleased == dateReleased &&
        other.allowModDistribution == allowModDistribution &&
        other.gamePopularityRank == gamePopularityRank;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        gameId.hashCode ^
        name.hashCode ^
        slug.hashCode ^
        links.hashCode ^
        summary.hashCode ^
        status.hashCode ^
        downloadCount.hashCode ^
        isFeatured.hashCode ^
        primaryCategoryId.hashCode ^
        categories.hashCode ^
        classId.hashCode ^
        authors.hashCode ^
        logo.hashCode ^
        screenshots.hashCode ^
        mainFileId.hashCode ^
        latestFiles.hashCode ^
        latestFilesIndexes.hashCode ^
        dateCreated.hashCode ^
        dateModified.hashCode ^
        dateReleased.hashCode ^
        allowModDistribution.hashCode ^
        gamePopularityRank.hashCode;
  }
}

class CurseForgeModLinks {
  final String websiteUrl;
  final String wikiUrl;
  final String issuesUrl;
  final String sourceUrl;
  CurseForgeModLinks({
    required this.websiteUrl,
    required this.wikiUrl,
    required this.issuesUrl,
    required this.sourceUrl,
  });

  CurseForgeModLinks copyWith({
    String? websiteUrl,
    String? wikiUrl,
    String? issuesUrl,
    String? sourceUrl,
  }) {
    return CurseForgeModLinks(
      websiteUrl: websiteUrl ?? this.websiteUrl,
      wikiUrl: wikiUrl ?? this.wikiUrl,
      issuesUrl: issuesUrl ?? this.issuesUrl,
      sourceUrl: sourceUrl ?? this.sourceUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "websiteUrl": websiteUrl,
      "wikiUrl": wikiUrl,
      "issuesUrl": issuesUrl,
      "sourceUrl": sourceUrl,
    };
  }

  factory CurseForgeModLinks.fromMap(Map<String, dynamic> map) {
    return CurseForgeModLinks(
      websiteUrl: map["websiteUrl"] ?? "",
      wikiUrl: map["wikiUrl"] ?? "",
      issuesUrl: map["issuesUrl"] ?? "",
      sourceUrl: map["sourceUrl"] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModLinks.fromJson(String source) =>
      CurseForgeModLinks.fromMap(json.decode(source));

  @override
  String toString() {
    return "Links(websiteUrl: $websiteUrl, wikiUrl: $wikiUrl, issuesUrl: $issuesUrl, sourceUrl: $sourceUrl)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurseForgeModLinks &&
        other.websiteUrl == websiteUrl &&
        other.wikiUrl == wikiUrl &&
        other.issuesUrl == issuesUrl &&
        other.sourceUrl == sourceUrl;
  }

  @override
  int get hashCode {
    return websiteUrl.hashCode ^
        wikiUrl.hashCode ^
        issuesUrl.hashCode ^
        sourceUrl.hashCode;
  }
}

class CurseForgeModCategorie {
  final int id;
  final int gameId;
  final String name;
  final String slug;
  final String url;
  final String iconUrl;
  final String dateModified;
  final bool isClass;
  final int classId;
  final int parentCategoryId;
  CurseForgeModCategorie({
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

  CurseForgeModCategorie copyWith({
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
    return CurseForgeModCategorie(
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
      "id": id,
      "gameId": gameId,
      "name": name,
      "slug": slug,
      "url": url,
      "iconUrl": iconUrl,
      "dateModified": dateModified,
      "isClass": isClass,
      "classId": classId,
      "parentCategoryId": parentCategoryId,
    };
  }

  factory CurseForgeModCategorie.fromMap(Map<String, dynamic> map) {
    return CurseForgeModCategorie(
      id: map["id"]?.toInt() ?? 0,
      gameId: map["gameId"]?.toInt() ?? 0,
      name: map["name"] ?? "",
      slug: map["slug"] ?? "",
      url: map["url"] ?? "",
      iconUrl: map["iconUrl"] ?? "",
      dateModified: map["dateModified"] ?? "",
      isClass: map["isClass"] ?? false,
      classId: map["classId"]?.toInt() ?? 0,
      parentCategoryId: map["parentCategoryId"]?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModCategorie.fromJson(String source) =>
      CurseForgeModCategorie.fromMap(json.decode(source));

  @override
  String toString() {
    return "Categorie(id: $id, gameId: $gameId, name: $name, slug: $slug, url: $url, iconUrl: $iconUrl, dateModified: $dateModified, isClass: $isClass, classId: $classId, parentCategoryId: $parentCategoryId)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurseForgeModCategorie &&
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

class CurseForgeModAuthor {
  final int id;
  final String name;
  final String url;
  CurseForgeModAuthor({
    required this.id,
    required this.name,
    required this.url,
  });

  CurseForgeModAuthor copyWith({
    int? id,
    String? name,
    String? url,
  }) {
    return CurseForgeModAuthor(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "url": url,
    };
  }

  factory CurseForgeModAuthor.fromMap(Map<String, dynamic> map) {
    return CurseForgeModAuthor(
      id: map["id"]?.toInt() ?? 0,
      name: map["name"] ?? "",
      url: map["url"] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModAuthor.fromJson(String source) =>
      CurseForgeModAuthor.fromMap(json.decode(source));

  @override
  String toString() => "Author(id: $id, name: $name, url: $url)";

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurseForgeModAuthor &&
        other.id == id &&
        other.name == name &&
        other.url == url;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ url.hashCode;
}

class CurseForgeModLogo {
  final int id;
  final int modId;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String url;
  CurseForgeModLogo({
    required this.id,
    required this.modId,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.url,
  });

  CurseForgeModLogo copyWith({
    int? id,
    int? modId,
    String? title,
    String? description,
    String? thumbnailUrl,
    String? url,
  }) {
    return CurseForgeModLogo(
      id: id ?? this.id,
      modId: modId ?? this.modId,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "modId": modId,
      "title": title,
      "description": description,
      "thumbnailUrl": thumbnailUrl,
      "url": url,
    };
  }

  factory CurseForgeModLogo.fromMap(Map<String, dynamic> map) {
    return CurseForgeModLogo(
      id: map["id"]?.toInt() ?? 0,
      modId: map["modId"]?.toInt() ?? 0,
      title: map["title"] ?? "",
      description: map["description"] ?? "",
      thumbnailUrl: map["thumbnailUrl"] ?? "",
      url: map["url"] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModLogo.fromJson(String source) =>
      CurseForgeModLogo.fromMap(json.decode(source));

  @override
  String toString() {
    return "Logo(id: $id, modId: $modId, title: $title, description: $description, thumbnailUrl: $thumbnailUrl, url: $url)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurseForgeModLogo &&
        other.id == id &&
        other.modId == modId &&
        other.title == title &&
        other.description == description &&
        other.thumbnailUrl == thumbnailUrl &&
        other.url == url;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        modId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        thumbnailUrl.hashCode ^
        url.hashCode;
  }
}

class CurseForgeModScreenshot {
  final int id;
  final int modId;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String url;
  CurseForgeModScreenshot({
    required this.id,
    required this.modId,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.url,
  });

  CurseForgeModScreenshot copyWith({
    int? id,
    int? modId,
    String? title,
    String? description,
    String? thumbnailUrl,
    String? url,
  }) {
    return CurseForgeModScreenshot(
      id: id ?? this.id,
      modId: modId ?? this.modId,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "modId": modId,
      "title": title,
      "description": description,
      "thumbnailUrl": thumbnailUrl,
      "url": url,
    };
  }

  factory CurseForgeModScreenshot.fromMap(Map<String, dynamic> map) {
    return CurseForgeModScreenshot(
      id: map["id"]?.toInt() ?? 0,
      modId: map["modId"]?.toInt() ?? 0,
      title: map["title"] ?? "",
      description: map["description"] ?? "",
      thumbnailUrl: map["thumbnailUrl"] ?? "",
      url: map["url"] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModScreenshot.fromJson(String source) =>
      CurseForgeModScreenshot.fromMap(json.decode(source));

  @override
  String toString() {
    return "Screenshot(id: $id, modId: $modId, title: $title, description: $description, thumbnailUrl: $thumbnailUrl, url: $url)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurseForgeModScreenshot &&
        other.id == id &&
        other.modId == modId &&
        other.title == title &&
        other.description == description &&
        other.thumbnailUrl == thumbnailUrl &&
        other.url == url;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        modId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        thumbnailUrl.hashCode ^
        url.hashCode;
  }
}

class CurseForgeModLatestFile {
  final int id;
  final int gameId;
  final int modId;
  final bool isAvailable;
  final String displayName;
  final String fileName;
  final int releaseType;
  final int fileStatus;
  final List<CurseForgeModHashe> hashes;
  final String fileDate;
  final int fileLength;
  final int downloadCount;
  final String downloadUrl;
  final List<String> gameVersions;
  final List<CurseForgeModSortableGameVersion> sortableGameVersions;
  final List<dynamic> dependencies;
  final int alternateFileId;
  final bool isServerPack;
  final int fileFingerprint;
  final List<CurseForgeModModule> modules;
  CurseForgeModLatestFile({
    required this.id,
    required this.gameId,
    required this.modId,
    required this.isAvailable,
    required this.displayName,
    required this.fileName,
    required this.releaseType,
    required this.fileStatus,
    required this.hashes,
    required this.fileDate,
    required this.fileLength,
    required this.downloadCount,
    required this.downloadUrl,
    required this.gameVersions,
    required this.sortableGameVersions,
    required this.dependencies,
    required this.alternateFileId,
    required this.isServerPack,
    required this.fileFingerprint,
    required this.modules,
  });

  CurseForgeModLatestFile copyWith({
    int? id,
    int? gameId,
    int? modId,
    bool? isAvailable,
    String? displayName,
    String? fileName,
    int? releaseType,
    int? fileStatus,
    List<CurseForgeModHashe>? hashes,
    String? fileDate,
    int? fileLength,
    int? downloadCount,
    String? downloadUrl,
    List<String>? gameVersions,
    List<CurseForgeModSortableGameVersion>? sortableGameVersions,
    List<dynamic>? dependencies,
    int? alternateFileId,
    bool? isServerPack,
    int? fileFingerprint,
    List<CurseForgeModModule>? modules,
  }) {
    return CurseForgeModLatestFile(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      modId: modId ?? this.modId,
      isAvailable: isAvailable ?? this.isAvailable,
      displayName: displayName ?? this.displayName,
      fileName: fileName ?? this.fileName,
      releaseType: releaseType ?? this.releaseType,
      fileStatus: fileStatus ?? this.fileStatus,
      hashes: hashes ?? this.hashes,
      fileDate: fileDate ?? this.fileDate,
      fileLength: fileLength ?? this.fileLength,
      downloadCount: downloadCount ?? this.downloadCount,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      gameVersions: gameVersions ?? this.gameVersions,
      sortableGameVersions: sortableGameVersions ?? this.sortableGameVersions,
      dependencies: dependencies ?? this.dependencies,
      alternateFileId: alternateFileId ?? this.alternateFileId,
      isServerPack: isServerPack ?? this.isServerPack,
      fileFingerprint: fileFingerprint ?? this.fileFingerprint,
      modules: modules ?? this.modules,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "gameId": gameId,
      "modId": modId,
      "isAvailable": isAvailable,
      "displayName": displayName,
      "fileName": fileName,
      "releaseType": releaseType,
      "fileStatus": fileStatus,
      "hashes": hashes.map((x) => x.toMap()).toList(),
      "fileDate": fileDate,
      "fileLength": fileLength,
      "downloadCount": downloadCount,
      "downloadUrl": downloadUrl,
      "gameVersions": gameVersions,
      "sortableGameVersions":
          sortableGameVersions.map((x) => x.toMap()).toList(),
      "dependencies": dependencies,
      "alternateFileId": alternateFileId,
      "isServerPack": isServerPack,
      "fileFingerprint": fileFingerprint,
      "modules": modules.map((x) => x.toMap()).toList(),
    };
  }

  factory CurseForgeModLatestFile.fromMap(Map<String, dynamic> map) {
    return CurseForgeModLatestFile(
      id: map["id"]?.toInt() ?? 0,
      gameId: map["gameId"]?.toInt() ?? 0,
      modId: map["modId"]?.toInt() ?? 0,
      isAvailable: map["isAvailable"] ?? false,
      displayName: map["displayName"] ?? "",
      fileName: map["fileName"] ?? "",
      releaseType: map["releaseType"]?.toInt() ?? 0,
      fileStatus: map["fileStatus"]?.toInt() ?? 0,
      hashes: List<CurseForgeModHashe>.from(
          map["hashes"]?.map((x) => CurseForgeModHashe.fromMap(x))),
      fileDate: map["fileDate"] ?? "",
      fileLength: map["fileLength"]?.toInt() ?? 0,
      downloadCount: map["downloadCount"]?.toInt() ?? 0,
      downloadUrl: map["downloadUrl"] ?? "",
      gameVersions: List<String>.from(map["gameVersions"]),
      sortableGameVersions: List<CurseForgeModSortableGameVersion>.from(
          map["sortableGameVersions"]
              ?.map((x) => CurseForgeModSortableGameVersion.fromMap(x))),
      dependencies: List<dynamic>.from(map["dependencies"]),
      alternateFileId: map["alternateFileId"]?.toInt() ?? 0,
      isServerPack: map["isServerPack"] ?? false,
      fileFingerprint: map["fileFingerprint"]?.toInt() ?? 0,
      modules: List<CurseForgeModModule>.from(
          map["modules"]?.map((x) => CurseForgeModModule.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModLatestFile.fromJson(String source) =>
      CurseForgeModLatestFile.fromMap(json.decode(source));

  @override
  String toString() {
    return "LatestFile(id: $id, gameId: $gameId, modId: $modId, isAvailable: $isAvailable, displayName: $displayName, fileName: $fileName, releaseType: $releaseType, fileStatus: $fileStatus, hashes: $hashes, fileDate: $fileDate, fileLength: $fileLength, downloadCount: $downloadCount, downloadUrl: $downloadUrl, gameVersions: $gameVersions, sortableGameVersions: $sortableGameVersions, dependencies: $dependencies, alternateFileId: $alternateFileId, isServerPack: $isServerPack, fileFingerprint: $fileFingerprint, modules: $modules)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is CurseForgeModLatestFile &&
        other.id == id &&
        other.gameId == gameId &&
        other.modId == modId &&
        other.isAvailable == isAvailable &&
        other.displayName == displayName &&
        other.fileName == fileName &&
        other.releaseType == releaseType &&
        other.fileStatus == fileStatus &&
        listEquals(other.hashes, hashes) &&
        other.fileDate == fileDate &&
        other.fileLength == fileLength &&
        other.downloadCount == downloadCount &&
        other.downloadUrl == downloadUrl &&
        listEquals(other.gameVersions, gameVersions) &&
        listEquals(other.sortableGameVersions, sortableGameVersions) &&
        listEquals(other.dependencies, dependencies) &&
        other.alternateFileId == alternateFileId &&
        other.isServerPack == isServerPack &&
        other.fileFingerprint == fileFingerprint &&
        listEquals(other.modules, modules);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        gameId.hashCode ^
        modId.hashCode ^
        isAvailable.hashCode ^
        displayName.hashCode ^
        fileName.hashCode ^
        releaseType.hashCode ^
        fileStatus.hashCode ^
        hashes.hashCode ^
        fileDate.hashCode ^
        fileLength.hashCode ^
        downloadCount.hashCode ^
        downloadUrl.hashCode ^
        gameVersions.hashCode ^
        sortableGameVersions.hashCode ^
        dependencies.hashCode ^
        alternateFileId.hashCode ^
        isServerPack.hashCode ^
        fileFingerprint.hashCode ^
        modules.hashCode;
  }
}

class CurseForgeModHashe {
  final String value;
  final int algo;
  CurseForgeModHashe({
    required this.value,
    required this.algo,
  });

  CurseForgeModHashe copyWith({
    String? value,
    int? algo,
  }) {
    return CurseForgeModHashe(
      value: value ?? this.value,
      algo: algo ?? this.algo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "value": value,
      "algo": algo,
    };
  }

  factory CurseForgeModHashe.fromMap(Map<String, dynamic> map) {
    return CurseForgeModHashe(
      value: map["value"] ?? "",
      algo: map["algo"]?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModHashe.fromJson(String source) =>
      CurseForgeModHashe.fromMap(json.decode(source));

  @override
  String toString() => "Hashe(value: $value, algo: $algo)";

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurseForgeModHashe &&
        other.value == value &&
        other.algo == algo;
  }

  @override
  int get hashCode => value.hashCode ^ algo.hashCode;
}

class CurseForgeModSortableGameVersion {
  final String gameVersionName;
  final String gameVersionPadded;
  final String gameVersion;
  final String gameVersionReleaseDate;
  final int gameVersionTypeId;
  CurseForgeModSortableGameVersion({
    required this.gameVersionName,
    required this.gameVersionPadded,
    required this.gameVersion,
    required this.gameVersionReleaseDate,
    required this.gameVersionTypeId,
  });

  CurseForgeModSortableGameVersion copyWith({
    String? gameVersionName,
    String? gameVersionPadded,
    String? gameVersion,
    String? gameVersionReleaseDate,
    int? gameVersionTypeId,
  }) {
    return CurseForgeModSortableGameVersion(
      gameVersionName: gameVersionName ?? this.gameVersionName,
      gameVersionPadded: gameVersionPadded ?? this.gameVersionPadded,
      gameVersion: gameVersion ?? this.gameVersion,
      gameVersionReleaseDate:
          gameVersionReleaseDate ?? this.gameVersionReleaseDate,
      gameVersionTypeId: gameVersionTypeId ?? this.gameVersionTypeId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "gameVersionName": gameVersionName,
      "gameVersionPadded": gameVersionPadded,
      "gameVersion": gameVersion,
      "gameVersionReleaseDate": gameVersionReleaseDate,
      "gameVersionTypeId": gameVersionTypeId,
    };
  }

  factory CurseForgeModSortableGameVersion.fromMap(Map<String, dynamic> map) {
    return CurseForgeModSortableGameVersion(
      gameVersionName: map["gameVersionName"] ?? "",
      gameVersionPadded: map["gameVersionPadded"] ?? "",
      gameVersion: map["gameVersion"] ?? "",
      gameVersionReleaseDate: map["gameVersionReleaseDate"] ?? "",
      gameVersionTypeId: map["gameVersionTypeId"]?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModSortableGameVersion.fromJson(String source) =>
      CurseForgeModSortableGameVersion.fromMap(json.decode(source));

  @override
  String toString() {
    return "SortableGameVersion(gameVersionName: $gameVersionName, gameVersionPadded: $gameVersionPadded, gameVersion: $gameVersion, gameVersionReleaseDate: $gameVersionReleaseDate, gameVersionTypeId: $gameVersionTypeId)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurseForgeModSortableGameVersion &&
        other.gameVersionName == gameVersionName &&
        other.gameVersionPadded == gameVersionPadded &&
        other.gameVersion == gameVersion &&
        other.gameVersionReleaseDate == gameVersionReleaseDate &&
        other.gameVersionTypeId == gameVersionTypeId;
  }

  @override
  int get hashCode {
    return gameVersionName.hashCode ^
        gameVersionPadded.hashCode ^
        gameVersion.hashCode ^
        gameVersionReleaseDate.hashCode ^
        gameVersionTypeId.hashCode;
  }
}

class CurseForgeModModule {
  final String name;
  final int fingerprint;
  CurseForgeModModule({
    required this.name,
    required this.fingerprint,
  });

  CurseForgeModModule copyWith({
    String? name,
    int? fingerprint,
  }) {
    return CurseForgeModModule(
      name: name ?? this.name,
      fingerprint: fingerprint ?? this.fingerprint,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "fingerprint": fingerprint,
    };
  }

  factory CurseForgeModModule.fromMap(Map<String, dynamic> map) {
    return CurseForgeModModule(
      name: map["name"] ?? "",
      fingerprint: map["fingerprint"]?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModModule.fromJson(String source) =>
      CurseForgeModModule.fromMap(json.decode(source));

  @override
  String toString() => "Module(name: $name, fingerprint: $fingerprint)";

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurseForgeModModule &&
        other.name == name &&
        other.fingerprint == fingerprint;
  }

  @override
  int get hashCode => name.hashCode ^ fingerprint.hashCode;
}

class CurseForgeModLatestFilesIndexe {
  final String gameVersion;
  final int fileId;
  final String filename;
  final int releaseType;
  final int gameVersionTypeId;
  final int modLoader;
  CurseForgeModLatestFilesIndexe({
    required this.gameVersion,
    required this.fileId,
    required this.filename,
    required this.releaseType,
    required this.gameVersionTypeId,
    required this.modLoader,
  });

  CurseForgeModLatestFilesIndexe copyWith({
    String? gameVersion,
    int? fileId,
    String? filename,
    int? releaseType,
    int? gameVersionTypeId,
    int? modLoader,
  }) {
    return CurseForgeModLatestFilesIndexe(
      gameVersion: gameVersion ?? this.gameVersion,
      fileId: fileId ?? this.fileId,
      filename: filename ?? this.filename,
      releaseType: releaseType ?? this.releaseType,
      gameVersionTypeId: gameVersionTypeId ?? this.gameVersionTypeId,
      modLoader: modLoader ?? this.modLoader,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "gameVersion": gameVersion,
      "fileId": fileId,
      "filename": filename,
      "releaseType": releaseType,
      "gameVersionTypeId": gameVersionTypeId,
      "modLoader": modLoader,
    };
  }

  factory CurseForgeModLatestFilesIndexe.fromMap(Map<String, dynamic> map) {
    return CurseForgeModLatestFilesIndexe(
      gameVersion: map["gameVersion"] ?? "",
      fileId: map["fileId"]?.toInt() ?? 0,
      filename: map["filename"] ?? "",
      releaseType: map["releaseType"]?.toInt() ?? 0,
      gameVersionTypeId: map["gameVersionTypeId"]?.toInt() ?? 0,
      modLoader: map["modLoader"]?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModLatestFilesIndexe.fromJson(String source) =>
      CurseForgeModLatestFilesIndexe.fromMap(json.decode(source));

  @override
  String toString() {
    return "LatestFilesIndexe(gameVersion: $gameVersion, fileId: $fileId, filename: $filename, releaseType: $releaseType, gameVersionTypeId: $gameVersionTypeId, modLoader: $modLoader)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurseForgeModLatestFilesIndexe &&
        other.gameVersion == gameVersion &&
        other.fileId == fileId &&
        other.filename == filename &&
        other.releaseType == releaseType &&
        other.gameVersionTypeId == gameVersionTypeId &&
        other.modLoader == modLoader;
  }

  @override
  int get hashCode {
    return gameVersion.hashCode ^
        fileId.hashCode ^
        filename.hashCode ^
        releaseType.hashCode ^
        gameVersionTypeId.hashCode ^
        modLoader.hashCode;
  }
}
