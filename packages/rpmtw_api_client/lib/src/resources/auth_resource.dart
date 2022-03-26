import "dart:convert";
import "dart:io";

import "package:http/http.dart";
import "package:rpmtw_api_client/src/models/auth/password_validated_result.dart";
import "package:rpmtw_api_client/src/models/auth/user.dart";
import "package:rpmtw_api_client/src/resources/base_resource.dart";
import "package:rpmtw_api_client/src/utilities/exceptions.dart";
import "package:rpmtw_api_client/src/utilities/extension.dart";

class AuthResource extends APIResource {
  AuthResource(
      {required Client httpClient,
      required String apiBaseUrl,
      required String? token})
      : super(
            httpClient: httpClient, apiBaseUrl: apiBaseUrl, globalToken: token);

  /// Get user info by uuid.
  ///
  /// * [uuid] user"s uuid (When uuid is **me**, use token to get the user info of the token)
  /// * [token] (optional)
  Future<User> getUserByUUID(String uuid, {String? token}) async {
    Response response = await httpClient
        .get(Uri.parse("$apiBaseUrl/auth/user/$uuid"), headers: {
      if (globalToken != null || token != null)
        "Authorization": "Bearer ${token ?? globalToken}"
    });
    int statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      return User.fromMap(response.map["data"]);
    } else if (statusCode == HttpStatus.notFound) {
      throw ModelNotFoundException<User>();
    } else {
      throw Exception("Get user failed");
    }
  }

  /// Get user info by email.
  Future<User> getUserByEmail(String email) async {
    Response response = await httpClient
        .get(Uri.parse("$apiBaseUrl/auth/user/get-by-email/$email"));
    int statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      return User.fromMap(response.map["data"]);
    } else if (statusCode == HttpStatus.notFound) {
      throw ModelNotFoundException<User>();
    } else {
      throw Exception("Get user failed");
    }
  }

  /// Create a user account, if successful, will return token and user information.
  ///
  /// * [username] user"s username
  /// * [password] user"s password
  /// * [email] user"s email address
  /// * [avatarStorageUUID] user"s avatar storage uuid (optional)
  Future<CreateUserResult> createUser(
      {required String username,
      required String password,
      required String email,
      String? avatarStorageUUID}) async {
    Map postData = {"username": username, "password": password, "email": email};
    if (avatarStorageUUID != null) {
      postData["avatarStorageUUID"] = avatarStorageUUID;
    }
    Response response = await httpClient.post(
        Uri.parse("$apiBaseUrl/auth/user/create"),
        body: json.encode(postData));
    int statusCode = response.statusCode;

    if (statusCode == HttpStatus.ok) {
      String token = response.map["data"]["token"];
      return CreateUserResult(
          token: token, user: User.fromMap(response.map["data"]));
    } else {
      if (statusCode == HttpStatus.badRequest) {
        throw Exception(response.map["message"]);
      } else {
        throw Exception("Create user failed");
      }
    }
  }

  /// 更新使用者資訊，如果成功則回傳修改後的使用者資訊，如果未提供 [password] 則需要提供 [token]
  Future<User> updateUser(
      {required String uuid,
      String? token,
      String? password,
      String? newUsername,
      String? newPassword,
      String? newEmail,
      String? newAvatarStorageUUID}) async {
    Map postData = {};
    if (password != null) {
      postData["password"] = password;
    }
    if (newUsername != null) {
      postData["newUsername"] = newUsername;
    }
    if (newPassword != null) {
      postData["newPassword"] = newPassword;
    }
    if (newEmail != null) {
      postData["newEmail"] = newEmail;
    }
    if (newAvatarStorageUUID != null) {
      postData["newAvatarStorageUUID"] = newAvatarStorageUUID;
    }
    Response response = await httpClient.post(
      Uri.parse("$apiBaseUrl/auth/user/$uuid/update"),
      headers: {
        if (globalToken != null || token != null)
          "Authorization": "Bearer ${token ?? globalToken}"
      },
      body: json.encode(postData),
    );
    int statusCode = response.statusCode;

    if (statusCode == HttpStatus.ok) {
      return User.fromMap(response.map["data"]);
    } else if (statusCode == HttpStatus.notFound) {
      throw ModelNotFoundException<User>();
    } else if (statusCode == HttpStatus.unauthorized) {
      throw UnauthorizedException();
    } else {
      throw Exception("Update user failed ${response.body}");
    }
  }

  /// 透過密碼與 uuid，取得使用者的 token
  Future<String> getToken(
      {required String uuid, required String password}) async {
    Map postData = {"uuid": uuid, "password": password};
    Response response = await httpClient.post(
        Uri.parse("$apiBaseUrl/auth/get-token"),
        body: json.encode(postData));
    int statusCode = response.statusCode;

    if (statusCode == HttpStatus.ok) {
      return response.map["data"]["token"];
    } else if (statusCode == HttpStatus.notFound) {
      throw ModelNotFoundException<User>();
    } else {
      String message = response.map["message"];
      if (statusCode == HttpStatus.badRequest &&
          message.contains("Password is incorrect")) {
        throw Exception("Password is incorrect");
      } else {
        throw Exception("Get token failed");
      }
    }
  }

  /// 驗證密碼格式
  Future<PasswordValidatedResult> validPassword(String password) {
    return httpClient
        .get(Uri.parse("$apiBaseUrl/auth/valid-password?password=$password"))
        .then((response) {
      int statusCode = response.statusCode;
      if (statusCode == HttpStatus.ok) {
        return PasswordValidatedResult.fromJson(response.json);
      } else {
        throw Exception("Valid password failed");
      }
    });
  }

  Future<bool> validAuthCode({required String email, required int code}) {
    return httpClient
        .get(Uri.parse(
            "$apiBaseUrl/auth/valid-auth-code?email=$email&authCode=${code.toString()}"))
        .then((response) {
      int statusCode = response.statusCode;
      if (statusCode == HttpStatus.ok) {
        Map data = response.map["data"];
        return data["isValid"];
      } else {
        throw Exception("Valid auth code failed");
      }
    });
  }
}

class CreateUserResult {
  final String token;
  final User user;

  CreateUserResult({required this.token, required this.user});
}
