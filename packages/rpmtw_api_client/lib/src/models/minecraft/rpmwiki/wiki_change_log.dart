import 'dart:convert';

import 'package:rpmtw_api_client/src/models/auth/user.dart';
import 'package:rpmtw_api_client/src/models/base_model.dart';
import 'package:rpmtw_api_client/src/models/minecraft/minecraft_mod.dart';

class WikiChangeLog implements BaseModel {
  final String uuid;

  /// 變更日誌
  final String? changeLog;

  /// 修改類型
  final WikiChangeLogType type;

  /// 修改的資料 (可能是 [MinecraftMod] 的 UUID )
  final String dataUUID;

  final String userUUID;

  Future<User> get user => User.getUserByUUID(userUUID);

  final DateTime time;
  WikiChangeLog({
    this.changeLog,
    required this.type,
    required this.dataUUID,
    required this.userUUID,
    required this.time,
    required this.uuid,
  });

  WikiChangeLog copyWith({
    String? changeLog,
    WikiChangeLogType? type,
    String? dataUUID,
    String? userUUID,
    DateTime? time,
    String? uuid,
  }) {
    return WikiChangeLog(
      changeLog: changeLog ?? this.changeLog,
      type: type ?? this.type,
      dataUUID: dataUUID ?? this.dataUUID,
      userUUID: userUUID ?? this.userUUID,
      time: time ?? this.time,
      uuid: uuid ?? this.uuid,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'changeLog': changeLog,
      'type': type.name,
      'dataUUID': dataUUID,
      'userUUID': userUUID,
      'time': time.millisecondsSinceEpoch,
      'uuid': uuid,
    };
  }

  factory WikiChangeLog.fromMap(Map<String, dynamic> map) {
    return WikiChangeLog(
      changeLog: map['changeLog'],
      type: WikiChangeLogType.values.byName(map['type']),
      dataUUID: map['dataUUID'] ?? '',
      userUUID: map['userUUID'] ?? '',
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      uuid: map['uuid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WikiChangeLog.fromJson(String source) =>
      WikiChangeLog.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WikiChangeLog(changeLog: $changeLog, type: $type, dataUUID: $dataUUID, userUUID: $userUUID, time: $time, uuid: $uuid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WikiChangeLog &&
        other.changeLog == changeLog &&
        other.type == type &&
        other.dataUUID == dataUUID &&
        other.userUUID == userUUID &&
        other.time == time &&
        other.uuid == uuid;
  }

  @override
  int get hashCode {
    return changeLog.hashCode ^
        type.hashCode ^
        dataUUID.hashCode ^
        userUUID.hashCode ^
        time.hashCode ^
        uuid.hashCode;
  }
}

enum WikiChangeLogType {
  // 新增模組
  addedMod,
  // 編輯模組
  modifiedMod,
  // 刪除模組
  removedMod,
}
