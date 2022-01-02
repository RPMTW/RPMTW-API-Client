import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rpmtw_api_client/src/models/auth/password_validated_result.dart';
import 'package:rpmtw_api_client/src/models/auth/user.dart';
import 'package:rpmtw_api_client/src/resources/base_resource.dart';
import 'package:rpmtw_api_client/src/utilities/extension.dart';

class AuthResource extends BaseResource {
  AuthResource({required Dio httpClient}) : super(httpClient: httpClient);

  Future<User> getUserByUUID(String uuid) async {
    Response response = await httpClient.get('/auth/user/$uuid');
    int statusCode = response.statusCode ?? 500;
    if (statusCode == HttpStatus.ok) {
      return User.fromJson(response.json);
    } else if (statusCode == HttpStatus.notFound) {
      throw Exception('User not found');
    } else {
      throw Exception('Get user failed');
    }
  }

  Future<User> getUserByEmail(String email) async {
    Response response = await httpClient.get('/auth/user/get-by-email/$email');
    int statusCode = response.statusCode ?? 500;
    if (statusCode == HttpStatus.ok) {
      return User.fromJson(response.json);
    } else if (statusCode == HttpStatus.notFound) {
      throw Exception('User not found');
    } else {
      throw Exception('Get user failed');
    }
  }

  /// 建立使用者帳號，如果建立成功將回傳 token
  Future<String> createUser(
      {required String username,
      required String password,
      required String email,
      String? avatarStorageUUID}) async {
    Map postData = {'username': username, 'password': password, 'email': email};
    if (avatarStorageUUID != null) {
      postData['avatarStorageUUID'] = avatarStorageUUID;
    }
    Response response =
        await httpClient.post('/auth/user/create', data: postData);
    int statusCode = response.statusCode ?? 500;

    if (statusCode == HttpStatus.ok) {
      return response.map['data']['token'];
    } else if (statusCode == HttpStatus.notFound) {
      throw Exception('User not found');
    } else {
      throw Exception('Create user failed');
    }
  }

  /// 更新使用者資訊，如果成功則回傳修改後的使用者資訊
  Future<User> updateUser(
      {required String uuid,
      required String password,
      String? newUsername,
      String? newPassword,
      String? newEmail,
      String? newAvatarStorageUUID}) async {
    Map postData = {
      "password": password,
    };
    if (newUsername != null) {
      postData['newUsername'] = newUsername;
    }
    if (newPassword != null) {
      postData['newPassword'] = newPassword;
    }
    if (newEmail != null) {
      postData['newEmail'] = newEmail;
    }
    if (newAvatarStorageUUID != null) {
      postData['newAvatarStorageUUID'] = newAvatarStorageUUID;
    }
    Response response =
        await httpClient.post('/auth/user/$uuid/update', data: postData);
    int statusCode = response.statusCode ?? 500;

    if (statusCode == HttpStatus.ok) {
      return User.fromJson(response.json);
    } else if (statusCode == HttpStatus.notFound) {
      throw Exception('User not found');
    } else {
      throw Exception('Update user failed');
    }
  }

  Future<String> getToken(
      {required String uuid, required String password}) async {
    Map postData = {'uuid': uuid, 'password': password};
    Response response =
        await httpClient.post('/auth/get-token', data: postData);
    int statusCode = response.statusCode ?? 500;

    if (statusCode == HttpStatus.ok) {
      return response.map['data']['token'];
    } else if (statusCode == HttpStatus.notFound) {
      throw Exception('User not found');
    } else {
      String message = response.map['message'];
      if (statusCode == 400 && message.contains("Password is incorrect")) {
        throw Exception('Password is incorrect');
      } else {
        throw Exception('Get token failed');
      }
    }
  }

  Future<PasswordValidatedResult> validPassword(String password) {
    return httpClient
        .get('/auth/valid-password?password=$password')
        .then((response) {
      int statusCode = response.statusCode ?? 500;
      if (statusCode == HttpStatus.ok) {
        return PasswordValidatedResult.fromMap(response.map['data']);
      } else {
        throw Exception('Valid password failed');
      }
    });
  }
}
