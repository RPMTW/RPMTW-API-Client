import "package:http/http.dart";

abstract class APIResource {
  Client httpClient;
  String apiBaseUrl;
  String? globalToken;

  APIResource(
      {required this.httpClient,
      required this.apiBaseUrl,
      required this.globalToken});
}
