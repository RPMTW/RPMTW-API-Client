import 'package:collection/collection.dart';
import 'package:rpmtw_api_client/src/models/api_model.dart';
import 'package:rpmtw_api_client/src/models/comment/comment.dart';
import 'package:rpmtw_api_client/src/models/minecraft/minecraft_mod.dart';
import 'package:rpmtw_api_client/src/models/minecraft/rpmwiki/wiki_change_log.dart';
import 'package:rpmtw_api_client/src/models/translate/glossary.dart';
import 'package:rpmtw_api_client/src/models/translate/mod_source_info.dart';
import 'package:rpmtw_api_client/src/models/translate/source_file.dart';
import 'package:rpmtw_api_client/src/models/translate/source_text.dart';
import 'package:rpmtw_api_client/src/models/translate/translation.dart';
import 'package:rpmtw_api_client/src/models/translate/translation_vote.dart';
import 'package:rpmtw_api_client/src/models/translate/translator_info.dart';

class ListModelResponse<T extends APIModel> {
  final List<T> data;
  final int limit;
  final int skip;

  int get total => data.length;

  const ListModelResponse._(this.data, this.limit, this.skip);

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'limit': limit,
      'skip': skip,
      'total': total,
    };
  }

  @override
  String toString() =>
      'ListModelResponse(data: $data, limit: $limit, skip: $skip)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is ListModelResponse<T> &&
        listEquals(other.data, data) &&
        other.limit == limit &&
        other.skip == skip;
  }

  @override
  int get hashCode => data.hashCode ^ limit.hashCode ^ skip.hashCode;

  static ListModelResponse<T> fromMap<T extends APIModel>(Map data) {
    T Function(Map<String, dynamic>) factory = _fromMap
        .cast<String, T Function(Map<String, dynamic>)>()[T.toString()]!;

    return ListModelResponse<T>._(
        (data['data'] as List)
            .cast<Map>()
            .cast<Map<String, dynamic>>()
            .map((e) => factory(e))
            .toList(),
        data['limit'],
        data['skip']);
  }

  static final Map<String, dynamic Function(Map<String, dynamic>)> _fromMap = {
    'WikiChangelog': WikiChangelog.fromMap,
    'MinecraftMod': MinecraftMod.fromMap,
    'Comment': Comment.fromMap,
    'TranslationVote': TranslationVote.fromMap,
    'Translation': Translation.fromMap,
    'SourceText': SourceText.fromMap,
    'SourceFile': SourceFile.fromMap,
    'ModSourceInfo': ModSourceInfo.fromMap,
    'Glossary': Glossary.fromMap,
    'TranslatorInfo': TranslatorInfo.fromMap,
  }.cast<String, dynamic Function(Map<String, dynamic>)>();
}
