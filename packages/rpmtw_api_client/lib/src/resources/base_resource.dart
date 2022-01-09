import 'package:http/http.dart';

abstract class BaseResource {
  Client httpClient;
  String baseUrl;
  String? authToken;

  BaseResource({required this.httpClient, required this.baseUrl,required this.authToken});
}
