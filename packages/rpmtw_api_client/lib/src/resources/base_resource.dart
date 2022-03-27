import "package:rpmtw_api_client/src/http/api_http_client.dart";

abstract class APIResource {
  final APIHttpClient httpClient;

  const APIResource(this.httpClient);
}
