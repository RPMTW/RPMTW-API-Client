import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:rpmtw_api_client/src/models/minecraft/minecraft_mod.dart';
import 'package:rpmtw_api_client/src/models/minecraft/minecraft_version_manifest.dart';
import 'package:rpmtw_api_client/src/models/minecraft/mod_integration.dart';
import 'package:rpmtw_api_client/src/models/minecraft/mod_side.dart';
import 'package:rpmtw_api_client/src/models/minecraft/relation_mod.dart';
import 'package:rpmtw_api_client/src/models/rpmwiki/wiki_mod_data.dart';
import 'package:rpmtw_api_client/src/resources/base_resource.dart';
import 'package:rpmtw_api_client/src/utilities/exceptions.dart';
import 'package:rpmtw_api_client/src/utilities/extension.dart';

class MinecraftResource extends BaseResource {
  MinecraftResource(
      {required Client httpClient,
      required String baseUrl,
      required String? token})
      : super(httpClient: httpClient, baseUrl: baseUrl, globalToken: token);

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
  Future<MinecraftMod> createMinecraftMod(
      {required String name,
      required List<String> supportVersions,
      String? id,
      String? description,
      List<RelationMod>? relationMods,
      ModIntegrationPlatform? integration,
      List<ModSide>? side,
      List<ModLoader>? loader,
      String? token}) async {
    if (token == null && globalToken == null) {
      throw UnauthorizedException();
    }

    Map postData = {'name': name, 'supportVersions': supportVersions.toList()};

    if (id != null) {
      postData['id'] = id;
    }
    if (description != null) {
      postData['description'] = description;
    }
    if (relationMods != null) {
      postData['relationMods'] = relationMods.map((e) => e.toMap()).toList();
    }
    if (integration != null) {
      postData['integration'] = integration.toMap();
    }
    if (side != null) {
      postData['side'] = side.map((e) => e.toMap()).toList();
    }
    if (loader != null) {
      postData['loader'] = loader.map((e) => e.name).toList();
    }

    Response response = await httpClient.post(
        Uri.parse('$baseUrl/minecraft/mod/create'),
        headers: {'Authorization': 'Bearer ${token ?? globalToken}'},
        body: json.encode(postData));
    int statusCode = response.statusCode;

    if (statusCode == HttpStatus.ok) {
      return MinecraftMod.fromMap(response.map['data']);
    } else {
      if (statusCode == HttpStatus.badRequest ||
          statusCode == HttpStatus.unauthorized) {
        throw Exception(response.map['message']);
      } else {
        throw Exception('Create minecraft mod failed ${response.body}');
      }
    }
  }

  /// 透過 UUID 取得 Minecraft 模組資訊
  Future<MinecraftMod> getMinecraftMod(String uuid) async {
    Response response =
        await httpClient.get(Uri.parse('$baseUrl/minecraft/mod/view/$uuid'));
    int statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      return MinecraftMod.fromMap(response.map['data']);
    } else if (statusCode == HttpStatus.notFound) {
      throw Exception('Minecraft mod not found');
    } else {
      throw Exception('Get Minecraft mod failed');
    }
  }

  /// 建立 Minecraft 模組維基資訊，如果建立成功將回傳 Minecraft 模組維基資訊
  ///
  /// **必填參數**
  /// * [modUUID] 模組的 UUID
  /// **選填參數**
  /// * [translatedName] 模組譯名
  /// * [introduction] 模組介紹文
  /// * [imageStorageUUID] 模組封面圖的 Storage UUID
  Future<WikiModData> createWikiModData(
      {required String modUUID,
      String? token,
      String? translatedName,
      String? introduction,
      String? imageStorageUUID}) async {
    if (token == null && globalToken == null) {
      throw UnauthorizedException();
    }

    Map<String, dynamic> postData = {
      'modUUID': modUUID,
    };

    if (translatedName != null) {
      postData['translatedName'] = translatedName;
    }
    if (introduction != null) {
      postData['introduction'] = introduction;
    }
    if (imageStorageUUID != null) {
      postData['imageStorageUUID'] = imageStorageUUID;
    }

    Response response = await httpClient.post(
        Uri.parse('$baseUrl/minecraft/mod/wiki/create'),
        headers: {'Authorization': 'Bearer ${token ?? globalToken}'},
        body: json.encode(postData));
    int statusCode = response.statusCode;

    if (statusCode == HttpStatus.ok) {
      return WikiModData.fromMap(response.map['data']);
    } else {
      if (statusCode == HttpStatus.badRequest ||
          statusCode == HttpStatus.unauthorized) {
        throw Exception(response.map['message']);
      } else {
        throw Exception('Create wiki mod data failed ${response.body}');
      }
    }
  }

  /// 透過 UUID 取得 Minecraft 模組維基資訊
  Future<WikiModData> getWikiModData(String uuid) async {
    Response response = await httpClient
        .get(Uri.parse('$baseUrl/minecraft/mod/wiki/view/$uuid'));
    int statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      return WikiModData.fromMap(response.map['data']);
    } else if (statusCode == HttpStatus.notFound) {
      throw Exception('Wiki mod data not found');
    } else {
      throw Exception('Get wiki mod data failed');
    }
  }

  /// 透過模組 ID 取得 Minecraft 模組維基資訊
  Future<WikiModData> getWikiModDataByModUUID(String modUUID) async {
    Response response = await httpClient.get(
        Uri.parse('$baseUrl/minecraft/mod/wiki/view-by-mod-uuid/$modUUID'));
    int statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      return WikiModData.fromMap(response.map['data']);
    } else if (statusCode == HttpStatus.notFound) {
      throw Exception('Wiki mod data not found');
    } else {
      throw Exception('Get wiki mod data failed');
    }
  }

  /// 透過 模組名稱/模組譯名/模組 ID 來搜尋 Minecraft 模組
  Future<List<MinecraftMod>> search(
      {String? filter, int? limit, int? skip}) async {
    Uri uri = Uri.parse('$baseUrl/minecraft/mod/search');
    uri = uri.replace(queryParameters: {
      'filter': filter,
      'limit': limit?.toString(),
      'skip': skip?.toString()
    });

    Response response = await httpClient.get(uri);
    int statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      Map map = response.map;
      Map data = map['data'];
      return List<MinecraftMod>.from((data['mods'] as List)
          .cast<Map<String, dynamic>>()
          .map((e) => MinecraftMod.fromMap({
                'data': e,
                'status': map['status'],
                'message': map['message']
              })));
    } else {
      throw Exception('Search Minecraft mod failed');
    }
  }

  /// 取得 Minecraft 版本資訊 (由 Mojang API 提供，RPMTW API 伺服器每天快取一次資料)
  Future<MinecraftVersionManifest> getMinecraftVersionManifest() async {
    Response response =
        await httpClient.get(Uri.parse('$baseUrl/minecraft/versions'));
    int statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      return MinecraftVersionManifest.fromMap(response.map['data']);
    } else {
      throw Exception('Get Minecraft version manifest failed');
    }
  }
}
