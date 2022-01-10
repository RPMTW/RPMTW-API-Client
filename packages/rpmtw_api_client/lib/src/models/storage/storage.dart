import 'dart:convert';

import 'package:rpmtw_api_client/src/models/base_model.dart';

class Storage extends BaseModel {
  final String uuid;
  final String contentType;
  final String type;
  final int createAt;
  Storage({
    required this.uuid,
    required this.contentType,
    required this.type,
    required this.createAt,
    required int statusCode,
    required String statusMessage,
  }) : super(statusCode: statusCode, statusMessage: statusMessage);

  Storage copyWith({
    String? uuid,
    String? contentType,
    String? type,
    int? createAt,
    int? statusCode,
    String? statusMessage,
  }) {
    return Storage(
      uuid: uuid ?? this.uuid,
      contentType: contentType ?? this.contentType,
      type: type ?? this.type,
      createAt: createAt ?? this.createAt,
      statusCode: statusCode ?? this.statusCode,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'data': {
        'uuid': uuid,
        'contentType': contentType,
        'type': type,
        'createAt': createAt,
      },
      'status': statusCode,
      'message': statusMessage,
    };
  }

  factory Storage.fromMap(Map<String, dynamic> map) {
    Map data = map['data'];
    return Storage(
      uuid: data['uuid'] ?? '',
      contentType: data['contentType'] ?? '',
      type: data['type'] ?? '',
      createAt: data['createAt']?.toInt() ?? 0,
      statusCode: map['status']?.toInt() ?? 0,
      statusMessage: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Storage.fromJson(String source) =>
      Storage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Storage(uuid: $uuid, contentType: $contentType, type: $type, createAt: $createAt, statusCode: $statusCode, statusMessage: $statusMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Storage &&
        other.uuid == uuid &&
        other.contentType == contentType &&
        other.type == type &&
        other.createAt == createAt &&
        other.statusCode == statusCode &&
        other.statusMessage == statusMessage;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        contentType.hashCode ^
        type.hashCode ^
        createAt.hashCode ^
        statusCode.hashCode ^
        statusMessage.hashCode;
  }
}
