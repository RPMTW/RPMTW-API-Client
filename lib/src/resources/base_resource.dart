import 'package:http/http.dart';

abstract class BaseResource {
  Client httpClient;
  String baseUrl;

  BaseResource({required this.httpClient, required this.baseUrl});
}
