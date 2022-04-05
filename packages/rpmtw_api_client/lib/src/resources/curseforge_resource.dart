import 'dart:convert';

import 'package:rpmtw_api_client/src/http/api_http_client.dart';
import 'package:rpmtw_api_client/src/http/api_http_response.dart';
import 'package:rpmtw_api_client/src/models/curseforge/curseforge_mod.dart';
import 'package:rpmtw_api_client/src/resources/api_resource.dart';

/// CurseForge API Documentation: https://docs.curseforge.com
class CurseForgeResource extends APIResource {
  const CurseForgeResource(APIHttpClient httpClient) : super(httpClient);

  Future<dynamic> _get(
      {required String path,
      Map<String, String>? query,
      int apiVersion = 1}) async {
    final Uri uri = Uri(path: "v$apiVersion/$path/", queryParameters: query);
    APIHttpResponse response = await httpClient
        .get('/curseforge/', query: {'path': '${uri.path}${uri.query}'});
    return response.data;
  }

  Future<dynamic> _post(
      {required String path, required Map body, int apiVersion = 1}) async {
    APIHttpResponse response = await httpClient.post('/curseforge/',
        query: {'path': 'v$apiVersion/$path'}, body: json.encode(body));
    return response.data;
  }

  /// Get a single mod.
  Future<CurseForgeMod> getMod(int id) async {
    return CurseForgeMod.fromMap(
        (await _get(path: 'mods/$id')).cast<String, dynamic>()['data']);
  }

  /// Get a list of mods.
  Future<List<CurseForgeMod>> getMods(List<int> ids) async {
    List<Map<String, dynamic>> data =
        (await _post(path: 'mods', body: {"modIds": ids}))
            .cast<Map<String, dynamic>>();

    return data.map((mod) => CurseForgeMod.fromMap(mod)).toList();
  }

  /// Get all mods that match the search criteria.
  Future<List<CurseForgeMod>> searchMods({
    int? gameId,
    int? classId,
    int? categoryId,
    String? gameVersion,
    String? searchFilter
  }) async {
    List<Map<String, dynamic>> data =
        (await _get(path: 'mods/search', query: {

        }))
            .cast<Map<String, dynamic>>();

    return data.map((mod) => CurseForgeMod.fromMap(mod)).toList();
  }
}
