import 'package:http/http.dart';

abstract class BaseResource {
  Client httpClient;
  String baseUrl;
  String? globalToken;

  BaseResource(
      {required this.httpClient,
      required this.baseUrl,
      required this.globalToken});
}
