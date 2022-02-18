import 'dart:convert';

import 'package:rpmtw_api_client/src/api_client.dart';
import 'package:rpmtw_api_client/src/models/base_model.dart';

class Storage implements BaseModel {
  final String uuid;
  final String contentType;
  final String type;
  final int createAt;
  Storage({
    required this.uuid,
    required this.contentType,
    required this.type,
    required this.createAt,
  });

  Storage copyWith({
    String? uuid,
    String? contentType,
    String? type,
    int? createAt,
  }) {
    return Storage(
      uuid: uuid ?? this.uuid,
      contentType: contentType ?? this.contentType,
      type: type ?? this.type,
      createAt: createAt ?? this.createAt,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'contentType': contentType,
      'type': type,
      'createAt': createAt,
    };
  }

  factory Storage.fromMap(Map<String, dynamic> map) {
    return Storage(
      uuid: map['uuid'] ?? '',
      contentType: map['contentType'] ?? '',
      type: map['type'] ?? '',
      createAt: map['createAt']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Storage.fromJson(String source) =>
      Storage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Storage(uuid: $uuid, contentType: $contentType, type: $type, createAt: $createAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Storage &&
        other.uuid == uuid &&
        other.contentType == contentType &&
        other.type == type &&
        other.createAt == createAt;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        contentType.hashCode ^
        type.hashCode ^
        createAt.hashCode;
  }

  static String getDownloadUrl(String uuid, {String? baseUrl}) {
    baseUrl ??= RPMTWApiClient.instance.baseUrl;
    return '$baseUrl/storage/$uuid/download';
  }
}
