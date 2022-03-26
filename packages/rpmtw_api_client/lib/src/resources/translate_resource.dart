import "package:http/http.dart";
import "package:rpmtw_api_client/src/resources/base_resource.dart";

class TranslateResource extends APIResource {
  TranslateResource(
      {required Client httpClient,
      required String apiBaseUrl,
      required String? token})
      : super(
            httpClient: httpClient, apiBaseUrl: apiBaseUrl, globalToken: token);
}
