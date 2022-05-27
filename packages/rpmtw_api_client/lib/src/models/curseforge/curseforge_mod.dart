import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:rpmtw_api_client/src/models/curseforge/curseforge_category.dart';
import 'package:rpmtw_api_client/src/models/curseforge/curseforge_file_release_type.dart';
import 'package:rpmtw_api_client/src/models/curseforge/curseforge_mod_loader_type.dart';
import 'package:rpmtw_api_client/src/util/uitl.dart';

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
  final List<CurseForgeCategory> categories;
  final int? classId;
  final List<CurseForgeModAuthor> authors;
  final CurseForgeModLogo? logo;
  final List<CurseForgeModScreenshot> screenshots;
  final int mainFileId;
  final List<CurseForgeModLatestFile> latestFiles;
  final List<CurseForgeModLatestFilesIndex> latestFilesIndexes;
  final String dateCreated;
  final String dateModified;
  final String dateReleased;
  final bool? allowModDistribution;
  final int gamePopularityRank;

  const CurseForgeMod({
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
    List<CurseForgeCategory>? categories,
    int? classId,
    List<CurseForgeModAuthor>? authors,
    CurseForgeModLogo? logo,
    List<CurseForgeModScreenshot>? screenshots,
    int? mainFileId,
    List<CurseForgeModLatestFile>? latestFiles,
    List<CurseForgeModLatestFilesIndex>? latestFilesIndexes,
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
      'id': id,
      'gameId': gameId,
      'name': name,
      'slug': slug,
      'links': links.toMap(),
      'summary': summary,
      'status': status,
      'downloadCount': downloadCount,
      'isFeatured': isFeatured,
      'primaryCategoryId': primaryCategoryId,
      'categories': categories.map((x) => x.toMap()).toList(),
      'classId': classId,
      'authors': authors.map((x) => x.toMap()).toList(),
      'logo': logo?.toMap(),
      'screenshots': screenshots.map((x) => x.toMap()).toList(),
      'mainFileId': mainFileId,
      'latestFiles': latestFiles.map((x) => x.toMap()).toList(),
      'latestFilesIndexes': latestFilesIndexes.map((x) => x.toMap()).toList(),
      'dateCreated': dateCreated,
      'dateModified': dateModified,
      'dateReleased': dateReleased,
      'allowModDistribution': allowModDistribution,
      'gamePopularityRank': gamePopularityRank,
    };
  }

  factory CurseForgeMod.fromMap(Map<String, dynamic> map) {
    return CurseForgeMod(
      id: map['id'],
      gameId: map['gameId'],
      name: map['name'],
      slug: map['slug'],
      links: CurseForgeModLinks.fromMap(map['links']),
      summary: map['summary'],
      status: map['status'],
      downloadCount: map['downloadCount'],
      isFeatured: map['isFeatured'],
      primaryCategoryId: map['primaryCategoryId'],
      categories: List<CurseForgeCategory>.from(
          map['categories']?.map((x) => CurseForgeCategory.fromMap(x))),
      classId: map['classId'],
      authors: List<CurseForgeModAuthor>.from(
          map['authors']?.map((x) => CurseForgeModAuthor.fromMap(x))),
      logo: map['logo'] != null ? CurseForgeModLogo.fromMap(map['logo']) : null,
      screenshots: List<CurseForgeModScreenshot>.from(
          map['screenshots']?.map((x) => CurseForgeModScreenshot.fromMap(x))),
      mainFileId: map['mainFileId'],
      latestFiles: List<CurseForgeModLatestFile>.from(
          map['latestFiles']?.map((x) => CurseForgeModLatestFile.fromMap(x))),
      latestFilesIndexes: List<CurseForgeModLatestFilesIndex>.from(
          map['latestFilesIndexes']
              ?.map((x) => CurseForgeModLatestFilesIndex.fromMap(x))),
      dateCreated: map['dateCreated'],
      dateModified: map['dateModified'],
      dateReleased: map['dateReleased'],
      allowModDistribution: map['allowModDistribution'] ?? false,
      gamePopularityRank: map['gamePopularityRank'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeMod.fromJson(String source) =>
      CurseForgeMod.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CurseForgeMod(id: $id, gameId: $gameId, name: $name, slug: $slug, links: $links, summary: $summary, status: $status, downloadCount: $downloadCount, isFeatured: $isFeatured, primaryCategoryId: $primaryCategoryId, categories: $categories, classId: $classId, authors: $authors, logo: $logo, screenshots: $screenshots, mainFileId: $mainFileId, latestFiles: $latestFiles, latestFilesIndexes: $latestFilesIndexes, dateCreated: $dateCreated, dateModified: $dateModified, dateReleased: $dateReleased, allowModDistribution: $allowModDistribution, gamePopularityRank: $gamePopularityRank)';
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
  final String? wikiUrl;
  final String? issuesUrl;
  final String? sourceUrl;
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
      'websiteUrl': websiteUrl,
      'wikiUrl': wikiUrl,
      'issuesUrl': issuesUrl,
      'sourceUrl': sourceUrl,
    };
  }

  factory CurseForgeModLinks.fromMap(Map<String, dynamic> map) {
    return CurseForgeModLinks(
      websiteUrl: map['websiteUrl'],
      wikiUrl: map['wikiUrl'],
      issuesUrl: map['issuesUrl'],
      sourceUrl: map['sourceUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModLinks.fromJson(String source) =>
      CurseForgeModLinks.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Links(websiteUrl: $websiteUrl, wikiUrl: $wikiUrl, issuesUrl: $issuesUrl, sourceUrl: $sourceUrl)';
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

class CurseForgeModAuthor {
  final int id;
  final String name;
  final String url;
  const CurseForgeModAuthor({
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
      'id': id,
      'name': name,
      'url': url,
    };
  }

  factory CurseForgeModAuthor.fromMap(Map<String, dynamic> map) {
    return CurseForgeModAuthor(
      id: map['id'],
      name: map['name'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModAuthor.fromJson(String source) =>
      CurseForgeModAuthor.fromMap(json.decode(source));

  @override
  String toString() => 'Author(id: $id, name: $name, url: $url)';

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
  const CurseForgeModLogo({
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
      'id': id,
      'modId': modId,
      'title': title,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'url': url,
    };
  }

  factory CurseForgeModLogo.fromMap(Map<String, dynamic> map) {
    return CurseForgeModLogo(
      id: map['id'],
      modId: map['modId'],
      title: map['title'],
      description: map['description'],
      thumbnailUrl: map['thumbnailUrl'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModLogo.fromJson(String source) =>
      CurseForgeModLogo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Logo(id: $id, modId: $modId, title: $title, description: $description, thumbnailUrl: $thumbnailUrl, url: $url)';
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
  const CurseForgeModScreenshot({
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
      'id': id,
      'modId': modId,
      'title': title,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'url': url,
    };
  }

  factory CurseForgeModScreenshot.fromMap(Map<String, dynamic> map) {
    return CurseForgeModScreenshot(
      id: map['id'],
      modId: map['modId'],
      title: map['title'],
      description: map['description'],
      thumbnailUrl: map['thumbnailUrl'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModScreenshot.fromJson(String source) =>
      CurseForgeModScreenshot.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Screenshot(id: $id, modId: $modId, title: $title, description: $description, thumbnailUrl: $thumbnailUrl, url: $url)';
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
  final CurseForgeFileReleaseType releaseType;
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
  const CurseForgeModLatestFile({
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
    CurseForgeFileReleaseType? releaseType,
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
      'id': id,
      'gameId': gameId,
      'modId': modId,
      'isAvailable': isAvailable,
      'displayName': displayName,
      'fileName': fileName,
      'releaseType': releaseType.value,
      'fileStatus': fileStatus,
      'hashes': hashes.map((x) => x.toMap()).toList(),
      'fileDate': fileDate,
      'fileLength': fileLength,
      'downloadCount': downloadCount,
      'downloadUrl': downloadUrl,
      'gameVersions': gameVersions,
      'sortableGameVersions':
          sortableGameVersions.map((x) => x.toMap()).toList(),
      'dependencies': dependencies,
      'alternateFileId': alternateFileId,
      'isServerPack': isServerPack,
      'fileFingerprint': fileFingerprint,
      'modules': modules.map((x) => x.toMap()).toList(),
    };
  }

  factory CurseForgeModLatestFile.fromMap(Map<String, dynamic> map) {
    int id = map['id'];
    String fileName = map['fileName'];
    String? downloadUrl = map['downloadUrl'];

    return CurseForgeModLatestFile(
      id: id,
      gameId: map['gameId'],
      modId: map['modId'],
      isAvailable: map['isAvailable'],
      displayName: map['displayName'],
      fileName: fileName,
      releaseType: CurseForgeFileReleaseType.values
          .firstWhere((e) => e.value == map['releaseType']),
      fileStatus: map['fileStatus'],
      hashes: List<CurseForgeModHashe>.from(
          map['hashes']?.map((x) => CurseForgeModHashe.fromMap(x))),
      fileDate: map['fileDate'],
      fileLength: map['fileLength'],
      downloadCount: map['downloadCount'],
      downloadUrl: Util.fixCFFileDownloadUrl(
          fileId: id, fileName: fileName, url: downloadUrl),
      gameVersions: List<String>.from(map['gameVersions']),
      sortableGameVersions: List<CurseForgeModSortableGameVersion>.from(
          map['sortableGameVersions']
              ?.map((x) => CurseForgeModSortableGameVersion.fromMap(x))),
      dependencies: List<dynamic>.from(map['dependencies']),
      alternateFileId: map['alternateFileId'],
      isServerPack: map['isServerPack'],
      fileFingerprint: map['fileFingerprint'],
      modules: List<CurseForgeModModule>.from(
          map['modules']?.map((x) => CurseForgeModModule.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModLatestFile.fromJson(String source) =>
      CurseForgeModLatestFile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LatestFile(id: $id, gameId: $gameId, modId: $modId, isAvailable: $isAvailable, displayName: $displayName, fileName: $fileName, releaseType: $releaseType, fileStatus: $fileStatus, hashes: $hashes, fileDate: $fileDate, fileLength: $fileLength, downloadCount: $downloadCount, downloadUrl: $downloadUrl, gameVersions: $gameVersions, sortableGameVersions: $sortableGameVersions, dependencies: $dependencies, alternateFileId: $alternateFileId, isServerPack: $isServerPack, fileFingerprint: $fileFingerprint, modules: $modules)';
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
  const CurseForgeModHashe({
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
      'value': value,
      'algo': algo,
    };
  }

  factory CurseForgeModHashe.fromMap(Map<String, dynamic> map) {
    return CurseForgeModHashe(
      value: map['value'],
      algo: map['algo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModHashe.fromJson(String source) =>
      CurseForgeModHashe.fromMap(json.decode(source));

  @override
  String toString() => 'Hashe(value: $value, algo: $algo)';

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
  final int? gameVersionTypeId;
  const CurseForgeModSortableGameVersion({
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
      'gameVersionName': gameVersionName,
      'gameVersionPadded': gameVersionPadded,
      'gameVersion': gameVersion,
      'gameVersionReleaseDate': gameVersionReleaseDate,
      'gameVersionTypeId': gameVersionTypeId,
    };
  }

  factory CurseForgeModSortableGameVersion.fromMap(Map<String, dynamic> map) {
    return CurseForgeModSortableGameVersion(
      gameVersionName: map['gameVersionName'],
      gameVersionPadded: map['gameVersionPadded'],
      gameVersion: map['gameVersion'],
      gameVersionReleaseDate: map['gameVersionReleaseDate'],
      gameVersionTypeId: map['gameVersionTypeId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModSortableGameVersion.fromJson(String source) =>
      CurseForgeModSortableGameVersion.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SortableGameVersion(gameVersionName: $gameVersionName, gameVersionPadded: $gameVersionPadded, gameVersion: $gameVersion, gameVersionReleaseDate: $gameVersionReleaseDate, gameVersionTypeId: $gameVersionTypeId)';
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
  const CurseForgeModModule({
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
      'name': name,
      'fingerprint': fingerprint,
    };
  }

  factory CurseForgeModModule.fromMap(Map<String, dynamic> map) {
    return CurseForgeModModule(
      name: map['name'],
      fingerprint: map['fingerprint'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModModule.fromJson(String source) =>
      CurseForgeModModule.fromMap(json.decode(source));

  @override
  String toString() => 'Module(name: $name, fingerprint: $fingerprint)';

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

class CurseForgeModLatestFilesIndex {
  final String gameVersion;
  final int fileId;
  final String filename;
  final CurseForgeFileReleaseType releaseType;
  final int? gameVersionTypeId;
  final CurseForgeModLoaderType? modLoader;
  const CurseForgeModLatestFilesIndex({
    required this.gameVersion,
    required this.fileId,
    required this.filename,
    required this.releaseType,
    required this.gameVersionTypeId,
    required this.modLoader,
  });

  CurseForgeModLatestFilesIndex copyWith({
    String? gameVersion,
    int? fileId,
    String? filename,
    CurseForgeFileReleaseType? releaseType,
    int? gameVersionTypeId,
    CurseForgeModLoaderType? modLoader,
  }) {
    return CurseForgeModLatestFilesIndex(
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
      'gameVersion': gameVersion,
      'fileId': fileId,
      'filename': filename,
      'releaseType': releaseType.value,
      'gameVersionTypeId': gameVersionTypeId,
      'modLoader': modLoader?.value,
    };
  }

  factory CurseForgeModLatestFilesIndex.fromMap(Map<String, dynamic> map) {
    return CurseForgeModLatestFilesIndex(
      gameVersion: map['gameVersion'],
      fileId: map['fileId'],
      filename: map['filename'],
      releaseType: CurseForgeFileReleaseType.values
          .firstWhere((e) => e.value == map['releaseType']),
      gameVersionTypeId: map['gameVersionTypeId'],
      modLoader: CurseForgeModLoaderType.values
          .cast<CurseForgeModLoaderType?>()
          .firstWhere((e) => e?.value == map['modLoader'], orElse: () => null),
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModLatestFilesIndex.fromJson(String source) =>
      CurseForgeModLatestFilesIndex.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LatestFilesIndex(gameVersion: $gameVersion, fileId: $fileId, filename: $filename, releaseType: $releaseType, gameVersionTypeId: $gameVersionTypeId, modLoader: $modLoader)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurseForgeModLatestFilesIndex &&
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
