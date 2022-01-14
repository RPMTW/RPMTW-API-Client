import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:rpmtw_api_client/src/models/base_model.dart';
import 'package:rpmtw_api_client/src/models/minecraft/minecraft_version.dart';

class MinecraftVersionManifest extends BaseModel {
  final String latestRelease;

  final String latestSnapshot;

  final List<MinecraftVersion> versions;

  final String uuid;
  final DateTime lastUpdated;

  const MinecraftVersionManifest(
      {required this.latestRelease,
      required this.versions,
      required this.latestSnapshot,
      required this.uuid,
      required this.lastUpdated,
      required int statusCode,
      required String statusMessage})
      : super(statusCode: statusCode, statusMessage: statusMessage);

  factory MinecraftVersionManifest.fromMap(Map<String, dynamic> map) {
    Map data = map['data'];
    return MinecraftVersionManifest(
        versions: (data['manifest']['versions'] as List<dynamic>)
            .map((d) => MinecraftVersion.fromMap(d))
            .toList(),
        latestRelease: data['manifest']['latest']['release'],
        latestSnapshot: data['manifest']['latest']['snapshot'],
        uuid: data['uuid'],
        lastUpdated: DateTime.fromMillisecondsSinceEpoch(data['lastUpdated']),
        statusCode: map['status'],
        statusMessage: map['message']);
  }

  factory MinecraftVersionManifest.fromJson(String json) {
    return MinecraftVersionManifest.fromMap(jsonDecode(json));
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "data": {
        "manifest": {
          'latest': {
            'release': latestRelease,
            'snapshot': latestSnapshot,
          },
          'versions': versions.map((v) => v.toMap()).toList(),
        },
        'uuid': uuid,
        'lastUpdated': lastUpdated.millisecondsSinceEpoch,
      },
      "status": statusCode,
      "message": statusMessage,
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
        other.lastUpdated == lastUpdated &&
        other.statusCode == statusCode &&
        other.statusMessage == statusMessage;
  }

  @override
  int get hashCode {
    return latestRelease.hashCode ^
        latestSnapshot.hashCode ^
        versions.hashCode ^
        uuid.hashCode ^
        lastUpdated.hashCode ^
        statusCode.hashCode ^
        statusMessage.hashCode;
  }

  @override
  String toString() {
    return 'MinecraftVersionManifest(latestRelease: $latestRelease, latestSnapshot: $latestSnapshot, versions: $versions, uuid: $uuid, lastUpdated: $lastUpdated, statusCode: $statusCode, statusMessage: $statusMessage)';
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
      statusCode: statusCode ?? this.statusCode,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }
}
