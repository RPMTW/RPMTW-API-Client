import 'package:http/http.dart';

abstract class BaseResource {
  Client httpClient;
  String apiBaseUrl;
  String? globalToken;

  BaseResource(
      {required this.httpClient,
      required this.apiBaseUrl,
      required this.globalToken});
}
