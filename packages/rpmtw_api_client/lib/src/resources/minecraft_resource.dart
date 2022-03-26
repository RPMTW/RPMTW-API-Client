import "dart:convert";
import "dart:io";

import "package:http/http.dart";
import "package:rpmtw_api_client/rpmtw_api_client.dart";
import "package:rpmtw_api_client/src/resources/base_resource.dart";
import "package:rpmtw_api_client/src/utilities/extension.dart";

class MinecraftResource extends APIResource {
  MinecraftResource(
      {required Client httpClient,
      required String apiBaseUrl,
      required String? token})
      : super(
            httpClient: httpClient, apiBaseUrl: apiBaseUrl, globalToken: token);

  /// 建立 Minecraft 模組，如果建立成功將回傳 Minecraft 模組資訊
  ///
  /// **必填參數**
  /// * [name] 模組名稱
  /// * [supportVersions] 該模組支援的 Minecraft 版本
  /// **選填參數**
  /// * [id] 模組 ID
  /// * [description] 模組描述
  /// * [relationMods] 關聯模組
  /// * [integration] 模組串連的平台
  /// * [side] 模組支援的執行環境
  /// * [translatedName] 模組譯名
  /// * [introduction] 模組介紹文
  /// * [imageStorageUUID] 模組封面圖的 Storage UUID
  Future<MinecraftMod> createMinecraftMod(
      {required String name,
      required List<String> supportVersions,
      String? id,
      String? description,
      List<RelationMod>? relationMods,
      ModIntegrationPlatform? integration,
      List<ModSide>? side,
      List<ModLoader>? loader,
      String? translatedName,
      String? introduction,
      String? imageStorageUUID,
      String? token}) async {
    if (token == null && globalToken == null) {
      throw UnauthorizedException();
    }

    Map postData = {"name": name, "supportVersions": supportVersions};

    if (id != null) {
      postData["id"] = id;
    }
    if (description != null) {
      postData["description"] = description;
    }
    if (relationMods != null) {
      postData["relationMods"] = relationMods.map((e) => e.toMap()).toList();
    }
    if (integration != null) {
      postData["integration"] = integration.toMap();
    }
    if (side != null) {
      postData["side"] = side.map((e) => e.toMap()).toList();
    }
    if (loader != null) {
      postData["loader"] = loader.map((e) => e.name).toList();
    }
    if (translatedName != null) {
      postData["translatedName"] = translatedName;
    }
    if (introduction != null) {
      postData["introduction"] = introduction;
    }
    if (imageStorageUUID != null) {
      postData["imageStorageUUID"] = imageStorageUUID;
    }

    Response response = await httpClient.post(
        Uri.parse("$apiBaseUrl/minecraft/mod/create"),
        headers: {"Authorization": "Bearer ${token ?? globalToken}"},
        body: json.encode(postData));
    int statusCode = response.statusCode;

    if (statusCode == HttpStatus.ok) {
      return MinecraftMod.fromMap(response.map["data"]);
    } else {
      if (statusCode == HttpStatus.badRequest ||
          statusCode == HttpStatus.unauthorized) {
        throw Exception(response.map["message"]);
      } else {
        throw Exception("Create minecraft mod failed ${response.body}");
      }
    }
  }

  /// 編輯 Minecraft 模組，如果編輯成功將回傳編輯後的 Minecraft 模組資訊
  ///
  /// **必填參數**
  /// * [uuid] 要編輯的模組 UUID
  /// **選填參數**
  /// * [name] 模組名稱
  /// * [supportVersions] 該模組支援的 Minecraft 版本
  /// * [id] 模組 ID
  /// * [description] 模組描述
  /// * [relationMods] 關聯模組
  /// * [integration] 模組串連的平台
  /// * [side] 模組支援的執行環境
  /// * [translatedName] 模組譯名
  /// * [introduction] 模組介紹文
  /// * [imageStorageUUID] 模組封面圖的 Storage UUID
  /// * [changelog] 變更日誌
  Future<MinecraftMod> editMinecraftMod(
      {required String uuid,
      String? name,
      List<String>? supportVersions,
      String? id,
      String? description,
      List<RelationMod>? relationMods,
      ModIntegrationPlatform? integration,
      List<ModSide>? side,
      List<ModLoader>? loader,
      String? translatedName,
      String? introduction,
      String? imageStorageUUID,
      String? changelog,
      String? token}) async {
    if (token == null && globalToken == null) {
      throw UnauthorizedException();
    }

    Map postData = {};

    if (name != null) {
      postData["name"] = name;
    }
    if (supportVersions != null) {
      postData["supportVersions"] = supportVersions;
    }
    if (id != null) {
      postData["id"] = id;
    }
    if (description != null) {
      postData["description"] = description;
    }
    if (relationMods != null) {
      postData["relationMods"] = relationMods.map((e) => e.toMap()).toList();
    }
    if (integration != null) {
      postData["integration"] = integration.toMap();
    }
    if (side != null) {
      postData["side"] = side.map((e) => e.toMap()).toList();
    }
    if (loader != null) {
      postData["loader"] = loader.map((e) => e.name).toList();
    }
    if (translatedName != null) {
      postData["translatedName"] = translatedName;
    }
    if (introduction != null) {
      postData["introduction"] = introduction;
    }
    if (imageStorageUUID != null) {
      postData["imageStorageUUID"] = imageStorageUUID;
    }
    if (changelog != null) {
      postData["changelog"] = changelog;
    }

    Response response = await httpClient.patch(
        Uri.parse("$apiBaseUrl/minecraft/mod/edit/$uuid"),
        headers: {"Authorization": "Bearer ${token ?? globalToken}"},
        body: json.encode(postData));
    int statusCode = response.statusCode;

    if (statusCode == HttpStatus.ok) {
      return MinecraftMod.fromMap(response.map["data"]);
    } else {
      if (statusCode == HttpStatus.badRequest ||
          statusCode == HttpStatus.unauthorized) {
        throw Exception(response.map["message"]);
      } else {
        throw Exception("Create minecraft mod failed ${response.body}");
      }
    }
  }

  /// 透過 UUID 取得 Minecraft 模組資訊
  /// [recordViewCount] 是否紀錄瀏覽次數
  Future<MinecraftMod> getMinecraftMod(String uuid,
      {bool recordViewCount = false}) async {
    Response response = await httpClient.get(Uri.parse(
        "$apiBaseUrl/minecraft/mod/view/$uuid?recordViewCount=$recordViewCount"));
    int statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      return MinecraftMod.fromMap(response.map["data"]);
    } else if (statusCode == HttpStatus.notFound) {
      throw ModelNotFoundException<MinecraftMod>();
    } else {
      throw Exception("Get Minecraft mod failed");
    }
  }

  /// 透過 模組名稱/模組譯名/模組 ID 來搜尋 Minecraft 模組
  /// [limit] 取得的資料數量 (預設為 50，最大為 50)
  /// [skip] 跳過的資料數量 (預設為 0)
  Future<List<MinecraftMod>> search(
      {String? filter,
      int? limit,
      int? skip,
      ModSortType sort = ModSortType.createTime}) async {
    Uri uri = Uri.parse("$apiBaseUrl/minecraft/mod/search");
    uri = uri.replace(queryParameters: {
      "filter": filter,
      "limit": limit?.toString(),
      "skip": skip?.toString(),
      "sort": sort.id.toString()
    });

    Response response = await httpClient.get(uri);
    int statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      Map map = response.map;
      Map data = map["data"];
      return List<MinecraftMod>.from((data["mods"] as List)
          .cast<Map<String, dynamic>>()
          .map((e) => MinecraftMod.fromMap(e)));
    } else {
      throw Exception("Search Minecraft mod failed");
    }
  }

  /// 查詢 RPMWiki 的變更日誌
  /// [limit] 取得的資料數量 (預設為 50，最大為 50)
  /// [skip] 跳過的資料數量 (預設為 0)
  /// [dataUUID] 要篩選的資料 UUID
  /// [userUUID] 要篩選的資料編輯者 UUID
  Future<List<WikiChangelog>> filterChangelogs(
      {int? limit, int? skip, String? dataUUID, String? userUUID}) async {
    Uri uri = Uri.parse("$apiBaseUrl/minecraft/changelog");
    uri = uri.replace(queryParameters: {
      "limit": limit?.toString(),
      "skip": skip?.toString(),
      "dataUUID": dataUUID,
      "userUUID": userUUID
    });
    Response response = await httpClient.get(uri);
    int statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      Map map = response.map;
      Map data = map["data"];
      return List<WikiChangelog>.from((data["changelogs"] as List)
          .cast<Map<String, dynamic>>()
          .map((e) => WikiChangelog.fromMap(e)));
    } else {
      throw Exception("Filter changelogs failed");
    }
  }

  /// 取得 Minecraft 版本資訊 (由 Mojang API 提供，RPMTW API 伺服器每天快取一次資料)
  Future<MinecraftVersionManifest> getMinecraftVersionManifest() async {
    Response response =
        await httpClient.get(Uri.parse("$apiBaseUrl/minecraft/versions"));
    int statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      return MinecraftVersionManifest.fromMap(response.map["data"]);
    } else {
      throw Exception("Get Minecraft version manifest failed");
    }
  }
}
