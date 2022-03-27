import "dart:convert";

import "package:collection/collection.dart";
import "package:rpmtw_api_client/src/models/base_model.dart";
import "package:rpmtw_api_client/src/models/storage/storage.dart";
import "package:rpmtw_api_client/src/models/translate/mod_source_info.dart";
import "package:rpmtw_api_client/src/models/translate/source_text.dart";

/// Represents the source language file in a text format.
class SourceFile implements BaseModel {
  @override
  final String uuid;
  final String modSourceInfoUUID;
  final String storageUUID;
  final String path;
  final SourceFileType type;

  /// [SourceText] included in the file.
  final List<String> sources;

  const SourceFile({
    required this.uuid,
    required this.modSourceInfoUUID,
    required this.storageUUID,
    required this.path,
    required this.type,
    required this.sources,
  });

  Future<ModSourceInfo?> get sourceInfo =>
      ModSourceInfo.getByUUID(modSourceInfoUUID);

  Future<Storage?> get storage => Storage.getByUUID(storageUUID);

  Future<List<SourceText>> get sourceTexts async {
    List<SourceText> texts = [];
    for (String source in sources) {
      SourceText text = await SourceText.getByUUID(source);
      texts.add(text);
    }
    return texts;
  }

  Future<SourceFile> addSourceText(SourceText text) async {
    if (sources.contains(text.uuid)) {
      return this;
    }

    throw UnimplementedError();
  }

  Future<void> delete() => throw UnimplementedError();

  SourceFile copyWith({
    String? uuid,
    String? modSourceInfoUUID,
    String? storageUUID,
    String? path,
    SourceFileType? type,
    List<String>? sources,
  }) {
    return SourceFile(
      uuid: uuid ?? this.uuid,
      modSourceInfoUUID: modSourceInfoUUID ?? this.modSourceInfoUUID,
      storageUUID: storageUUID ?? this.storageUUID,
      path: path ?? this.path,
      type: type ?? this.type,
      sources: sources ?? this.sources,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "uuid": uuid,
      "modSourceInfoUUID": modSourceInfoUUID,
      "storageUUID": storageUUID,
      "path": path,
      "type": type.name,
      "sources": sources,
    };
  }

  factory SourceFile.fromMap(Map<String, dynamic> map) {
    return SourceFile(
      uuid: map["uuid"],
      modSourceInfoUUID: map["modSourceInfoUUID"],
      storageUUID: map["storageUUID"],
      path: map["path"],
      type: SourceFileType.values.byName(map["type"]),
      sources: List<String>.from(map["sources"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory SourceFile.fromJson(String source) =>
      SourceFile.fromMap(json.decode(source));

  @override
  String toString() {
    return "SourceFile(uuid: $uuid, modSourceInfoUUID: $modSourceInfoUUID, storageUUID: $storageUUID, path: $path, type: $type, sources: $sources)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is SourceFile &&
        other.uuid == uuid &&
        other.modSourceInfoUUID == modSourceInfoUUID &&
        other.storageUUID == storageUUID &&
        other.path == path &&
        other.type == type &&
        listEquals(other.sources, sources);
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        modSourceInfoUUID.hashCode ^
        storageUUID.hashCode ^
        path.hashCode ^
        type.hashCode ^
        sources.hashCode;
  }

  static Future<SourceFile> getByUUID(String uuid) =>
      throw UnimplementedError();

  static Future<List<SourceFile>> list(
          {String? modSourceInfoUUID, int? limit, int? skip}) =>
      throw UnimplementedError();
}

enum SourceFileType {
  /// Localized file format used in versions 1.13 and above
  gsonLang,

  /// Localized file format used in versions below 1.12 (inclusive)
  minecraftLang,
  patchouli,

  /// Plain text format
  /// Each line of text is a source entry, and the key in the source entry uses the md5 hash value of the source content
  plainText,

  /// Custom json format
  /// e.g. Tinkers Construct book...
  customJson
}
