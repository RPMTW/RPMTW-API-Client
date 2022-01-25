import 'dart:convert';

import 'package:rpmtw_api_client/src/models/auth/user.dart';
import 'package:rpmtw_api_client/src/models/base_model.dart';
import 'package:rpmtw_api_client/src/models/minecraft/minecraft_mod.dart';

class WikiChangelog implements BaseModel {
  final String uuid;

  /// 變更日誌
  final String? changelog;

  /// 修改類型
  final WikiChangelogType type;

  /// 修改的資料 UUID (可能是 [MinecraftMod] )
  final String dataUUID;

  /// 修改的資料內容 (可能是 [MinecraftMod] )
  final Map<String, dynamic> changedData;

  /// 修改前的資料內容 (可能是 [MinecraftMod] )
  final Map<String, dynamic>? unchangedData;

  final String userUUID;

  final DateTime time;

  Future<User> get user => User.getUserByUUID(userUUID);

  WikiChangelog({
    this.changelog,
    required this.type,
    required this.dataUUID,
    required this.changedData,
    this.unchangedData,
    required this.userUUID,
    required this.time,
    required this.uuid,
  });

  WikiChangelog copyWith({
    String? changelog,
    WikiChangelogType? type,
    String? dataUUID,
    Map<String, dynamic>? changedData,
    Map<String, dynamic>? unchangedData,
    String? userUUID,
    DateTime? time,
    String? uuid,
  }) {
    return WikiChangelog(
      changelog: changelog ?? this.changelog,
      type: type ?? this.type,
      dataUUID: dataUUID ?? this.dataUUID,
      changedData: changedData ?? this.changedData,
      unchangedData: unchangedData ?? this.unchangedData,
      userUUID: userUUID ?? this.userUUID,
      time: time ?? this.time,
      uuid: uuid ?? this.uuid,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'changelog': changelog,
      'type': type.name,
      'dataUUID': dataUUID,
      'changedData': json.encode(changedData),
      'unchangedData':
          unchangedData != null ? json.encode(unchangedData) : null,
      'userUUID': userUUID,
      'time': time.millisecondsSinceEpoch,
      'uuid': uuid,
    };
  }

  factory WikiChangelog.fromMap(Map<String, dynamic> map) {
    return WikiChangelog(
      changelog: map['changelog'],
      type: WikiChangelogType.values.byName(map['type']),
      dataUUID: map['dataUUID'] ?? '',
      changedData: map['changedData'],
      unchangedData: map['unchangedData'],
      userUUID: map['userUUID'] ?? '',
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      uuid: map['uuid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WikiChangelog.fromJson(String source) =>
      WikiChangelog.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WikiChangelog(changelog: $changelog, type: $type, dataUUID: $dataUUID, changedData: $changedData, unchangedData: $unchangedData, userUUID: $userUUID, time: $time, uuid: $uuid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WikiChangelog &&
        other.changelog == changelog &&
        other.type == type &&
        other.dataUUID == dataUUID &&
        other.changedData == changedData &&
        other.unchangedData == unchangedData &&
        other.userUUID == userUUID &&
        other.time == time &&
        other.uuid == uuid;
  }

  @override
  int get hashCode {
    return changelog.hashCode ^
        type.hashCode ^
        dataUUID.hashCode ^
        changedData.hashCode ^
        unchangedData.hashCode ^
        userUUID.hashCode ^
        time.hashCode ^
        uuid.hashCode;
  }
}

enum WikiChangelogType {
  // 新增模組
  addedMod,
  // 編輯模組
  editedMod,
  // 刪除模組
  removedMod,
}
