import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:rpmtw_api_client/src/models/minecraft/minecraft_mod.dart';
import 'package:rpmtw_api_client/src/models/minecraft/minecraft_version.dart';
import 'package:rpmtw_api_client/src/models/minecraft/mod_integration.dart';
import 'package:rpmtw_api_client/src/models/minecraft/mod_side.dart';
import 'package:rpmtw_api_client/src/models/minecraft/relation_mod.dart';
import 'package:rpmtw_api_client/src/models/storage/storage.dart';
import 'package:rpmtw_api_client/src/resources/base_resource.dart';
import 'package:rpmtw_api_client/src/utilities/extension.dart';

class MinecraftResource extends BaseResource {
  MinecraftResource(
      {required Client httpClient,
      required String baseUrl,
      required String? token})
      : super(httpClient: httpClient, baseUrl: baseUrl, globalToken: token);

  /// 建立 Minecraft 模組，如果建立成功將回傳 Minecraft 模組資訊
  Future<MinecraftMod> createMinecraftMod(
      {required String name,
      required String id,
      required List<MinecraftVersion> supportVersions,
      String? description,
      List<RelationMod>? relationMods,
      ModIntegration? integration,
      List<ModSide>? side,
      String? token}) async {
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

    Response response =
        await httpClient.post(Uri.parse('$baseUrl/minecraft/mod/create'),
            headers: {
              if (globalToken != null || token != null)
                'Authorization': 'Bearer ${token ?? globalToken}'
            },
            body: json.encode(postData));
    int statusCode = response.statusCode;

    if (statusCode == HttpStatus.ok) {
      return MinecraftMod.fromJson(response.json);
    } else if (statusCode == HttpStatus.notFound) {
      throw CreateMinecraftModException('User not found');
    } else {
      if (statusCode == HttpStatus.badRequest || statusCode == HttpStatus.unauthorized) {
        throw CreateMinecraftModException(response.map['message']);
      } else {
        throw CreateMinecraftModException('Create minecraft mod failed ${response.reasonPhrase}');
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
}

class CreateMinecraftModException implements Exception {
  final String message;

  CreateMinecraftModException(this.message);

  @override
  String toString() {
    return message;
  }
}
