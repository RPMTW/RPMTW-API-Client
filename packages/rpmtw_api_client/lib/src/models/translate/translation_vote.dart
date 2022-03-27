import "dart:convert";

import "package:rpmtw_api_client/src/api_client.dart";
import "package:rpmtw_api_client/src/models/api_model.dart";
import "package:rpmtw_api_client/src/models/translate/translation.dart";

class TranslationVote implements APIModel {
  @override
  final String uuid;
  final TranslationVoteType type;
  final String translationUUID;
  final String userUUID;

  const TranslationVote({
    required this.uuid,
    required this.type,
    required this.translationUUID,
    required this.userUUID,
  });

  bool get isUpVote => type == TranslationVoteType.up;
  bool get isDownVote => type == TranslationVoteType.down;

  TranslationVote copyWith({
    String? uuid,
    TranslationVoteType? type,
    String? translationUUID,
    String? userUUID,
  }) {
    return TranslationVote(
      uuid: uuid ?? this.uuid,
      type: type ?? this.type,
      translationUUID: translationUUID ?? this.translationUUID,
      userUUID: userUUID ?? this.userUUID,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "uuid": uuid,
      "type": type.name,
      "translationUUID": translationUUID,
      "userUUID": userUUID,
    };
  }

  factory TranslationVote.fromMap(Map<String, dynamic> map) {
    return TranslationVote(
      uuid: map["uuid"],
      type: TranslationVoteType.values.byName(map["type"]),
      translationUUID: map["translationUUID"],
      userUUID: map["userUUID"],
    );
  }

  String toJson() => json.encode(toMap());

  factory TranslationVote.fromJson(String source) =>
      TranslationVote.fromMap(json.decode(source));

  @override
  String toString() {
    return "TranslationVote(uuid: $uuid, type: $type, translationUUID: $translationUUID, userUUID: $userUUID)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TranslationVote &&
        other.uuid == uuid &&
        other.type == type &&
        other.translationUUID == translationUUID &&
        other.userUUID == userUUID;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        type.hashCode ^
        translationUUID.hashCode ^
        userUUID.hashCode;
  }

  static Future<TranslationVote> getByUUID(String uuid) async =>
      RPMTWApiClient.instance.translateResource.getVote(uuid);

  static Future<List<TranslationVote>> getAllByTranslation(
          Translation translation,
          {int limit = 50,
          int skip = 0}) async =>
      RPMTWApiClient.instance.translateResource
          .listVote(translation: translation, limit: limit, skip: skip);
}

enum TranslationVoteType { up, down }
