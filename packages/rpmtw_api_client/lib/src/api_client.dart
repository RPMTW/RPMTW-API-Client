import 'package:http/http.dart';
import 'package:rpmtw_api_client/rpmtw_api_client.dart';
import 'package:rpmtw_api_client/src/resources/curseforge_resource.dart';
import 'package:rpmtw_api_client/src/resources/other_resource.dart';

class RPMTWApiClient {
  final Client _httpClient;
  final String _baseUrl;
  static RPMTWApiClient? _apiClient;

  String? _globalToken;

  void setGlobalToken(String value) => _globalToken = value;

  String get baseUrl => _baseUrl;
  String? get apiGlobalToken => _globalToken;

  RPMTWApiClient({bool development = false, String? baseUrl, String? token})
      : _httpClient = Client(),
        _baseUrl = baseUrl ??
            (development
                ? "http://localhost:8080"
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
  OtherResource get otherResource => OtherResource(
      httpClient: _httpClient, baseUrl: _baseUrl, token: _globalToken);
  CurseForgeResource get curseforgeResource => CurseForgeResource(
      httpClient: _httpClient, baseUrl: _baseUrl, token: _globalToken);

  static RPMTWApiClient get instance {
    if (_apiClient == null) {
      throw ClientUninitializedException();
    }
    return _apiClient!;
  }

  static void init({bool development = false, String? baseUrl, String? token}) {
    _apiClient = RPMTWApiClient(
        development: development, baseUrl: baseUrl, token: token);
  }
}
