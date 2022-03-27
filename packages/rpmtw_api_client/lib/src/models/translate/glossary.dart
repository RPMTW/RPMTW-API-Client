import "dart:convert";

import "package:intl/locale.dart";
import "package:rpmtw_api_client/src/models/base_model.dart";

class Glossary implements APIModel {
  @override
  final String uuid;
  final String term;
  final String translation;
  final String? description;
  final Locale language;
  final String? modUUID;

  const Glossary({
    required this.uuid,
    required this.term,
    required this.translation,
    this.description,
    required this.language,
    this.modUUID,
  });

  Glossary copyWith({
    String? uuid,
    String? term,
    String? translation,
    String? description,
    Locale? language,
    String? modUUID,
  }) {
    return Glossary(
      uuid: uuid ?? this.uuid,
      term: term ?? this.term,
      translation: translation ?? this.translation,
      description: description ?? this.description,
      language: language ?? this.language,
      modUUID: modUUID ?? this.modUUID,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "uuid": uuid,
      "term": term,
      "translation": translation,
      "description": description,
      "language": language.toLanguageTag(),
      "modUUID": modUUID,
    };
  }

  factory Glossary.fromMap(Map<String, dynamic> map) {
    return Glossary(
      uuid: map["uuid"],
      term: map["term"],
      translation: map["translation"],
      description: map["description"],
      language: Locale.parse(map["language"]),
      modUUID: map["modUUID"],
    );
  }

  String toJson() => json.encode(toMap());

  factory Glossary.fromJson(String source) =>
      Glossary.fromMap(json.decode(source));

  @override
  String toString() {
    return "Glossary(uuid: $uuid, term: $term, translation: $translation, description: $description, language: $language, modUUID: $modUUID)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Glossary &&
        other.uuid == uuid &&
        other.term == term &&
        other.translation == translation &&
        other.description == description &&
        other.language == language &&
        other.modUUID == modUUID;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        term.hashCode ^
        translation.hashCode ^
        description.hashCode ^
        language.hashCode ^
        modUUID.hashCode;
  }

  static Future<Glossary> getByUUID(String uuid) => throw UnimplementedError();

  static Future<List<Glossary>> list() => throw UnimplementedError();
}
