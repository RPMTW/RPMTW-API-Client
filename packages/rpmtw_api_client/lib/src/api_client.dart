import 'package:http/http.dart';
import 'package:rpmtw_api_client/rpmtw_api_client.dart';

class RPMTWApiClient {
  final Client _httpClient;
  final String _baseUrl;
  static late RPMTWApiClient _apiClient;

  String? _token;

  void addToken(String value) => _token = value;

  String get baseUrl => _baseUrl;

  RPMTWApiClient({bool development = false, String? baseUrl, String? token})
      : _httpClient = Client(),
        _baseUrl = baseUrl ??
            (development ? "http://0.0.0.0:8080" : 'https://api.rpmtw.com/') {
    _apiClient = this;

    if (token != null) _token = token;
  }

  AuthResource get authResource =>
      AuthResource(httpClient: _httpClient, baseUrl: _baseUrl, token: _token);
  StorageResource get storageResource => StorageResource(
      httpClient: _httpClient, baseUrl: _baseUrl, token: _token);

  static RPMTWApiClient get lastInstance => _apiClient;

  static void init({bool development = false, String? baseUrl}) {
    _apiClient = RPMTWApiClient(development: development, baseUrl: baseUrl);
  }
}
