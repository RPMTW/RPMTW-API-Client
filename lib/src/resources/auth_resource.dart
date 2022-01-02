import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rpmtw_api_client/src/models/user.dart';
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
}
