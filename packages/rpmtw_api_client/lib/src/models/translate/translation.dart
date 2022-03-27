import "dart:convert";

import "package:intl/locale.dart";
import 'package:rpmtw_api_client/src/api_client.dart';
import "package:rpmtw_api_client/src/models/auth/user.dart";
import "package:rpmtw_api_client/src/models/api_model.dart";
import "package:rpmtw_api_client/src/models/translate/source_text.dart";
import "package:rpmtw_api_client/src/models/translate/translation_vote.dart";

class Translation implements APIModel {
  @override
  final String uuid;

  /// The translation source text.
  /// UUID of [SourceText]
  final String sourceUUID;

  /// Translated text
  final String content;

  /// Uuid of translator
  final String translatorUUID;

  /// Language of translation
  final Locale language;

  Future<User> get translator {
    return User.getByUUID(translatorUUID);
  }

  Future<List<TranslationVote>> get votes {
    return TranslationVote.getAllByTranslationUUID(uuid);
  }

  Future<SourceText> get source {
    return SourceText.getByUUID(sourceUUID);
  }

  const Translation({
    required this.uuid,
    required this.sourceUUID,
    required this.content,
    required this.translatorUUID,
    required this.language,
  });

  Translation copyWith({
    String? uuid,
    String? sourceUUID,
    String? content,
    String? translatorUUID,
    Locale? language,
  }) {
    return Translation(
      uuid: uuid ?? this.uuid,
      sourceUUID: sourceUUID ?? this.sourceUUID,
      content: content ?? this.content,
      translatorUUID: translatorUUID ?? this.translatorUUID,
      language: language ?? this.language,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "uuid": uuid,
      "sourceUUID": sourceUUID,
      "content": content,
      "translatorUUID": translatorUUID,
      "language": language.toLanguageTag(),
    };
  }

  factory Translation.fromMap(Map<String, dynamic> map) {
    return Translation(
      uuid: map["uuid"] ?? "",
      sourceUUID: map["sourceUUID"] ?? "",
      content: map["content"] ?? "",
      translatorUUID: map["translatorUUID"] ?? "",
      language: Locale.parse(map["language"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Translation.fromJson(String source) =>
      Translation.fromMap(json.decode(source));

  @override
  String toString() {
    return "Translation(uuid: $uuid, sourceUUID: $sourceUUID, content: $content, translatorUUID: $translatorUUID, language: $language)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Translation &&
        other.uuid == uuid &&
        other.sourceUUID == sourceUUID &&
        other.content == content &&
        other.translatorUUID == translatorUUID &&
        other.language == language;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        sourceUUID.hashCode ^
        content.hashCode ^
        translatorUUID.hashCode ^
        language.hashCode;
  }

  static Future<Translation> getByUUID(String uuid) async =>
      RPMTWApiClient.instance.translateResource.getTranslation(uuid);

  static Future<List<Translation>> list(
          {String? sourceUUID,
          Locale? language,
          String? translatorUUID,
          int limit = 50,
          int skip = 0}) async =>
      RPMTWApiClient.instance.translateResource.listTranslation(
          sourceUUID: sourceUUID,
          language: language,
          translatorUUID: translatorUUID,
          limit: limit,
          skip: skip);
}
