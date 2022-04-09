import 'dart:convert';

import 'package:rpmtw_api_client/src/http/api_http_client.dart';
import 'package:rpmtw_api_client/src/http/api_http_response.dart';
import 'package:rpmtw_api_client/src/models/curseforge/curseforge_games.dart';
import 'package:rpmtw_api_client/src/models/curseforge/curseforge_mod.dart';
import 'package:rpmtw_api_client/src/models/curseforge/curseforge_mod_loader_type.dart';
import 'package:rpmtw_api_client/src/models/curseforge/curseforge_mods_search_sort.dart';
import 'package:rpmtw_api_client/src/models/curseforge/curseforge_sort_order.dart';
import 'package:rpmtw_api_client/src/resources/api_resource.dart';

/// CurseForge API Documentation: https://docs.curseforge.com
class CurseForgeResource extends APIResource {
  const CurseForgeResource(APIHttpClient httpClient) : super(httpClient);

  Future<dynamic> _get(
      {required String path,
      Map<String, String>? query,
      int apiVersion = 1}) async {
    final Uri uri = Uri(path: 'v$apiVersion/$path/', queryParameters: query);
    APIHttpResponse response = await httpClient
        .get('/curseforge/', query: {'path': '${uri.path}?${uri.query}'});

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
        (await _post(path: 'mods', body: {'modIds': ids}))
            .cast<Map<String, dynamic>>();

    return data.map((mod) => CurseForgeMod.fromMap(mod)).toList();
  }

  /// Get all mods that match the search criteria.
  Future<List<CurseForgeMod>> searchMods(
      {required CurseForgeGames game,
      int? classId,
      int? categoryId,
      String? gameVersion,
      String? searchFilter,
      CurseForgeModsSearchSort? sort,
      CurseForgeSortOrder? sortOrder,
      CurseForgeModLoaderType? modLoaderType,
      int? gameVersionTypeId,
      String? slug,
      int? index,
      int? pageSize}) async {
    Map data = (await _get(path: 'mods/search', query: {
      'gameId': game.id.toString(),
      if (classId != null) 'classId': classId.toString(),
      if (categoryId != null) 'categoryId': categoryId.toString(),
      if (gameVersion != null) 'gameVersion': gameVersion,
      if (searchFilter != null) 'searchFilter': searchFilter,
      if (sort != null) 'sort': sort.value.toString(),
      if (sortOrder != null) 'sortOrder': sortOrder.toJson(),
      if (modLoaderType != null)
        'modLoaderType': modLoaderType.value.toString(),
      if (gameVersionTypeId != null)
        'gameVersionTypeId': gameVersionTypeId.toString(),
      if (slug != null) 'slug': slug,
      if (index != null) 'index': index.toString(),
      if (pageSize != null) 'pageSize': pageSize.toString()
    }));

    return (data['data'] as List)
        .map((mod) => CurseForgeMod.fromMap(mod))
        .toList();
  }
}
