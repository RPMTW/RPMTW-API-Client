import 'dart:convert';

class CurseForgeMinecraftGameVersion {
  final int id;
  final int gameVersionId;
  final String versionString;
  final String jarDownloadUrl;
  final String jsonDownloadUrl;
  final bool approved;
  final String dateModified;
  final int? gameVersionTypeId;
  final int gameVersionStatus;
  final int gameVersionTypeStatus;

  const CurseForgeMinecraftGameVersion({
    required this.id,
    required this.gameVersionId,
    required this.versionString,
    required this.jarDownloadUrl,
    required this.jsonDownloadUrl,
    required this.approved,
    required this.dateModified,
    required this.gameVersionTypeId,
    required this.gameVersionStatus,
    required this.gameVersionTypeStatus,
  });

  CurseForgeMinecraftGameVersion copyWith({
    int? id,
    int? gameVersionId,
    String? versionString,
    String? jarDownloadUrl,
    String? jsonDownloadUrl,
    bool? approved,
    String? dateModified,
    int? gameVersionTypeId,
    int? gameVersionStatus,
    int? gameVersionTypeStatus,
  }) {
    return CurseForgeMinecraftGameVersion(
      id: id ?? this.id,
      gameVersionId: gameVersionId ?? this.gameVersionId,
      versionString: versionString ?? this.versionString,
      jarDownloadUrl: jarDownloadUrl ?? this.jarDownloadUrl,
      jsonDownloadUrl: jsonDownloadUrl ?? this.jsonDownloadUrl,
      approved: approved ?? this.approved,
      dateModified: dateModified ?? this.dateModified,
      gameVersionTypeId: gameVersionTypeId ?? this.gameVersionTypeId,
      gameVersionStatus: gameVersionStatus ?? this.gameVersionStatus,
      gameVersionTypeStatus:
          gameVersionTypeStatus ?? this.gameVersionTypeStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gameVersionId': gameVersionId,
      'versionString': versionString,
      'jarDownloadUrl': jarDownloadUrl,
      'jsonDownloadUrl': jsonDownloadUrl,
      'approved': approved,
      'dateModified': dateModified,
      'gameVersionTypeId': gameVersionTypeId,
      'gameVersionStatus': gameVersionStatus,
      'gameVersionTypeStatus': gameVersionTypeStatus,
    };
  }

  factory CurseForgeMinecraftGameVersion.fromMap(Map<String, dynamic> map) {
    return CurseForgeMinecraftGameVersion(
      id: map['id']?.toInt(),
      gameVersionId: map['gameVersionId'],
      versionString: map['versionString'],
      jarDownloadUrl: map['jarDownloadUrl'],
      jsonDownloadUrl: map['jsonDownloadUrl'],
      approved: map['approved'],
      dateModified: map['dateModified'],
      gameVersionTypeId: map['gameVersionTypeId'],
      gameVersionStatus: map['gameVersionStatus'],
      gameVersionTypeStatus: map['gameVersionTypeStatus'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CurseForgeMinecraftGameVersion.fromJson(String source) =>
      CurseForgeMinecraftGameVersion.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CurseForgeMinecraftGameVersion(id: $id, gameVersionId: $gameVersionId, versionString: $versionString, jarDownloadUrl: $jarDownloadUrl, jsonDownloadUrl: $jsonDownloadUrl, approved: $approved, dateModified: $dateModified, gameVersionTypeId: $gameVersionTypeId, gameVersionStatus: $gameVersionStatus, gameVersionTypeStatus: $gameVersionTypeStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurseForgeMinecraftGameVersion &&
        other.id == id &&
        other.gameVersionId == gameVersionId &&
        other.versionString == versionString &&
        other.jarDownloadUrl == jarDownloadUrl &&
        other.jsonDownloadUrl == jsonDownloadUrl &&
        other.approved == approved &&
        other.dateModified == dateModified &&
        other.gameVersionTypeId == gameVersionTypeId &&
        other.gameVersionStatus == gameVersionStatus &&
        other.gameVersionTypeStatus == gameVersionTypeStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        gameVersionId.hashCode ^
        versionString.hashCode ^
        jarDownloadUrl.hashCode ^
        jsonDownloadUrl.hashCode ^
        approved.hashCode ^
        dateModified.hashCode ^
        gameVersionTypeId.hashCode ^
        gameVersionStatus.hashCode ^
        gameVersionTypeStatus.hashCode;
  }
}
