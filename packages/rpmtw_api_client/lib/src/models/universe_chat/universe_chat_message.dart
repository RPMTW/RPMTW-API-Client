import 'dart:convert';

import 'package:rpmtw_api_client/src/api_client.dart';
import 'package:rpmtw_api_client/src/models/api_model.dart';

class UniverseChatMessage implements APIModel {
  @override
  final String uuid;

  /// Username (not a nickname, may be the username of RPMTW account, Minecraft account or Discord account)
  final String username;

  /// message content
  final String message;

  final String? nickname;

  final String? avatarUrl;

  /// message sent time (UTC+0)
  final DateTime sentAt;

  final UniverseChatUserType userType;

  /// Reply message uuid
  final String? replyMessageUUID;

  const UniverseChatMessage({
    required this.uuid,
    required this.username,
    required this.message,
    this.nickname,
    this.avatarUrl,
    required this.sentAt,
    required this.userType,
    this.replyMessageUUID,
  });

  UniverseChatMessage copyWith({
    String? uuid,
    String? username,
    String? message,
    String? nickname,
    String? avatarUrl,
    DateTime? sentAt,
    UniverseChatUserType? userType,
    String? replyMessageUUID,
  }) {
    return UniverseChatMessage(
      uuid: uuid ?? this.uuid,
      username: username ?? this.username,
      message: message ?? this.message,
      nickname: nickname ?? this.nickname,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      sentAt: sentAt ?? this.sentAt,
      userType: userType ?? this.userType,
      replyMessageUUID: replyMessageUUID ?? this.replyMessageUUID,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'username': username,
      'message': message,
      'nickname': nickname,
      'avatarUrl': avatarUrl,
      'sentAt': sentAt.millisecondsSinceEpoch,
      'userType': userType.name,
      'replyMessageUUID': replyMessageUUID,
    };
  }

  factory UniverseChatMessage.fromMap(Map<String, dynamic> map) {
    return UniverseChatMessage(
      uuid: map['uuid'],
      username: map['username'],
      message: map['message'],
      nickname: map['nickname'],
      avatarUrl: map['avatarUrl'],
      sentAt: DateTime.fromMillisecondsSinceEpoch(map['sentAt'], isUtc: true),
      userType: UniverseChatUserType.values.byName(map['userType']),
      replyMessageUUID: map['replyMessageUUID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UniverseChatMessage.fromJson(String source) =>
      UniverseChatMessage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UniverseChatMessage(uuid: $uuid, username: $username, message: $message, nickname: $nickname, avatarUrl: $avatarUrl, sentAt: $sentAt, userType: $userType, replyMessageUUID: $replyMessageUUID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UniverseChatMessage &&
        other.uuid == uuid &&
        other.username == username &&
        other.message == message &&
        other.nickname == nickname &&
        other.avatarUrl == avatarUrl &&
        other.sentAt == sentAt &&
        other.userType == userType &&
        other.replyMessageUUID == replyMessageUUID;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        username.hashCode ^
        message.hashCode ^
        nickname.hashCode ^
        avatarUrl.hashCode ^
        sentAt.hashCode ^
        userType.hashCode ^
        replyMessageUUID.hashCode;
  }

  static Future<UniverseChatMessage?> getByUUID(String uuid) async =>
      RPMTWApiClient.instance.universeChatResource.getMessage(uuid);
}

enum UniverseChatUserType {
  /// RPMTW account
  rpmtw,

  /// Minecraft account
  minecraft,

  /// Discord account
  discord,
}
