import 'dart:convert';

import 'package:http/http.dart';
import 'package:rpmtw_api_client/rpmtw_api_client.dart';
import 'package:rpmtw_api_client/src/http/api_http_client.dart';
import 'package:rpmtw_api_client/src/http/api_http_response.dart';
import 'package:rpmtw_api_client/src/resources/api_resource.dart';

String? _cfCoreApiKey;

/// CurseForge API Documentation: https://docs.curseforge.com
class CurseForgeResource extends APIResource {
  const CurseForgeResource(APIHttpClient httpClient) : super(httpClient);

  Future<dynamic> _get(
      {required String path,
      Map<String, String>? query,
      int apiVersion = 1}) async {
    String _path =
        'v$apiVersion/$path?${query?.entries.map((e) => '${e.key}=${e.value}').join('%26')}';

    if (_cfCoreApiKey != null) {
      Uri uri = Uri(scheme: 'https', host: 'api.curseforge.com', path: _path);
      Response response = await get(uri, headers: {
        'X-Api-Key': _cfCoreApiKey!,
      });

      try {
        return json.decode(response.body);
      } catch (e) {
        return null;
      }
    } else {
      APIHttpResponse response =
          await httpClient.get('/curseforge/', query: {'path': _path});
      return response.data;
    }
  }

  Future<dynamic> _post(
      {required String path, required Map body, int apiVersion = 1}) async {
    String _path = 'v$apiVersion/$path';

    if (_cfCoreApiKey != null) {
      Uri uri = Uri(scheme: 'https', host: 'api.curseforge.com', path: _path);
      Response response = await post(uri, body: json.encode(body), headers: {
        'X-Api-Key': _cfCoreApiKey!,
      });

      try {
        return json.decode(response.body);
      } catch (e) {
        return null;
      }
    } else {
      APIHttpResponse response = await httpClient.post('/curseforge/',
          query: {'path': _path}, body: json.encode(body));
      return response.data;
    }
  }

  void setApiKey(String? apiKey) {
    _cfCoreApiKey = apiKey;
  }

  /// Get a single mod.
  Future<CurseForgeMod> getMod(int modID) async {
    return CurseForgeMod.fromMap(
        (await _get(path: 'mods/$modID')).cast<String, dynamic>()['data']);
  }

  /// Get a list of mods.
  Future<List<CurseForgeMod>> getMods(List<int> modIds) async {
    Map<String, dynamic> data =
        (await _post(path: 'mods', body: {'modIds': modIds}))
            .cast<String, dynamic>();

    return (data['data'] as List)
        .map((mod) => CurseForgeMod.fromMap(mod))
        .toList();
  }

  /// Get all mods that match the search criteria.
  Future<List<CurseForgeMod>> searchMods(
      {required CurseForgeGames game,
      int? classId,
      int? categoryId,
      String? gameVersion,
      String? searchFilter,
      CurseForgeSortField? sortField,
      CurseForgeSortOrder sortOrder = CurseForgeSortOrder.desc,
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
      if (sortField != null) 'sortField': sortField.value.toString(),
      'sortOrder': sortOrder.name,
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

  /// Get the full description of a mod in HTML format.
  Future<String> getModDescription(int modID) async {
    Map<String, dynamic> data =
        (await _get(path: 'mods/$modID/description')).cast<String, dynamic>();

    return data['data'];
  }

  /// Get a single file of the specified mod.
  Future<CurseForgeModFile> getModFile(int modID, int fileID) async {
    Map<String, dynamic> data =
        (await _get(path: 'mods/$modID/files/$fileID')).cast<String, dynamic>();

    return CurseForgeModFile.fromMap(data['data']);
  }

  /// Get all files of the specified mod.
  Future<List<CurseForgeModFile>> getModFiles(int modID,
      {String? gameVersion,
      CurseForgeModLoaderType? modLoaderType,
      String? gameVersionTypeId,
      int? index,
      int? pageSize}) async {
    Map<String, dynamic> data =
        (await _get(path: 'mods/$modID/files', query: {}))
            .cast<String, dynamic>();

    return (data['data'] as List)
        .map((file) => CurseForgeModFile.fromMap(file))
        .toList();
  }

  /// Get a list of files.
  Future<List<CurseForgeModFile>> getFiles(List<int> fileIds) async {
    Map<String, dynamic> data =
        (await _post(path: 'mods/files', body: {'fileIds': fileIds}))
            .cast<String, dynamic>();

    return (data['data'] as List)
        .map((file) => CurseForgeModFile.fromMap(file))
        .toList();
  }

  /// Get the changelog of a file in HTML format.
  Future<String> getModFileChangelog(int modId, int fileID) async {
    Map<String, dynamic> data =
        (await _get(path: 'mods/$modId/files/$fileID/changelog'))
            .cast<String, dynamic>();

    return data['data'];
  }

  /// Get a download url for a specific file.
  Future<String> getModFileDownloadUrl(int modID, int fileID) async {
    Map<String, dynamic> data =
        (await _get(path: 'mods/$modID/files/$fileID/download-url'))
            .cast<String, dynamic>();

    return data['data'];
  }

  /// Get mod files that match a list of fingerprints.
  Future<List<CurseForgeModFile>> getFilesByFingerprint(
      List<int> fingerprints) async {
    Map<String, dynamic> data = (await _post(
            path: 'fingerprints', body: {'fingerprints': fingerprints}))
        .cast<String, dynamic>();

    return (data['data']['exactMatches'] as List)
        .map((file) => CurseForgeModFile.fromMap(file['file']))
        .toList();
  }

  /// Get mod files that match a list of fingerprints using fuzzy matching.
  Future<List<CurseForgeModFile>> getFilesByFingerprintFuzzy(
      CurseForgeGames game,
      List<CurseForgeFolderFingerprint> fingerprints) async {
    Map<String, dynamic> data = (await _post(path: 'fingerprints/fuzzy', body: {
      'gameId': game.id,
      'fingerprints': fingerprints.map((e) => e.toMap()).toList()
    }))
        .cast<String, dynamic>();

    return (data['data']['fuzzyMatches'] as List)
        .map((file) => CurseForgeModFile.fromMap(file['file']))
        .toList();
  }

  /// Get all available classes and categories of the specified game. Specify a game id for a list of all game categories, or a class id for a list of categories under that class.
  Future<List<CurseForgeCategory>> getCategories(
      {required CurseForgeGames game, int? classId}) async {
    Map<String, dynamic> data = (await _get(path: 'categories', query: {
      'gameId': game.id.toString(),
      if (classId != null) 'classId': classId.toString()
    }))
        .cast<String, dynamic>();

    return (data['data'] as List)
        .map((category) => CurseForgeCategory.fromMap(category))
        .toList();
  }

  /// Get minecraft game versions
  Future<List<CurseForgeMinecraftGameVersion>> getMinecraftVersions() async {
    Map<String, dynamic> data =
        (await _get(path: 'minecraft/version')).cast<String, dynamic>();

    return (data['data'] as List)
        .map((version) => CurseForgeMinecraftGameVersion.fromMap(version))
        .toList();
  }

  /// Get specific minecraft game version
  Future<CurseForgeMinecraftGameVersion> getMinecraftVersion(
      String gameVersionString) async {
    Map<String, dynamic> data =
        (await _get(path: 'minecraft/version/$gameVersionString'))
            .cast<String, dynamic>();

    return CurseForgeMinecraftGameVersion.fromMap(data['data']);
  }
}
