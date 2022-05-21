import 'package:rpmtw_api_client/src/http/api_http_client.dart';
import 'package:rpmtw_api_client/src/resources/auth_resource.dart';
import 'package:rpmtw_api_client/src/resources/comment_resource.dart';
import 'package:rpmtw_api_client/src/resources/universe_chat_resource.dart';
import 'package:rpmtw_api_client/src/resources/curseforge_resource.dart';
import 'package:rpmtw_api_client/src/resources/minecraft_resource.dart';
import 'package:rpmtw_api_client/src/resources/other_resource.dart';
import 'package:rpmtw_api_client/src/resources/storage_resource.dart';
import 'package:rpmtw_api_client/src/resources/translate_resource.dart';
import 'package:rpmtw_api_client/src/utilities/exceptions.dart';

class RPMTWApiClient {
  static String get version => '1.0.8-dev.6';

  late final APIHttpClient _httpClient;
  final String _apiBaseUrl;
  final String _universeChatBaseUrl;
  static RPMTWApiClient? _apiClient;

  String? _globalToken;

  /// Set the global token for all requests.
  ///
  /// *Example*
  /// ```dart
  /// RPMTWApiClient client = RPMTWApiClient.instance;
  /// client.setGlobalToken('my-token');
  /// ```
  void setGlobalToken(String value) => _globalToken = value;

  String get apiBaseUrl => _apiBaseUrl;
  String get universeChatBaseUrl => _universeChatBaseUrl;
  String? get apiGlobalToken => _globalToken;

  RPMTWApiClient(
      {bool development = false,
      String? apiBaseUrl,
      String? universeChatBaseUrl,
      String? token})
      : _apiBaseUrl = apiBaseUrl ??
            (development
                ? 'http://localhost:8080'
                : 'https://api.rpmtw.com:2096'),
        _universeChatBaseUrl = universeChatBaseUrl ??
            (development
                ? 'http://localhost:2087'
                : 'https://api.rpmtw.com:2087') {
    _apiClient = this;

    if (token != null) _globalToken = token;
    _httpClient = APIHttpClient(_apiBaseUrl);
  }

  AuthResource get authResource => AuthResource(_httpClient);
  StorageResource get storageResource => StorageResource(_httpClient);
  MinecraftResource get minecraftResource => MinecraftResource(_httpClient);
  OtherResource get otherResource => OtherResource(_httpClient);
  CurseForgeResource get curseforgeResource => CurseForgeResource(_httpClient);
  UniverseChatResource get universeChatResource =>
      UniverseChatResource(_httpClient,
          universeChatBaseUrl: _universeChatBaseUrl);
  TranslateResource get translateResource => TranslateResource(_httpClient);
  CommentResource get commentResource => CommentResource(_httpClient);

  static RPMTWApiClient get instance {
    if (_apiClient == null) {
      throw ClientUninitializedException();
    }
    return _apiClient!;
  }

  /// Initializes the client
  ///
  /// **Parameters**
  /// - [development] - Whether the client is in development mode
  /// - [apiBaseUrl] - The base url of the api
  /// - [universeChatBaseUrl] - The base url of the universe chat api
  /// - [token] - The global token
  ///
  /// **Example**
  /// ```dart
  /// RPMTWApiClient client = RPMTWApiClient.init();
  /// String message = await client.otherResource.helloWorld();
  /// print(message);
  /// ```
  static RPMTWApiClient init(
      {bool development = false,
      String? apiBaseUrl,
      String? universeChatBaseUrl,
      String? token}) {
    RPMTWApiClient client = RPMTWApiClient(
        development: development,
        apiBaseUrl: apiBaseUrl,
        universeChatBaseUrl: universeChatBaseUrl,
        token: token);
    _apiClient = client;
    return client;
  }
}
