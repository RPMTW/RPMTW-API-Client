import "dart:io";

import "package:http/http.dart";
import "package:rpmtw_api_client/src/models/curseforge/curseforge_mod.dart";
import "package:rpmtw_api_client/src/resources/base_resource.dart";
import "package:rpmtw_api_client/src/utilities/extension.dart";

class CurseForgeResource extends APIResource {
  CurseForgeResource(
      {required Client httpClient,
      required String apiBaseUrl,
      required String? token})
      : super(
            httpClient: httpClient, apiBaseUrl: apiBaseUrl, globalToken: token);

  Future<Map> get({required String path, int apiVersion = 1}) async {
    Response response = await httpClient.get(
        Uri.parse("$apiBaseUrl/curseforge/")
            .replace(queryParameters: {"path": "v$apiVersion/$path"}));
    int statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      return response.map["data"];
    } else {
      throw Exception("Failed to get data");
    }
  }

  Future<CurseForgeMod> getMod(int id) async {
    return CurseForgeMod.fromMap(
        (await get(path: "mods/$id")).cast<String, dynamic>()["data"]);
  }
}
