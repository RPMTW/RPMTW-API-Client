import "dart:convert";

import "package:collection/collection.dart";
import "package:rpmtw_api_client/src/api_client.dart";
import "package:rpmtw_api_client/src/models/auth/user_role.dart";
import "package:rpmtw_api_client/src/models/base_model.dart";
import "package:rpmtw_api_client/src/models/storage/storage.dart";

class User implements APIModel {
  @override
  final String uuid;
  final String username;
  final String email;
  final bool emailVerified;
  final String passwordHash;
  final String? avatarStorageUUID;
  final List<String> loginIPs;
  final UserRole role;

  const User({
    required this.uuid,
    required this.username,
    required this.email,
    required this.emailVerified,
    required this.passwordHash,
    this.avatarStorageUUID,
    required this.loginIPs,
    required this.role,
  });

  /// Get the user"s avatar url.
  /// if the user has no avatar, it will return null.
  String? avatarUrl() => avatarStorageUUID == null
      ? null
      : Storage.getDownloadUrl(avatarStorageUUID!);

  Future<String> getToken(String password) =>
      RPMTWApiClient.instance.authResource
          .getToken(uuid: uuid, password: password);

  User copyWith({
    String? uuid,
    String? username,
    String? email,
    bool? emailVerified,
    String? passwordHash,
    String? avatarStorageUUID,
    List<String>? loginIPs,
    UserRole? role,
  }) {
    return User(
      uuid: uuid ?? this.uuid,
      username: username ?? this.username,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      passwordHash: passwordHash ?? this.passwordHash,
      avatarStorageUUID: avatarStorageUUID ?? this.avatarStorageUUID,
      loginIPs: loginIPs ?? this.loginIPs,
      role: role ?? this.role,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "uuid": uuid,
      "username": username,
      "email": email,
      "emailVerified": emailVerified,
      "passwordHash": passwordHash,
      "avatarStorageUUID": avatarStorageUUID,
      "loginIPs": loginIPs,
      "role": role.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uuid: map["uuid"],
      username: map["username"],
      email: map["email"],
      emailVerified: map["emailVerified"] ?? false,
      passwordHash: map["passwordHash"],
      avatarStorageUUID: map["avatarStorageUUID"],
      loginIPs: List<String>.from(map["loginIPs"]),
      role: UserRole.fromMap(map["role"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return "User(uuid: $uuid, username: $username, email: $email, emailVerified: $emailVerified, passwordHash: $passwordHash, avatarStorageUUID: $avatarStorageUUID, loginIPs: $loginIPs, role: $role)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is User &&
        other.uuid == uuid &&
        other.username == username &&
        other.email == email &&
        other.emailVerified == emailVerified &&
        other.passwordHash == passwordHash &&
        other.avatarStorageUUID == avatarStorageUUID &&
        listEquals(other.loginIPs, loginIPs) &&
        other.role == role;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        username.hashCode ^
        email.hashCode ^
        emailVerified.hashCode ^
        passwordHash.hashCode ^
        avatarStorageUUID.hashCode ^
        loginIPs.hashCode ^
        role.hashCode;
  }

  static Future<User> getByUUID(String uuid) =>
      RPMTWApiClient.instance.authResource.getUserByUUID(uuid);
}
