import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:rpmtw_api_client/src/models/minecraft/minecraft_mod.dart';
import 'package:rpmtw_api_client/src/models/minecraft/minecraft_version.dart';
import 'package:rpmtw_api_client/src/models/minecraft/minecraft_version_manifest.dart';
import 'package:rpmtw_api_client/src/models/minecraft/mod_integration.dart';
import 'package:rpmtw_api_client/src/models/minecraft/mod_side.dart';
import 'package:rpmtw_api_client/src/models/minecraft/relation_mod.dart';
import 'package:rpmtw_api_client/src/models/storage/storage.dart';
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
  /// * [id] 模組 ID
  /// * [supportVersions] 該模組支援的 Minecraft 版本
  /// **選填參數**
  /// * [description] 模組描述
  /// * [relationMods] 關聯模組
  /// * [integration] 模組串連的平台
  /// * [side] 模組支援的執行環境
  Future<MinecraftMod> createMinecraftMod(
      {required String name,
      required String id,
      required List<MinecraftVersion> supportVersions,
      String? description,
      List<RelationMod>? relationMods,
      ModIntegrationPlatform? integration,
      List<ModSide>? side,
      String? token}) async {
    if (token == null && globalToken == null) {
      throw UnauthorizedException();
    }

    Map postData = {
      'name': name,
      'id': id,
      'supportVersions': supportVersions.map((e) => e.toMap()).toList()
    };

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
      postData['side'] = side.map((e) => e.toString()).toList();
    }

    Response response = await httpClient.post(
        Uri.parse('$baseUrl/minecraft/mod/create'),
        headers: {'Authorization': 'Bearer ${token ?? globalToken}'},
        body: json.encode(postData));
    int statusCode = response.statusCode;

    if (statusCode == HttpStatus.ok) {
      return MinecraftMod.fromJson(response.json);
    } else if (statusCode == HttpStatus.notFound) {
      throw CreateMinecraftModException('User not found');
    } else {
      if (statusCode == HttpStatus.badRequest ||
          statusCode == HttpStatus.unauthorized) {
        throw CreateMinecraftModException(response.map['message']);
      } else {
        throw CreateMinecraftModException(
            'Create minecraft mod failed ${response.body}');
      }
    }
  }

  /// 透過 UUID 取得 Minecraft 模組資訊
  Future<Storage> getMinecraftMod(String uuid) async {
    Response response =
        await httpClient.get(Uri.parse('$baseUrl/minecraft/mod/$uuid'));
    int statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      return Storage.fromJson(response.json);
    } else if (statusCode == HttpStatus.notFound) {
      throw Exception('Minecraft mod not found');
    } else {
      throw Exception('Get Minecraft mod failed');
    }
  }

  /// 取得 Minecraft 版本資訊 (由 Mojang API 提供，RPMTW API 伺服器每天快取一次資料)
  Future<MinecraftVersionManifest> getMinecraftVersionManifest() async {
    Response response =
        await httpClient.get(Uri.parse('$baseUrl/minecraft/versions'));
    int statusCode = response.statusCode;
    if (statusCode == HttpStatus.ok) {
      return MinecraftVersionManifest.fromJson(response.json);
    } else {
      throw Exception('Get Minecraft version manifest failed');
    }
  }
}

class CreateMinecraftModException implements Exception {
  final String message;

  CreateMinecraftModException(this.message);

  @override
  String toString() {
    return message;
  }
}
