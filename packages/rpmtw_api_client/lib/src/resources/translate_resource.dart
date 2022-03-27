import "package:rpmtw_api_client/src/http/api_http_client.dart";
import "package:rpmtw_api_client/src/http/api_http_response.dart";
import "package:rpmtw_api_client/src/models/translate/translation_vote.dart";
import "package:rpmtw_api_client/src/resources/base_resource.dart";

class TranslateResource extends APIResource {
  TranslateResource(APIHttpClient httpClient) : super(httpClient);

  Future<TranslationVote> getVote(String uuid) async {
    APIHttpResponse response = await httpClient.get("/translate/vote/$uuid");
    return TranslationVote.fromMap(response.data);
  }
}
