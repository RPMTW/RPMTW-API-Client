import "package:rpmtw_api_client/src/http/api_http_client.dart";

abstract class APIResource {
  APIHttpClient httpClient;

  APIResource(this.httpClient);
}
