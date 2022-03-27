import "package:rpmtw_api_client/src/http/api_http_client.dart";
import "package:rpmtw_api_client/src/http/api_http_response.dart";
import "package:rpmtw_api_client/src/resources/base_resource.dart";

class OtherResource extends APIResource {
  const OtherResource(APIHttpClient httpClient) : super(httpClient);

  Future<String> helloWorld() async {
    APIHttpResponse response = await httpClient.get("/");
    return response.data["message"];
  }

  Future<String> getIP() async {
    APIHttpResponse response = await httpClient.get("/ip");
    return response.data["ip"];
  }
}
