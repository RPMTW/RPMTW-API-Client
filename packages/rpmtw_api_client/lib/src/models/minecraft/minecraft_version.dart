import 'dart:convert';

import 'package:pub_semver/pub_semver.dart';
import 'package:rpmtw_api_client/src/utilities/utility.dart';

class MinecraftVersion {
  final String id;

  final MinecraftVersionType type;

  final String url;

  final String time;

  final String releaseTime;

  final String sha1;

  final int complianceLevel;

  DateTime get timeDateTime => DateTime.parse(time);

  DateTime get releaseDateTime => DateTime.parse(releaseTime);

  Version get comparableVersion => Utility.parseMCComparableVersion(id);

  const MinecraftVersion(this.id, this.type, this.url, this.time,
      this.releaseTime, this.sha1, this.complianceLevel);

  factory MinecraftVersion.fromMap(Map<String, dynamic> map) {
    return MinecraftVersion(
      map['id'],
      MinecraftVersionType.values.firstWhere((_) => _.name == map['type']),
      map['url'],
      map['time'],
      map['releaseTime'],
      map['sha1'],
      map['complianceLevel']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.name,
      'url': url,
      'time': time,
      'releaseTime': releaseTime,
      'sha1': sha1,
      'complianceLevel': complianceLevel,
    };
  }

  @override
  String toString() {
    return 'MinecraftVersion(id: $id, type: $type, url: $url, time: $time, releaseTime: $releaseTime, sha1: $sha1, complianceLevel: $complianceLevel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MinecraftVersion &&
        other.id == id &&
        other.type == type &&
        other.url == url &&
        other.time == time &&
        other.releaseTime == releaseTime &&
        other.sha1 == sha1 &&
        other.complianceLevel == complianceLevel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        url.hashCode ^
        time.hashCode ^
        releaseTime.hashCode ^
        sha1.hashCode ^
        complianceLevel.hashCode;
  }

  MinecraftVersion copyWith({
    String? id,
    MinecraftVersionType? type,
    String? url,
    String? time,
    String? releaseTime,
    String? sha1,
    int? complianceLevel,
  }) {
    return MinecraftVersion(
      id ?? this.id,
      type ?? this.type,
      url ?? this.url,
      time ?? this.time,
      releaseTime ?? this.releaseTime,
      sha1 ?? this.sha1,
      complianceLevel ?? this.complianceLevel,
    );
  }

  String toJson() => json.encode(toMap());

  factory MinecraftVersion.fromJson(String source) =>
      MinecraftVersion.fromMap(json.decode(source));
}

enum MinecraftVersionType {
  release,
  snapshot,
  beta,
  alpha,
}

extension MCVersionTypeExtension on MinecraftVersionType {
  String get name {
    switch (this) {
      case MinecraftVersionType.release:
        return 'release';
      case MinecraftVersionType.snapshot:
        return 'snapshot';
      case MinecraftVersionType.beta:
        return 'old_beta';
      case MinecraftVersionType.alpha:
        return 'old_alpha';
    }
  }
}
