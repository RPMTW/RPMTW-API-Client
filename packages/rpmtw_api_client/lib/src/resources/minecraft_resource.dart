import "package:rpmtw_api_client/src/http/api_http_client.dart";
import "package:rpmtw_api_client/src/http/api_http_response.dart";
import "package:rpmtw_api_client/src/models/minecraft/minecraft_mod.dart";
import "package:rpmtw_api_client/src/models/minecraft/minecraft_version_manifest.dart";
import "package:rpmtw_api_client/src/models/minecraft/mod_integration.dart";
import "package:rpmtw_api_client/src/models/minecraft/mod_side.dart";
import "package:rpmtw_api_client/src/models/minecraft/relation_mod.dart";
import "package:rpmtw_api_client/src/models/minecraft/rpmwiki/wiki_change_log.dart";
import "package:rpmtw_api_client/src/resources/base_resource.dart";
import "package:rpmtw_api_client/src/utilities/exceptions.dart";

class MinecraftResource extends APIResource {
  MinecraftResource(APIHttpClient httpClient) : super(httpClient);

  /// 建立 Minecraft 模組，如果建立成功將回傳 Minecraft 模組資訊
  ///
  /// **必填參數**
  /// - [name] 模組名稱
  /// - [supportVersions] 該模組支援的 Minecraft 版本
  /// **選填參數**
  /// - [id] 模組 ID
  /// - [description] 模組描述
  /// - [relationMods] 關聯模組
  /// - [integration] 模組串連的平台
  /// - [side] 模組支援的執行環境
  /// - [translatedName] 模組譯名
  /// - [introduction] 模組介紹文
  /// - [imageStorageUUID] 模組封面圖的 Storage UUID
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
    if (token == null && httpClient.globalToken == null) {
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

    APIHttpResponse response =
        await httpClient.post("/minecraft/mod/create", body: postData);

    return MinecraftMod.fromMap(response.data);
  }

  /// 編輯 Minecraft 模組，如果編輯成功將回傳編輯後的 Minecraft 模組資訊
  ///
  /// **必填參數**
  /// - [uuid] 要編輯的模組 UUID
  /// **選填參數**
  /// - [name] 模組名稱
  /// - [supportVersions] 該模組支援的 Minecraft 版本
  /// - [id] 模組 ID
  /// - [description] 模組描述
  /// - [relationMods] 關聯模組
  /// - [integration] 模組串連的平台
  /// - [side] 模組支援的執行環境
  /// - [translatedName] 模組譯名
  /// - [introduction] 模組介紹文
  /// - [imageStorageUUID] 模組封面圖的 Storage UUID
  /// - [changelog] 變更日誌
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
    if (token == null && httpClient.globalToken == null) {
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

    APIHttpResponse response =
        await httpClient.patch("/minecraft/mod/edit/$uuid", body: postData);

    return MinecraftMod.fromMap(response.data);
  }

  /// 透過 UUID 取得 Minecraft 模組資訊
  /// [recordViewCount] 是否紀錄瀏覽次數
  Future<MinecraftMod> getMinecraftMod(String uuid,
      {bool recordViewCount = false}) async {
    APIHttpResponse response = await httpClient
        .get("/minecraft/mod/view/$uuid?recordViewCount=$recordViewCount");

    return MinecraftMod.fromMap(response.data);
  }

  /// 透過 模組名稱/模組譯名/模組 ID 來搜尋 Minecraft 模組
  /// [limit] 取得的資料數量 (預設為 50，最大為 50)
  /// [skip] 跳過的資料數量 (預設為 0)
  Future<List<MinecraftMod>> search(
      {String? filter,
      int? limit,
      int? skip,
      ModSortType sort = ModSortType.createTime}) async {
    APIHttpResponse response =
        await httpClient.get("/minecraft/mod/search", query: {
      "filter": filter,
      "limit": limit?.toString(),
      "skip": skip?.toString(),
      "sort": sort.id.toString()
    });

    Map data = response.data;

    return List<MinecraftMod>.from((data["mods"] as List)
        .cast<Map<String, dynamic>>()
        .map((e) => MinecraftMod.fromMap(e)));
  }

  /// 查詢 RPMWiki 的變更日誌
  /// [limit] 取得的資料數量 (預設為 50，最大為 50)
  /// [skip] 跳過的資料數量 (預設為 0)
  /// [dataUUID] 要篩選的資料 UUID
  /// [userUUID] 要篩選的資料編輯者 UUID
  Future<List<WikiChangelog>> filterChangelogs(
      {int? limit, int? skip, String? dataUUID, String? userUUID}) async {
    APIHttpResponse response =
        await httpClient.get("/minecraft/changelog", query: {
      "limit": limit?.toString(),
      "skip": skip?.toString(),
      "dataUUID": dataUUID,
      "userUUID": userUUID
    });

    Map data = response.data;
    return List<WikiChangelog>.from((data["changelogs"] as List)
        .cast<Map<String, dynamic>>()
        .map((e) => WikiChangelog.fromMap(e)));
  }

  /// 取得 Minecraft 版本資訊 (由 Mojang API 提供，RPMTW API 伺服器每天快取一次資料)
  Future<MinecraftVersionManifest> getMinecraftVersionManifest() async {
    APIHttpResponse response = await httpClient.get("/minecraft/versions");
    return MinecraftVersionManifest.fromMap(response.data);
  }
}
