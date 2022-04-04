import "dart:collection";
import "dart:convert";

import "package:collection/collection.dart";
import "package:intl/locale.dart";
import "package:rpmtw_api_client/src/api_client.dart";
import "package:rpmtw_api_client/src/models/api_model.dart";
import 'package:rpmtw_api_client/src/models/list_model_response.dart';
import "package:rpmtw_api_client/src/models/minecraft/minecraft_version.dart";
import "package:rpmtw_api_client/src/models/translate/translation.dart";

/// Represents a source text entry in a text format.
/// Can be referenced by `sources` of [SourceFile] or `patchouliAddons` of [ModSourceInfo].
/// Cannot be repeatedly referenced.
class SourceText implements APIModel {
  @override
  final String uuid;

  /// Text for translation.
  final String source;

  final List<MinecraftVersion> gameVersions;

  final String key;

  final SourceTextType type;

  const SourceText({
    required this.uuid,
    required this.source,
    required this.gameVersions,
    required this.key,
    required this.type,
  });

  Future<ListModelResponse<Translation>> getTranslations({
    Locale? language,
    int limit = 50,
    int skip = 0,
  }) =>
      Translation.list(
          sourceText: this, language: language, limit: limit, skip: skip);

  SourceText copyWith({
    String? uuid,
    String? source,
    List<MinecraftVersion>? gameVersions,
    String? key,
    SourceTextType? type,
  }) {
    return SourceText(
      uuid: uuid ?? this.uuid,
      source: source ?? this.source,
      gameVersions: gameVersions ?? this.gameVersions,
      key: key ?? this.key,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "uuid": uuid,
      "source": source,
      "gameVersions": gameVersions.map((x) => x.toMap()).toList(),
      "key": key,
      "type": type.name,
    };
  }

  factory SourceText.fromMap(Map<String, dynamic> map) {
    return SourceText(
      uuid: map["uuid"],
      source: map["source"],
      gameVersions: List<MinecraftVersion>.from(
          map["gameVersions"]?.map((x) => MinecraftVersion.fromMap(x))),
      key: map["key"],
      type: SourceTextType.values.byName(map["type"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory SourceText.fromJson(String source) =>
      SourceText.fromMap(json.decode(source));

  @override
  String toString() {
    return "SourceText(uuid: $uuid, source: $source, gameVersions: $gameVersions, key: $key, type: $type)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is SourceText &&
        other.uuid == uuid &&
        other.source == source &&
        listEquals(other.gameVersions, gameVersions) &&
        other.key == key &&
        other.type == type;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        source.hashCode ^
        gameVersions.hashCode ^
        key.hashCode ^
        type.hashCode;
  }

  static Future<SourceText> getByUUID(String uuid) =>
      RPMTWApiClient.instance.translateResource.getSourceText(uuid);

  static Future<ListModelResponse<SourceText>> list(
          {String? source, String? key, int limit = 50, int skip = 0}) =>
      RPMTWApiClient.instance.translateResource
          .listSourceText(source: source, key: key, limit: limit, skip: skip);
}

enum SourceTextType {
  /// A collection of key/value pairs (e.g. [HashMap])
  general,
  patchouli,

  /// Plain text format
  /// Key in the source entry uses the md5 hash value of the source content
  plainText
}
