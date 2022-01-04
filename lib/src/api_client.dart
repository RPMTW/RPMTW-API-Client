import 'package:http/http.dart';
import 'package:rpmtw_api_client/rpmtw_api_client.dart';

class RPMTWApiClient {
  final Client _httpClient;
  late final String _baseUrl;
  static late RPMTWApiClient _apiClient;

  RPMTWApiClient({bool development = false}) : _httpClient = Client() {
    _baseUrl = development ? "http://0.0.0.0:8080" : 'https://api.rpmtw.com/';
    _apiClient = this;
  }

  AuthResource get authResource =>
      AuthResource(httpClient: _httpClient, baseUrl: _baseUrl);
  StorageResource get storageResource =>
      StorageResource(httpClient: _httpClient, baseUrl: _baseUrl);

  static RPMTWApiClient get lastInstance => _apiClient;
}
