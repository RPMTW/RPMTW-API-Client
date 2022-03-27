import "dart:convert";

import "package:collection/collection.dart";
import "package:rpmtw_api_client/src/models/base_model.dart";
import "package:rpmtw_api_client/src/models/minecraft/minecraft_version.dart";

class MinecraftVersionManifest implements BaseModel {
  final String latestRelease;

  final String latestSnapshot;

  final List<MinecraftVersion> versions;

  @override
  final String uuid;
  final DateTime lastUpdated;

  const MinecraftVersionManifest({
    required this.latestRelease,
    required this.versions,
    required this.latestSnapshot,
    required this.uuid,
    required this.lastUpdated,
  });

  factory MinecraftVersionManifest.fromMap(Map<String, dynamic> map) {
    return MinecraftVersionManifest(
      versions: (map["manifest"]["versions"] as List<dynamic>)
          .map((d) => MinecraftVersion.fromMap(d))
          .toList(),
      latestRelease: map["manifest"]["latest"]["release"],
      latestSnapshot: map["manifest"]["latest"]["snapshot"],
      uuid: map["uuid"],
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(map["lastUpdated"]),
    );
  }

  factory MinecraftVersionManifest.fromJson(String json) {
    return MinecraftVersionManifest.fromMap(jsonDecode(json));
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "manifest": {
        "latest": {
          "release": latestRelease,
          "snapshot": latestSnapshot,
        },
        "versions": versions.map((v) => v.toMap()).toList(),
      },
      "uuid": uuid,
      "lastUpdated": lastUpdated.millisecondsSinceEpoch,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is MinecraftVersionManifest &&
        other.latestRelease == latestRelease &&
        other.latestSnapshot == latestSnapshot &&
        listEquals(other.versions, versions) &&
        other.uuid == uuid &&
        other.lastUpdated == lastUpdated;
  }

  @override
  int get hashCode {
    return latestRelease.hashCode ^
        latestSnapshot.hashCode ^
        versions.hashCode ^
        uuid.hashCode ^
        lastUpdated.hashCode;
  }

  @override
  String toString() {
    return "MinecraftVersionManifest(latestRelease: $latestRelease, latestSnapshot: $latestSnapshot, versions: $versions, uuid: $uuid, lastUpdated: $lastUpdated)";
  }

  MinecraftVersionManifest copyWith({
    String? latestRelease,
    String? latestSnapshot,
    List<MinecraftVersion>? versions,
    String? uuid,
    DateTime? lastUpdated,
    int? statusCode,
    String? statusMessage,
  }) {
    return MinecraftVersionManifest(
      latestRelease: latestRelease ?? this.latestRelease,
      latestSnapshot: latestSnapshot ?? this.latestSnapshot,
      versions: versions ?? this.versions,
      uuid: uuid ?? this.uuid,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
