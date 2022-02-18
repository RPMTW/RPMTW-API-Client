import 'dart:convert';

import 'package:rpmtw_api_client/src/api_client.dart';
import 'package:rpmtw_api_client/src/models/base_model.dart';
import 'package:rpmtw_api_client/src/models/storage/storage.dart';

class User implements BaseModel {
  final String uuid;
  final String username;
  final String email;
  final bool emailVerified;
  final String? avatarStorageUUID;

  String? avatarUrl() => avatarStorageUUID == null
      ? null
      : Storage.getDownloadUrl(avatarStorageUUID!);

  User({
    required this.uuid,
    required this.username,
    required this.email,
    required this.emailVerified,
    required this.avatarStorageUUID,
  });

  User copyWith({
    String? uuid,
    String? username,
    String? email,
    bool? emailVerified,
    String? avatarStorageUUID,
  }) {
    return User(
      uuid: uuid ?? this.uuid,
      username: username ?? this.username,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      avatarStorageUUID: avatarStorageUUID ?? this.avatarStorageUUID,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'username': username,
      'email': email,
      'emailVerified': emailVerified,
      'avatarStorageUUID': avatarStorageUUID,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uuid: map['uuid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      emailVerified: map['emailVerified'] ?? false,
      avatarStorageUUID: map['avatarStorageUUID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(uuid: $uuid, username: $username, email: $email, emailVerified: $emailVerified, avatarStorageUUID: $avatarStorageUUID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.uuid == uuid &&
        other.username == username &&
        other.email == email &&
        other.emailVerified == emailVerified &&
        other.avatarStorageUUID == avatarStorageUUID;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        username.hashCode ^
        email.hashCode ^
        emailVerified.hashCode ^
        avatarStorageUUID.hashCode;
  }

  Future<String> getToken(String password) =>
      RPMTWApiClient.instance.authResource
          .getToken(uuid: uuid, password: password);

  static Future<User> getUserByUUID(String uuid) =>
      RPMTWApiClient.instance.authResource.getUserByUUID(uuid);
}
