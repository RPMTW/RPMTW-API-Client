import "package:rpmtw_api_client/src/http/api_http_client.dart";
import "package:rpmtw_api_client/src/http/api_http_response.dart";
import "package:rpmtw_api_client/src/models/curseforge/curseforge_mod.dart";
import 'package:rpmtw_api_client/src/resources/api_resource.dart';

class CurseForgeResource extends APIResource {
  const CurseForgeResource(APIHttpClient httpClient) : super(httpClient);

  Future<Map> get({required String path, int apiVersion = 1}) async {
    APIHttpResponse response = await httpClient
        .get("/curseforge/", query: {"path": "v$apiVersion/$path"});
    return response.data;
  }

  Future<CurseForgeMod> getMod(int id) async {
    return CurseForgeMod.fromMap(
        (await get(path: "mods/$id")).cast<String, dynamic>()["data"]);
  }
}
