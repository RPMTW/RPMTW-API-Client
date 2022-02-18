import 'package:http/http.dart';
import 'package:rpmtw_api_client/rpmtw_api_client.dart';

class RPMTWApiClient {
  final Client _httpClient;
  final String _baseUrl;
  static RPMTWApiClient? _apiClient;

  String? _globalToken;

  void setGlobalToken(String value) => _globalToken = value;

  String get baseUrl => _baseUrl;

  RPMTWApiClient({bool development = false, String? baseUrl, String? token})
      : _httpClient = Client(),
        _baseUrl = baseUrl ??
            (development
                ? "http://0.0.0.0:8080"
                : 'https://api.rpmtw.com:2096') {
    _apiClient = this;

    if (token != null) _globalToken = token;
  }

  AuthResource get authResource => AuthResource(
      httpClient: _httpClient, baseUrl: _baseUrl, token: _globalToken);
  StorageResource get storageResource => StorageResource(
      httpClient: _httpClient, baseUrl: _baseUrl, token: _globalToken);
  MinecraftResource get minecraftResource => MinecraftResource(
      httpClient: _httpClient, baseUrl: _baseUrl, token: _globalToken);

  static RPMTWApiClient get instance {
    if (_apiClient == null) {
      throw Exception("client is not initialized, please call RPMTWApiClient.init() first");
    }
    return _apiClient!;
  }

  static void init({bool development = false, String? baseUrl}) {
    _apiClient = RPMTWApiClient(development: development, baseUrl: baseUrl);
  }
}
