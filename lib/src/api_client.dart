import 'package:dio/dio.dart';
import 'package:rpmtw_api_client/rpmtw_api_client.dart';
import 'package:rpmtw_api_client/src/resources/auth_resource.dart';

class RPMTWApiClient {
  final Dio _httpClient;
  static late RPMTWApiClient _apiClient;

  RPMTWApiClient({bool development = false})
      : _httpClient = Dio(BaseOptions(validateStatus: (code) => true)) {
    _httpClient.options.baseUrl =
        development ? "http://0.0.0.0:8080" : 'https://api.rpmtw.com/';
    _apiClient = this;
  }

  AuthResource get authResource => AuthResource(httpClient: _httpClient);
  static RPMTWApiClient get lastInstance => _apiClient;
}
