import 'dart:convert';

import 'package:rpmtw_api_client/src/api_client.dart';
import 'package:rpmtw_api_client/src/models/api_model.dart';
import 'package:rpmtw_api_client/src/models/auth/user.dart';

class TranslatorInfo implements APIModel {
  @override
  final String uuid;
  final String userUUID;
  final int translatedCount;
  final int votedCount;

  final DateTime joinAt;
  TranslatorInfo({
    required this.uuid,
    required this.userUUID,
    required this.translatedCount,
    required this.votedCount,
    required this.joinAt,
  });

  TranslatorInfo copyWith({
    String? uuid,
    String? userUUID,
    int? translatedCount,
    int? votedCount,
    DateTime? joinAt,
  }) {
    return TranslatorInfo(
      uuid: uuid ?? this.uuid,
      userUUID: userUUID ?? this.userUUID,
      translatedCount: translatedCount ?? this.translatedCount,
      votedCount: votedCount ?? this.votedCount,
      joinAt: joinAt ?? this.joinAt,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'userUUID': userUUID,
      'translatedCount': translatedCount,
      'votedCount': votedCount,
      'joinAt': joinAt.millisecondsSinceEpoch,
    };
  }

  factory TranslatorInfo.fromMap(Map<String, dynamic> map) {
    return TranslatorInfo(
        uuid: map['uuid'],
        userUUID: map['userUUID'],
        translatedCount: map['translatedCount'],
        votedCount: map['votedCount'],
        joinAt:
            DateTime.fromMillisecondsSinceEpoch(map['joinAt'], isUtc: true));
  }

  String toJson() => json.encode(toMap());

  factory TranslatorInfo.fromJson(String source) =>
      TranslatorInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TranslatorInfo(uuid: $uuid, userUUID: $userUUID, translatedCount: $translatedCount, votedCount: $votedCount, joinAt: $joinAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TranslatorInfo &&
        other.uuid == uuid &&
        other.userUUID == userUUID &&
        other.translatedCount == translatedCount &&
        other.votedCount == votedCount &&
        other.joinAt == joinAt;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        userUUID.hashCode ^
        translatedCount.hashCode ^
        votedCount.hashCode ^
        joinAt.hashCode;
  }

  static Future<TranslatorInfo> getByUUID(String uuid) =>
      RPMTWApiClient.instance.translateResource.getTranslatorInfo(uuid);

  static Future<TranslatorInfo> getByUserUUID(User user) =>
      RPMTWApiClient.instance.translateResource.getTranslatorInfoByUser(user);
}
