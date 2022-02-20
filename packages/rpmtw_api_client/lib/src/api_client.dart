import 'package:http/http.dart';
import 'package:rpmtw_api_client/rpmtw_api_client.dart';

class RPMTWApiClient {
  final Client _httpClient;
  final String _apiBaseUrl;
  final String _cosmicChatBaseUrl;
  static RPMTWApiClient? _apiClient;

  String? _globalToken;

  /// Set the global token for all requests.
  /// 
  /// *Example*
  /// ```dart
  /// RPMTWApiClient client = RPMTWApiClient.instance;
  /// client.setGlobalToken("my-token");
  /// ```
  void setGlobalToken(String value) => _globalToken = value;

  String get apiBaseUrl => _apiBaseUrl;
  String get cosmicChatBaseUrl => _cosmicChatBaseUrl;
  String? get apiGlobalToken => _globalToken;

  RPMTWApiClient(
      {bool development = false,
      String? apiBaseUrl,
      String? cosmicChatBaseUrl,
      String? token})
      : _httpClient = Client(),
        _apiBaseUrl = apiBaseUrl ??
            (development
                ? "http://localhost:8080"
                : 'https://api.rpmtw.com:2096'),
        _cosmicChatBaseUrl = cosmicChatBaseUrl ??
            (development
                ? "http://localhost:2087"
                : 'https://api.rpmtw.com:2087') {
    _apiClient = this;

    if (token != null) _globalToken = token;
  }

  AuthResource get authResource => AuthResource(
      httpClient: _httpClient, apiBaseUrl: _apiBaseUrl, token: _globalToken);
  StorageResource get storageResource => StorageResource(
      httpClient: _httpClient, apiBaseUrl: _apiBaseUrl, token: _globalToken);
  MinecraftResource get minecraftResource => MinecraftResource(
      httpClient: _httpClient, apiBaseUrl: _apiBaseUrl, token: _globalToken);
  OtherResource get otherResource => OtherResource(
      httpClient: _httpClient, apiBaseUrl: _apiBaseUrl, token: _globalToken);
  CurseForgeResource get curseforgeResource => CurseForgeResource(
      httpClient: _httpClient, apiBaseUrl: _apiBaseUrl, token: _globalToken);
  CosmicChatResource get cosmicChatResource => CosmicChatResource(
      httpClient: _httpClient,
      apiBaseUrl: _apiBaseUrl,
      cosmicChatBaseUrl: _cosmicChatBaseUrl,
      token: _globalToken);

  static RPMTWApiClient get instance {
    if (_apiClient == null) {
      throw ClientUninitializedException();
    }
    return _apiClient!;
  }

  /// Initializes the client
  ///
  /// **Parameters**
  /// * [development] - Whether the client is in development mode
  /// * [apiBaseUrl] - The base url of the api
  /// * [cosmicChatBaseUrl] - The base url of the cosmic chat api
  /// * [token] - The global token
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
      String? cosmicChatBaseUrl,
      String? token}) {
    RPMTWApiClient client = RPMTWApiClient(
        development: development,
        apiBaseUrl: apiBaseUrl,
        cosmicChatBaseUrl: cosmicChatBaseUrl,
        token: token);
    _apiClient = client;
    return client;
  }
}
