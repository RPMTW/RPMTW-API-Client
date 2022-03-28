import "dart:convert";

import "package:rpmtw_api_client/src/api_client.dart";
import "package:rpmtw_api_client/src/models/api_model.dart";

class Storage implements APIModel {
  @override
  final String uuid;
  final String contentType;
  final String type;
  final DateTime createAt;
  final int usageCount;

  const Storage({
    required this.uuid,
    required this.contentType,
    required this.type,
    required this.createAt,
    required this.usageCount,
  });

  Storage copyWith({
    String? uuid,
    String? contentType,
    String? type,
    DateTime? createAt,
    int? usageCount,
  }) {
    return Storage(
      uuid: uuid ?? this.uuid,
      contentType: contentType ?? this.contentType,
      type: type ?? this.type,
      createAt: createAt ?? this.createAt,
      usageCount: usageCount ?? this.usageCount,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "uuid": uuid,
      "contentType": contentType,
      "type": type,
      "createAt": createAt.millisecondsSinceEpoch,
      "usageCount": usageCount,
    };
  }

  factory Storage.fromMap(Map<String, dynamic> map) {
    return Storage(
      uuid: map["uuid"],
      contentType: map["contentType"],
      type: map["type"],
      createAt:
          DateTime.fromMillisecondsSinceEpoch(map["createAt"], isUtc: true),
      usageCount: map["usageCount"]?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Storage.fromJson(String source) =>
      Storage.fromMap(json.decode(source));

  @override
  String toString() {
    return "Storage(uuid: $uuid, contentType: $contentType, type: $type, createAt: $createAt, usageCount: $usageCount)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Storage &&
        other.uuid == uuid &&
        other.contentType == contentType &&
        other.type == type &&
        other.createAt == createAt &&
        other.usageCount == usageCount;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        contentType.hashCode ^
        type.hashCode ^
        createAt.hashCode ^
        usageCount.hashCode;
  }

  static Future<Storage> getByUUID(String uuid) =>
      RPMTWApiClient.instance.storageResource.getStorage(uuid);

  /// Get download url of the storage
  ///
  /// **Parameters**
  /// - [uuid] uuid of the storage
  /// - [apiBaseUrl] api base url (optional)
  static String getDownloadUrl(String uuid, {String? apiBaseUrl}) {
    apiBaseUrl ??= RPMTWApiClient.instance.apiBaseUrl;
    return "$apiBaseUrl/storage/$uuid/download";
  }
}
