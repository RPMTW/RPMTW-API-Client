import 'package:intl/locale.dart';
import "package:rpmtw_api_client/src/http/api_http_client.dart";
import "package:rpmtw_api_client/src/http/api_http_response.dart";
import 'package:rpmtw_api_client/src/models/translate/source_text.dart';
import 'package:rpmtw_api_client/src/models/translate/translation.dart';
import "package:rpmtw_api_client/src/models/translate/translation_vote.dart";
import "package:rpmtw_api_client/src/resources/base_resource.dart";

class TranslateResource extends APIResource {
  TranslateResource(APIHttpClient httpClient) : super(httpClient);

  /// Get a vote by uuid.
  Future<TranslationVote> getVote(String uuid) async {
    APIHttpResponse response = await httpClient.get("/translate/vote/$uuid");
    return TranslationVote.fromMap(response.data);
  }

  /// List all votes by translation.
  /// **Parameters**
  /// - [translationUUID] UUID of translation
  /// - [limit] limit the number of results. (max 50)
  /// - [skip] skip the first n results.
  Future<List<TranslationVote>> listVote(
      {String? translationUUID, int limit = 50, int skip = 0}) async {
    APIHttpResponse response = await httpClient.get("/translate/vote/", query: {
      if (translationUUID != null) "translationUUID": translationUUID,
      "limit": limit,
      "skip": skip,
    });

    return List<TranslationVote>.from(
        (response.data as List).map((e) => TranslationVote.fromMap(e)));
  }

  /// Add a vote to a translation.
  /// **Parameters**
  /// - [translationUUID] The UUID of the translation to vote on.
  /// - [type] Up or down vote.
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<TranslationVote> addVote(
      Translation translation, TranslationVoteType type,
      {String? token}) async {
    APIHttpResponse response = await httpClient.post("/translate/vote/",
        body: {
          "translationUUID": translation.uuid,
          "type": type.name,
        },
        token: token);

    return TranslationVote.fromMap(response.data);
  }

  /// Edit a vote.
  /// **Parameters**
  /// - [vote] The vote to edit.
  /// - [type] Up or down vote.
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<TranslationVote> editVote(TranslationVote vote,
      {required TranslationVoteType type, String? token}) async {
    if (vote.type == type) {
      return vote;
    }

    APIHttpResponse response =
        await httpClient.patch("/translate/vote/${vote.uuid}", body: {
      "type": type.name,
    });

    return TranslationVote.fromMap(response.data);
  }

  /// Cancel a vote.
  /// **Parameters**
  /// - [vote] The vote to cancel.
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<void> cancelVote(TranslationVote vote, {String? token}) async {
    await httpClient.delete("/translate/vote/${vote.uuid}");
  }

  /// Get a translation by uuid.
  Future<Translation> getTranslation(String uuid) async {
    APIHttpResponse response =
        await httpClient.get("/translate/translation/$uuid");

    return Translation.fromMap(response.data);
  }

  /// List all translations.
  /// **Parameters**
  /// - [sourceUUID] filter by source text.
  /// - [language] filter by language.
  /// - [translatorUUID] filter by translator.
  /// - [limit] limit the number of results. (max 50)
  /// - [skip] skip the first n results.
  Future<List<Translation>> listTranslation(
      {String? sourceUUID,
      Locale? language,
      String? translatorUUID,
      int limit = 50,
      int skip = 0}) async {
    APIHttpResponse response =
        await httpClient.get("/translate/translation/", query: {
      if (sourceUUID != null) "sourceUUID": sourceUUID,
      if (language != null) "language": language.toLanguageTag(),
      if (translatorUUID != null) "translatorUUID": translatorUUID,
      "limit": limit,
      "skip": skip,
    });

    return List<Translation>.from(
        (response.data as List).map((e) => Translation.fromMap(e)));
  }

  /// Add a translation.
  /// **Parameters**
  /// - [sourceText] The source text to translate.
  /// - [language] The language to translate to.
  /// - [content] The translation content.
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<Translation> addTranslation(
      {required SourceText sourceText,
      required Locale language,
      required String content,
      String? token}) async {
    APIHttpResponse response = await httpClient.post("/translate/translation/",
        body: {
          "sourceUUID": sourceText.uuid,
          "language": language.toLanguageTag(),
          "content": content
        },
        token: token);

    return Translation.fromMap(response.data);
  }

  /// Delete a translation.
  /// **Parameters**
  /// - [translation] The translation to delete.
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<void> deleteTranslation(Translation translation,
      {String? token}) async {
    await httpClient.delete("/translate/translation/${translation.uuid}",
        token: token);
  }

  /// Get a source text by uuid.
  Future<SourceText> getSourceText(String uuid) async {
    APIHttpResponse response =
        await httpClient.get("/translate/source-text/$uuid");

    return SourceText.fromMap(response.data);
  }

  /// List all source texts.
  /// **Parameters**
  /// - [source] filter by source.
  /// - [key] filter by key.
  /// - [limit] limit the number of results. (max 50)
  /// - [skip] skip the first n results.
  Future<List<SourceText>> listSourceText(
      {String? source, String? key, int limit = 50, int skip = 0}) async {
    APIHttpResponse response =
        await httpClient.get("/translate/source-text/", query: {
      if (source != null) "source": source,
      if (key != null) "key": key,
      "limit": limit,
      "skip": skip,
    });

    return List<SourceText>.from(
        (response.data as List).map((e) => SourceText.fromMap(e)));
  }

  /// Add a source text.
  /// **Parameters**
  /// - [source] The source content.
  /// - [gameVersions] The game version of the text.
  /// - [key] The key of the text.
  /// - [type] The type of the text.
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<SourceText> addSourceText(
      {required String source,
      required String gameVersions,
      required String key,
      required SourceTextType type,
      String? token}) async {
    APIHttpResponse response = await httpClient.post("/translate/source-text/",
        body: {
          "source": source,
          "gameVersions": gameVersions,
          "key": key,
          "type": type.name
        },
        token: token);

    return SourceText.fromMap(response.data);
  }

  /// Edit a source text.
  /// **Parameters**
  /// - [sourceText] The source text to edit.
  /// - [source] The source content,
  /// - [gameVersions] The game versions of the text.
  /// - [key] The key of the text.
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<SourceText> editSourceText(SourceText sourceText,
      {String? source,
      String? gameVersions,
      String? key,
      String? token}) async {
    APIHttpResponse response = await httpClient.patch("/translate/source-text/",
        body: {
          if (source != null) "source": source,
          if (gameVersions != null) "gameVersions": gameVersions,
          if (key != null) "key": key,
        },
        token: token);

    return SourceText.fromMap(response.data);
  }

  /// Delete a source text.
  /// **Parameters**
  /// - [sourceText] The source text to delete.
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<void> deleteSourceText(SourceText sourceText, {String? token}) async {
    await httpClient.delete("/translate/source-text/${sourceText.uuid}",
        token: token);
  }
}
