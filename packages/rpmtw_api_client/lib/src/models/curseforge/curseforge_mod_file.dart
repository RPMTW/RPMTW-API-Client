import 'dart:convert';

import 'package:collection/collection.dart';

class CurseForgeModFile {
  final int id;
  final int gameId;
  final int modId;
  final bool isAvailable;
  final String displayName;
  final String fileName;
  final int releaseType;
  final int fileStatus;
  final List<Hash> hashes;
  final String fileDate;
  final int fileLength;
  final int downloadCount;
  final String downloadUrl;
  final List<String> gameVersions;
  final List<SortableGameVersion> sortableGameVersions;
  final List<Dependency> dependencies;
  final bool exposeAsAlternative;
  final int? parentProjectFileId;
  final int alternateFileId;
  final bool isServerPack;
  final int? serverPackFileId;
  final int fileFingerprint;
  final List<Module> modules;

  const CurseForgeModFile({
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
    required this.exposeAsAlternative,
    required this.parentProjectFileId,
    required this.alternateFileId,
    required this.isServerPack,
    required this.serverPackFileId,
    required this.fileFingerprint,
    required this.modules,
  });

  CurseForgeModFile copyWith({
    int? id,
    int? gameId,
    int? modId,
    bool? isAvailable,
    String? displayName,
    String? fileName,
    int? releaseType,
    int? fileStatus,
    List<Hash>? hashes,
    String? fileDate,
    int? fileLength,
    int? downloadCount,
    String? downloadUrl,
    List<String>? gameVersions,
    List<SortableGameVersion>? sortableGameVersions,
    List<Dependency>? dependencies,
    bool? exposeAsAlternative,
    int? parentProjectFileId,
    int? alternateFileId,
    bool? isServerPack,
    int? serverPackFileId,
    int? fileFingerprint,
    List<Module>? modules,
  }) {
    return CurseForgeModFile(
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
      exposeAsAlternative: exposeAsAlternative ?? this.exposeAsAlternative,
      parentProjectFileId: parentProjectFileId ?? this.parentProjectFileId,
      alternateFileId: alternateFileId ?? this.alternateFileId,
      isServerPack: isServerPack ?? this.isServerPack,
      serverPackFileId: serverPackFileId ?? this.serverPackFileId,
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
      'releaseType': releaseType,
      'fileStatus': fileStatus,
      'hashes': hashes.map((x) => x.toMap()).toList(),
      'fileDate': fileDate,
      'fileLength': fileLength,
      'downloadCount': downloadCount,
      'downloadUrl': downloadUrl,
      'gameVersions': gameVersions,
      'sortableGameVersions':
          sortableGameVersions.map((x) => x.toMap()).toList(),
      'dependencies': dependencies.map((x) => x.toMap()).toList(),
      'exposeAsAlternative': exposeAsAlternative,
      'parentProjectFileId': parentProjectFileId,
      'alternateFileId': alternateFileId,
      'isServerPack': isServerPack,
      'serverPackFileId': serverPackFileId,
      'fileFingerprint': fileFingerprint,
      'modules': modules.map((x) => x.toMap()).toList(),
    };
  }

  factory CurseForgeModFile.fromMap(Map<String, dynamic> map) {
    return CurseForgeModFile(
      id: map['id'],
      gameId: map['gameId'],
      modId: map['modId'],
      isAvailable: map['isAvailable'],
      displayName: map['displayName'],
      fileName: map['fileName'],
      releaseType: map['releaseType'],
      fileStatus: map['fileStatus'],
      hashes: List<Hash>.from(map['hashes']?.map((x) => Hash.fromMap(x))),
      fileDate: map['fileDate'],
      fileLength: map['fileLength'],
      downloadCount: map['downloadCount'],
      downloadUrl: map['downloadUrl'],
      gameVersions: List<String>.from(map['gameVersions']),
      sortableGameVersions: List<SortableGameVersion>.from(
          map['sortableGameVersions']
              ?.map((x) => SortableGameVersion.fromMap(x))),
      dependencies: List<Dependency>.from(
          map['dependencies']?.map((x) => Dependency.fromMap(x))),
      exposeAsAlternative: map['exposeAsAlternative'] ?? false,
      parentProjectFileId: map['parentProjectFileId'],
      alternateFileId: map['alternateFileId'],
      isServerPack: map['isServerPack'],
      serverPackFileId: map['serverPackFileId'],
      fileFingerprint: map['fileFingerprint'],
      modules: List<Module>.from(map['modules']?.map((x) => Module.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeModFile.fromJson(String source) =>
      CurseForgeModFile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CurseForgeModFile(id: $id, gameId: $gameId, modId: $modId, isAvailable: $isAvailable, displayName: $displayName, fileName: $fileName, releaseType: $releaseType, fileStatus: $fileStatus, hashes: $hashes, fileDate: $fileDate, fileLength: $fileLength, downloadCount: $downloadCount, downloadUrl: $downloadUrl, gameVersions: $gameVersions, sortableGameVersions: $sortableGameVersions, dependencies: $dependencies, exposeAsAlternative: $exposeAsAlternative, parentProjectFileId: $parentProjectFileId, alternateFileId: $alternateFileId, isServerPack: $isServerPack, serverPackFileId: $serverPackFileId, fileFingerprint: $fileFingerprint, modules: $modules)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is CurseForgeModFile &&
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
        other.exposeAsAlternative == exposeAsAlternative &&
        other.parentProjectFileId == parentProjectFileId &&
        other.alternateFileId == alternateFileId &&
        other.isServerPack == isServerPack &&
        other.serverPackFileId == serverPackFileId &&
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
        exposeAsAlternative.hashCode ^
        parentProjectFileId.hashCode ^
        alternateFileId.hashCode ^
        isServerPack.hashCode ^
        serverPackFileId.hashCode ^
        fileFingerprint.hashCode ^
        modules.hashCode;
  }
}

class Hash {
  final String value;
  final int algo;
  const Hash({
    required this.value,
    required this.algo,
  });

  Hash copyWith({
    String? value,
    int? algo,
  }) {
    return Hash(
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

  factory Hash.fromMap(Map<String, dynamic> map) {
    return Hash(
      value: map['value'],
      algo: map['algo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Hash.fromJson(String source) => Hash.fromMap(json.decode(source));

  @override
  String toString() => 'Hashe(value: $value, algo: $algo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Hash && other.value == value && other.algo == algo;
  }

  @override
  int get hashCode => value.hashCode ^ algo.hashCode;
}

class SortableGameVersion {
  final String gameVersionName;
  final String gameVersionPadded;
  final String gameVersion;
  final String gameVersionReleaseDate;
  final int gameVersionTypeId;
  const SortableGameVersion({
    required this.gameVersionName,
    required this.gameVersionPadded,
    required this.gameVersion,
    required this.gameVersionReleaseDate,
    required this.gameVersionTypeId,
  });

  SortableGameVersion copyWith({
    String? gameVersionName,
    String? gameVersionPadded,
    String? gameVersion,
    String? gameVersionReleaseDate,
    int? gameVersionTypeId,
  }) {
    return SortableGameVersion(
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

  factory SortableGameVersion.fromMap(Map<String, dynamic> map) {
    return SortableGameVersion(
      gameVersionName: map['gameVersionName'],
      gameVersionPadded: map['gameVersionPadded'],
      gameVersion: map['gameVersion'],
      gameVersionReleaseDate: map['gameVersionReleaseDate'],
      gameVersionTypeId: map['gameVersionTypeId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SortableGameVersion.fromJson(String source) =>
      SortableGameVersion.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SortableGameVersion(gameVersionName: $gameVersionName, gameVersionPadded: $gameVersionPadded, gameVersion: $gameVersion, gameVersionReleaseDate: $gameVersionReleaseDate, gameVersionTypeId: $gameVersionTypeId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SortableGameVersion &&
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

class Dependency {
  final int modId;
  final int relationType;
  const Dependency({
    required this.modId,
    required this.relationType,
  });

  Dependency copyWith({
    int? modId,
    int? relationType,
  }) {
    return Dependency(
      modId: modId ?? this.modId,
      relationType: relationType ?? this.relationType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'modId': modId,
      'relationType': relationType,
    };
  }

  factory Dependency.fromMap(Map<String, dynamic> map) {
    return Dependency(
      modId: map['modId'],
      relationType: map['relationType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Dependency.fromJson(String source) =>
      Dependency.fromMap(json.decode(source));

  @override
  String toString() => 'Dependency(modId: $modId, relationType: $relationType)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Dependency &&
        other.modId == modId &&
        other.relationType == relationType;
  }

  @override
  int get hashCode => modId.hashCode ^ relationType.hashCode;
}

class Module {
  final String name;
  final int fingerprint;
  const Module({
    required this.name,
    required this.fingerprint,
  });

  Module copyWith({
    String? name,
    int? fingerprint,
  }) {
    return Module(
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

  factory Module.fromMap(Map<String, dynamic> map) {
    return Module(
      name: map['name'],
      fingerprint: map['fingerprint'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Module.fromJson(String source) => Module.fromMap(json.decode(source));

  @override
  String toString() => 'Module(name: $name, fingerprint: $fingerprint)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Module &&
        other.name == name &&
        other.fingerprint == fingerprint;
  }

  @override
  int get hashCode => name.hashCode ^ fingerprint.hashCode;
}
