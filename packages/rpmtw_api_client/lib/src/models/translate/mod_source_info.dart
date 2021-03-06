import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:rpmtw_api_client/src/api_client.dart';
import 'package:rpmtw_api_client/src/models/api_model.dart';
import 'package:rpmtw_api_client/src/models/list_model_response.dart';
import 'package:rpmtw_api_client/src/models/minecraft/minecraft_mod.dart';
import 'package:rpmtw_api_client/src/models/translate/source_file.dart';
import 'package:rpmtw_api_client/src/models/translate/source_text.dart';

class ModSourceInfo implements APIModel {
  @override
  final String uuid;

  /// Namespace of the mod
  final String namespace;

  /// UUID of the [MinecraftMod], can be null.
  final String? modUUID;

  /// Used to store specially formatted [SourceText] in patchouli manuals.
  final List<String>? patchouliAddons;

  const ModSourceInfo({
    required this.uuid,
    required this.namespace,
    this.modUUID,
    this.patchouliAddons,
  });

  Future<MinecraftMod?> get mod async {
    if (modUUID == null) {
      return null;
    } else {
      return MinecraftMod.getByUUID(modUUID!);
    }
  }

  /// [SourceFile] files included in this mod.
  Future<ListModelResponse<SourceFile>> getFiles(
      {int limit = 50, int skip = 0}) {
    return SourceFile.list(modSourceInfo: this, limit: limit, skip: skip);
  }

  Future<List<SourceText>?> get patchouliAddonTexts async {
    if (patchouliAddons == null) return null;

    List<SourceText> texts = [];
    for (String source in patchouliAddons!) {
      SourceText text = await SourceText.getByUUID(source);
      texts.add(text);
    }
    return texts;
  }

  ModSourceInfo copyWith({
    String? uuid,
    String? namespace,
    String? modUUID,
    List<String>? patchouliAddons,
  }) {
    return ModSourceInfo(
      uuid: uuid ?? this.uuid,
      namespace: namespace ?? this.namespace,
      modUUID: modUUID ?? this.modUUID,
      patchouliAddons: patchouliAddons ?? this.patchouliAddons,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'namespace': namespace,
      'modUUID': modUUID,
      'patchouliAddons': patchouliAddons,
    };
  }

  factory ModSourceInfo.fromMap(Map<String, dynamic> map) {
    return ModSourceInfo(
      uuid: map['uuid'],
      namespace: map['namespace'],
      modUUID: map['modUUID'],
      patchouliAddons: List<String>.from(map['patchouliAddons']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModSourceInfo.fromJson(String source) =>
      ModSourceInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ModSourceInfo(uuid: $uuid, namespace: $namespace, modUUID: $modUUID, patchouliAddons: $patchouliAddons)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is ModSourceInfo &&
        other.uuid == uuid &&
        other.namespace == namespace &&
        other.modUUID == modUUID &&
        listEquals(other.patchouliAddons, patchouliAddons);
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        namespace.hashCode ^
        modUUID.hashCode ^
        patchouliAddons.hashCode;
  }

  static Future<ModSourceInfo> getByUUID(String uuid) =>
      RPMTWApiClient.instance.translateResource.getModSourceInfo(uuid);

  static Future<ModSourceInfo?> getByMod(MinecraftMod mod) async {
    List<ModSourceInfo> infos = (await RPMTWApiClient.instance.translateResource
            .listModSourceInfo(mod: mod, limit: 1))
        .data;

    if (infos.isEmpty) {
      return null;
    } else {
      return infos.first;
    }
  }

  static Future<ModSourceInfo?> getByNamespace(String namespace) async {
    List<ModSourceInfo> infos = (await RPMTWApiClient.instance.translateResource
            .listModSourceInfo(namespace: namespace, limit: 1))
        .data;

    if (infos.isEmpty) {
      return null;
    } else {
      return infos.first;
    }
  }
}
