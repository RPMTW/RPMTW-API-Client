import 'package:dio/dio.dart';
import 'package:rpmtw_api_client/src/resources/auth_resource.dart';

class RPMTWApiClient {
  final Dio _httpClient;

  RPMTWApiClient({bool development = false}) : _httpClient = Dio() {
    _httpClient.options.baseUrl =
        development ? "http://0.0.0.0:8080" : 'https://api.rpmtw.com/';
  }

  AuthResource get authResource => AuthResource(httpClient: _httpClient);
}
