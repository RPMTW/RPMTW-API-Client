import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:intl/locale.dart';
import 'package:rpmtw_api_client/src/api_client.dart';
import 'package:rpmtw_api_client/src/models/translate/mod_source_info.dart';

class TranslateStatus {
  /// If null, the status is global.
  final String? modSourceInfoUUID;

  final int totalWords;
  final Map<Locale, int> translatedWords;
  final DateTime lastUpdated;
  TranslateStatus({
    this.modSourceInfoUUID,
    required this.totalWords,
    required this.translatedWords,
    required this.lastUpdated,
  });

  bool get isGlobal => modSourceInfoUUID == null;

  TranslateStatus copyWith({
    String? modSourceInfoUUID,
    int? totalWords,
    Map<Locale, int>? translatedWords,
    DateTime? lastUpdated,
  }) {
    return TranslateStatus(
      modSourceInfoUUID: modSourceInfoUUID ?? this.modSourceInfoUUID,
      totalWords: totalWords ?? this.totalWords,
      translatedWords: translatedWords ?? this.translatedWords,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'modSourceInfoUUID': modSourceInfoUUID,
      'totalWords': totalWords,
      'translatedWords': translatedWords,
      'lastUpdated': lastUpdated.millisecondsSinceEpoch,
    };
  }

  factory TranslateStatus.fromMap(Map<String, dynamic> map) {
    return TranslateStatus(
      modSourceInfoUUID: map['modSourceInfoUUID'],
      totalWords: map['totalWords'],
      translatedWords: Map<Locale, int>.from(map['translatedWords']),
      lastUpdated:
          DateTime.fromMillisecondsSinceEpoch(map['lastUpdated'], isUtc: true),
    );
  }

  String toJson() => json.encode(toMap());

  factory TranslateStatus.fromJson(String source) =>
      TranslateStatus.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TranslateStatus(modSourceInfoUUID: $modSourceInfoUUID, totalWords: $totalWords, translatedWords: $translatedWords, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return other is TranslateStatus &&
        other.modSourceInfoUUID == modSourceInfoUUID &&
        other.totalWords == totalWords &&
        mapEquals(other.translatedWords, translatedWords) &&
        other.lastUpdated == lastUpdated;
  }

  @override
  int get hashCode {
    return modSourceInfoUUID.hashCode ^
        totalWords.hashCode ^
        translatedWords.hashCode ^
        lastUpdated.hashCode;
  }

  static Future<TranslateStatus> getByModSourceInfoUUID(ModSourceInfo info) =>
      RPMTWApiClient.instance.translateResource.getModSourceInfoStatus(info);

  static Future<TranslateStatus> getGlobalInfo() =>
      RPMTWApiClient.instance.translateResource.getGlobalStatus();
}
