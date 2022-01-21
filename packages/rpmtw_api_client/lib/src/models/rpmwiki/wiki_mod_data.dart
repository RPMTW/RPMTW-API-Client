import 'dart:convert';

import 'package:rpmtw_api_client/src/models/base_model.dart';

class WikiModData implements BaseModel {
  final String uuid;

  /// 該模組的 UUID
  final String modUUID;

  /// 已翻譯過的模組名稱
  final String? translatedName;

  /// 模組的介紹文章 (Markdown 格式)
  final String? introduction;

  /// 模組的封面圖 (Storage UUID)
  final String? imageStorageUUID;

  const WikiModData({
    required this.uuid,
    required this.modUUID,
    this.translatedName,
    this.introduction,
    this.imageStorageUUID,
  });

  String? imageUrl(String baseUrl) => imageStorageUUID == null
      ? null
      : '$baseUrl/storage/$imageStorageUUID/download';

  WikiModData copyWith({
    String? uuid,
    String? modUUID,
    String? translatedName,
    String? introduction,
    String? imageStorageUUID,
  }) {
    return WikiModData(
      uuid: uuid ?? this.uuid,
      modUUID: modUUID ?? this.modUUID,
      translatedName: translatedName ?? this.translatedName,
      introduction: introduction ?? this.introduction,
      imageStorageUUID: imageStorageUUID ?? this.imageStorageUUID,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'modUUID': modUUID,
      'translatedName': translatedName,
      'introduction': introduction,
      'imageStorageUUID': imageStorageUUID,
    };
  }

  factory WikiModData.fromMap(Map<String, dynamic> map) {
    return WikiModData(
      uuid: map['uuid'] ?? '',
      modUUID: map['modUUID'] ?? '',
      translatedName: map['translatedName'],
      introduction: map['introduction'],
      imageStorageUUID: map['imageStorageUUID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WikiModData.fromJson(String source) =>
      WikiModData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WikiModData(uuid: $uuid, modUUID: $modUUID, translatedName: $translatedName, introduction: $introduction, imageStorageUUID: $imageStorageUUID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WikiModData &&
        other.uuid == uuid &&
        other.modUUID == modUUID &&
        other.translatedName == translatedName &&
        other.introduction == introduction &&
        other.imageStorageUUID == imageStorageUUID;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        modUUID.hashCode ^
        translatedName.hashCode ^
        introduction.hashCode ^
        imageStorageUUID.hashCode;
  }
}