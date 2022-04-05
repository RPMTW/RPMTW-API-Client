import 'package:rpmtw_api_client/src/http/api_http_client.dart';
import 'package:rpmtw_api_client/src/http/api_http_response.dart';
import 'package:rpmtw_api_client/src/models/auth/password_validated_result.dart';
import 'package:rpmtw_api_client/src/models/auth/user.dart';
import 'package:rpmtw_api_client/src/resources/api_resource.dart';

class AuthResource extends APIResource {
  const AuthResource(APIHttpClient httpClient) : super(httpClient);

  /// Get user info by uuid.
  ///
  /// - [uuid] user's uuid (When uuid is **me**, use token to get the user info of the token)
  /// - [token] (optional)
  Future<User> getUserByUUID(String uuid, {String? token}) async {
    APIHttpResponse response = await httpClient.get<User>('/auth/user/$uuid');
    return User.fromMap(response.data);
  }

  /// Get user info by email.
  Future<User> getUserByEmail(String email) async {
    APIHttpResponse response =
        await httpClient.get('/auth/user/get-by-email/$email');
    return User.fromMap(response.data);
  }

  /// Create a user account, if successful, will return token and user information.
  ///
  /// - [username] user's username
  /// - [password] user's password
  /// - [email] user's email address
  /// - [avatarStorageUUID] user's avatar storage uuid (optional)
  Future<CreateUserResult> createUser(
      {required String username,
      required String password,
      required String email,
      String? avatarStorageUUID}) async {
    Map postData = {'username': username, 'password': password, 'email': email};
    if (avatarStorageUUID != null) {
      postData['avatarStorageUUID'] = avatarStorageUUID;
    }
    APIHttpResponse response =
        await httpClient.post('/auth/user/create', body: postData);

    return CreateUserResult(
        token: response.data['token'], user: User.fromMap(response.data));
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
      postData['password'] = password;
    }
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

    APIHttpResponse response = await httpClient.post(
      '/auth/user/$uuid/update',
      body: postData,
    );

    return User.fromMap(response.data);
  }

  /// 透過密碼與 uuid，取得使用者的 token
  Future<String> getToken(
      {required String uuid, required String password}) async {
    Map postData = {'uuid': uuid, 'password': password};
    APIHttpResponse response =
        await httpClient.post('/auth/get-token', body: postData);

    return response.data['token'];
  }

  /// 驗證密碼格式
  Future<PasswordValidatedResult> validPassword(String password) async {
    try {
      APIHttpResponse response =
          await httpClient.get('/auth/valid-password', query: {
        'password': password,
      });

      return PasswordValidatedResult.fromMap(response.data);
    } catch (e) {
      throw Exception('Valid password failed');
    }
  }

  Future<bool> validAuthCode({required String email, required int code}) async {
    try {
      APIHttpResponse response = await httpClient.get('/auth/valid-auth-code',
          query: {'email': email, 'authCode': code.toString()});
      return response.data['isValid'];
    } catch (e) {
      throw Exception('Valid auth code failed');
    }
  }
}

class CreateUserResult {
  final String token;
  final User user;

  CreateUserResult({required this.token, required this.user});
}
