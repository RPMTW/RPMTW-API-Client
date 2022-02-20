import 'dart:convert';

import 'package:rpmtw_api_client/src/api_client.dart';
import 'package:rpmtw_api_client/src/models/base_model.dart';

class CosmicChatMessage extends BaseModel {
  final String uuid;

  /// Username (not a nickname, may be the username of RPMTW account, Minecraft account or Discord account)
  final String username;

  /// message content
  final String message;

  final String? nickname;

  final String avatarUrl;

  /// message sent time
  final DateTime sentAt;

  final CosmicChatUserType userType;

  /// Reply message uuid
  final String? replyMessageUUID;

  const CosmicChatMessage({
    required this.uuid,
    required this.username,
    required this.message,
    this.nickname,
    required this.avatarUrl,
    required this.sentAt,
    required this.userType,
    this.replyMessageUUID,
  });

  CosmicChatMessage copyWith({
    String? uuid,
    String? username,
    String? message,
    String? nickname,
    String? avatarUrl,
    DateTime? sentAt,
    CosmicChatUserType? userType,
    String? replyMessageUUID,
  }) {
    return CosmicChatMessage(
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

  factory CosmicChatMessage.fromMap(Map<String, dynamic> map) {
    return CosmicChatMessage(
      uuid: map['uuid'] ?? '',
      username: map['username'] ?? '',
      message: map['message'] ?? '',
      nickname: map['nickname'],
      avatarUrl: map['avatarUrl'] ?? '',
      sentAt: DateTime.fromMillisecondsSinceEpoch(map['sentAt']),
      userType: CosmicChatUserType.values.byName(map['userType']),
      replyMessageUUID: map['replyMessageUUID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CosmicChatMessage.fromJson(String source) =>
      CosmicChatMessage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CosmicChatMessage(uuid: $uuid, username: $username, message: $message, nickname: $nickname, avatarUrl: $avatarUrl, sentAt: $sentAt, userType: $userType, replyMessageUUID: $replyMessageUUID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CosmicChatMessage &&
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

  static Future<CosmicChatMessage?> getByUUID(String uuid) async =>
      RPMTWApiClient.instance.cosmicChatResource.getMessage(uuid);
}

enum CosmicChatUserType {
  /// RPMTW account
  rpmtw,

  /// Minecraft account
  minecraft,

  /// Discord account
  discord,
}
