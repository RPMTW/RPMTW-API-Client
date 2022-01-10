import 'dart:convert';

import 'package:rpmtw_api_client/src/api_client.dart';
import 'package:rpmtw_api_client/src/models/base_model.dart';

class User extends BaseModel {
  final String uuid;
  final String username;
  final String email;
  final bool emailVerified;
  final String? avatarStorageUUID;

  String? avatarUrl(String baseUrl) => avatarStorageUUID == null
      ? null
      : '$baseUrl/storage/$avatarStorageUUID/download';

  User(
      {required this.uuid,
      required this.username,
      required this.email,
      required this.emailVerified,
      required this.avatarStorageUUID,
      required int status,
      required String message})
      : super(statusCode: status, statusMessage: message);

  User copyWith({
    String? uuid,
    String? username,
    String? email,
    bool? emailVerified,
    String? avatarStorageUUID,
    int? statusCode,
    String? statusMessage,
  }) {
    return User(
      uuid: uuid ?? this.uuid,
      username: username ?? this.username,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      avatarStorageUUID: avatarStorageUUID ?? this.avatarStorageUUID,
      status: statusCode ?? this.statusCode,
      message: statusMessage ?? this.statusMessage,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "status": statusCode,
      "message": statusMessage,
      "data": {
        'uuid': uuid,
        'username': username,
        'email': email,
        'emailVerified': emailVerified,
        'avatarStorageUUID': avatarStorageUUID,
      }
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    Map data = map['data'];
    return User(
      uuid: data['uuid'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      emailVerified: data['emailVerified'] ?? false,
      avatarStorageUUID: data['avatarStorageUUID'],
      status: map['status'] ?? 200,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(uuid: $uuid, username: $username, email: $email, emailVerified: $emailVerified, avatarStorageUUID: $avatarStorageUUID, status: $statusCode, message: $statusMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.uuid == uuid &&
        other.username == username &&
        other.email == email &&
        other.emailVerified == emailVerified &&
        other.avatarStorageUUID == avatarStorageUUID &&
        other.statusCode == statusCode &&
        other.statusMessage == statusMessage;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        username.hashCode ^
        email.hashCode ^
        emailVerified.hashCode ^
        avatarStorageUUID.hashCode ^
        statusCode.hashCode ^
        statusMessage.hashCode;
  }

  Future<String> getToken(String password) =>
      RPMTWApiClient.lastInstance.authResource
          .getToken(uuid: uuid, password: password);
}
