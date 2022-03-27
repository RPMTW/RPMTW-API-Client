import 'package:intl/locale.dart';
import 'package:rpmtw_api_client/src/api_client.dart';
import "package:rpmtw_api_client/src/http/api_http_client.dart";
import "package:rpmtw_api_client/src/http/api_http_response.dart";
import 'package:rpmtw_api_client/src/models/auth/user.dart';
import 'package:rpmtw_api_client/src/models/minecraft/minecraft_mod.dart';
import 'package:rpmtw_api_client/src/models/storage/storage.dart';
import 'package:rpmtw_api_client/src/models/translate/glossary.dart';
import 'package:rpmtw_api_client/src/models/translate/mod_source_info.dart';
import 'package:rpmtw_api_client/src/models/translate/source_file.dart';
import 'package:rpmtw_api_client/src/models/translate/source_text.dart';
import 'package:rpmtw_api_client/src/models/translate/translation.dart';
import 'package:rpmtw_api_client/src/models/translate/translation_export_format.dart';
import "package:rpmtw_api_client/src/models/translate/translation_vote.dart";
import "package:rpmtw_api_client/src/resources/base_resource.dart";
import 'package:universal_io/io.dart';

class TranslateResource extends APIResource {
  TranslateResource(APIHttpClient httpClient) : super(httpClient);

  /// Get a vote by uuid.
  Future<TranslationVote> getVote(String uuid) async {
    APIHttpResponse response = await httpClient.get("/translate/vote/$uuid");
    return TranslationVote.fromMap(response.data);
  }

  /// List all votes by translation.
  /// **Parameters**
  /// - [translation] filter by translation
  /// - [limit] limit the number of results. (max 50)
  /// - [skip] skip the first n results.
  Future<List<TranslationVote>> listVote(
      {Translation? translation, int limit = 50, int skip = 0}) async {
    APIHttpResponse response = await httpClient.get("/translate/vote/", query: {
      if (translation != null) "translationUUID": translation.uuid,
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
  /// - [sourceText] filter by source text.
  /// - [language] filter by language.
  /// - [translator] filter by translator.
  /// - [limit] limit the number of results. (max 50)
  /// - [skip] skip the first n results.
  Future<List<Translation>> listTranslation(
      {SourceText? sourceText,
      Locale? language,
      User? translator,
      int limit = 50,
      int skip = 0}) async {
    APIHttpResponse response =
        await httpClient.get("/translate/translation/", query: {
      if (sourceText != null) "sourceUUID": sourceText.uuid,
      if (language != null) "language": language.toLanguageTag(),
      if (translator != null) "translatorUUID": translator.uuid,
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
      required List<String> gameVersions,
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
      List<String>? gameVersions,
      String? key,
      String? token}) async {
    if (source == null && gameVersions == null && key == null) {
      return sourceText;
    }

    APIHttpResponse response =
        await httpClient.patch("/translate/source-text/${sourceText.uuid}",
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

  /// Get a source file by uuid.
  Future<SourceFile> getSourceFile(String uuid) async {
    APIHttpResponse response =
        await httpClient.get("/translate/source-file/$uuid");

    return SourceFile.fromMap(response.data);
  }

  /// List all source files.
  /// **Parameters**
  /// - [modSourceInfo] filter by mod source info.
  /// - [limit] limit the number of results. (max 50)
  /// - [skip] skip the first n results.
  Future<List<SourceFile>> listSourceFile(
      {ModSourceInfo? modSourceInfo, int limit = 50, int skip = 0}) async {
    APIHttpResponse response =
        await httpClient.get("/translate/source-file/", query: {
      if (modSourceInfo != null) "modSourceInfoUUID": modSourceInfo.uuid,
      "limit": limit,
      "skip": skip,
    });

    return List<SourceFile>.from(
        (response.data as List).map((e) => SourceFile.fromMap(e)));
  }

  /// Add a source file.
  /// **Parameters**
  /// - [modSourceInfo] The mod source info to add the file to.
  /// - [storage] The file storage.
  /// - [path] The path of the file (inside mod jar file).
  /// - [type] The type of the file.
  /// - [gameVersions] The game versions of the file.
  /// - [patchouliI18nKeys] The keys of the translated patchouli content (optional).
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<SourceFile> addSourceFile(
      {required ModSourceInfo modSourceInfo,
      required Storage storage,
      required String path,
      required SourceFileType type,
      required List<String> gameVersions,
      List<String>? patchouliI18nKeys,
      String? token}) async {
    APIHttpResponse response = await httpClient.post("/translate/source-file/",
        body: {
          "modSourceInfoUUID": modSourceInfo.uuid,
          "storageUUID": storage.uuid,
          "path": path,
          "type": type.name,
          "gameVersions": gameVersions,
          if (patchouliI18nKeys != null) "patchouliI18nKeys": patchouliI18nKeys,
        },
        token: token);

    return SourceFile.fromMap(response.data);
  }

  /// Upload a source file to add.
  /// **Parameters**
  /// - [file] The file to upload (not support web).
  /// - [modSourceInfo] The mod source info to add the file to.
  /// - [path] The path of the file (inside mod jar file).
  /// - [type] The type of the file.
  /// - [gameVersions] The game versions of the file.
  /// - [patchouliI18nKeys] The keys of the translated patchouli content (optional).
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<SourceFile> uploadSourceFile(File file,
      {required ModSourceInfo modSourceInfo,
      required String path,
      required SourceFileType type,
      required List<String> gameVersions,
      List<String>? patchouliI18nKeys,
      String? token}) async {
    Storage storage =
        await RPMTWApiClient.instance.storageResource.createStorageByFile(file);

    return await addSourceFile(
        modSourceInfo: modSourceInfo,
        storage: storage,
        path: path,
        type: type,
        gameVersions: gameVersions,
        patchouliI18nKeys: patchouliI18nKeys,
        token: token);
  }

  /// Edit a source file.
  /// **Parameters**
  /// - [sourceFile] The source file to edit.
  /// - [modSourceInfo] The mod source info to add the file to.
  /// - [storage] The file storage.
  /// - [path] The path of the file (inside mod jar file).
  /// - [type] The type of the file.
  /// - [gameVersions] The game versions of the file.
  /// - [patchouliI18nKeys] The keys of the translated patchouli content (optional).
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<SourceFile> editSourceFile(SourceFile sourceFile,
      {ModSourceInfo? modSourceInfo,
      Storage? storage,
      String? path,
      SourceFileType? type,
      List<String>? gameVersions,
      List<String>? patchouliI18nKeys,
      String? token}) async {
    if (modSourceInfo == null &&
        storage == null &&
        path == null &&
        type == null &&
        gameVersions == null &&
        patchouliI18nKeys == null) {
      return sourceFile;
    }

    APIHttpResponse response = await httpClient.patch(
        "/translate/source-file/${sourceFile.uuid}",
        body: {
          if (modSourceInfo != null) "modSourceInfoUUID": modSourceInfo.uuid,
          if (storage != null) "storageUUID": storage.uuid,
          if (path != null) "path": path,
          if (type != null) "type": type.name,
          if (gameVersions != null) "gameVersions": gameVersions,
          if (patchouliI18nKeys != null) "patchouliI18nKeys": patchouliI18nKeys,
        },
        token: token);

    return SourceFile.fromMap(response.data);
  }

  /// Delete a source file.
  /// **Parameters**
  /// - [sourceFile] The source file to delete.
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<void> deleteSourceFile(SourceFile sourceFile, {String? token}) async {
    await httpClient.delete("/translate/source-file/${sourceFile.uuid}",
        token: token);
  }

  /// Get a mod source info by uuid.
  Future<ModSourceInfo> getModSourceInfo(String uuid) async {
    APIHttpResponse response =
        await httpClient.get("/translate/mod-source-info/$uuid");

    return ModSourceInfo.fromMap(response.data);
  }

  /// List all mod source infos.
  /// **Parameters**
  /// - [name] filter by name or translated name.
  /// - [namespace] filter by namespace.
  /// - [limit] limit the number of results. (max 50)
  /// - [skip] skip the first n results.
  Future<List<ModSourceInfo>> listModSourceInfo(
      {String? name, String? namespace, int limit = 50, int skip = 0}) async {
    APIHttpResponse response =
        await httpClient.get("/translate/mod-source-info/", query: {
      if (name != null) "name": name,
      if (namespace != null) "namespace": namespace,
      "limit": limit,
      "skip": skip,
    });

    return List<ModSourceInfo>.from(
        (response.data as List).map((e) => ModSourceInfo.fromMap(e)));
  }

  /// Add a mod source info.
  /// **Parameters**
  /// - [namespace] The namespace of the mod.
  /// - [mod] The mod of the info (optional).
  /// - [patchouliAddons] Used to store specially formatted [SourceText] in patchouli manuals (optional).
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<ModSourceInfo> addModSourceInfo(
      {required String namespace,
      MinecraftMod? mod,
      List<SourceText>? patchouliAddons,
      String? token}) async {
    APIHttpResponse response =
        await httpClient.post("/translate/mod-source-info/",
            body: {
              "namespace": namespace,
              if (mod != null) "modUUID": mod.uuid,
              if (patchouliAddons != null)
                "patchouliAddons": patchouliAddons.map((e) => e.uuid).toList(),
            },
            token: token);

    return ModSourceInfo.fromMap(response.data);
  }

  /// Edit a mod source info.
  /// **Parameters**
  /// - [modSourceInfo] The mod source info to edit.
  /// - [namespace] The namespace of the mod (optional).
  /// - [mod] The mod of the info (optional).
  /// - [patchouliAddons] Used to store specially formatted [SourceText] in patchouli manuals (optional).
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<ModSourceInfo> editModSourceInfo(ModSourceInfo modSourceInfo,
      {String? namespace,
      MinecraftMod? mod,
      List<SourceText>? patchouliAddons,
      String? token}) async {
    if (namespace == null && mod == null && patchouliAddons == null) {
      return modSourceInfo;
    }

    APIHttpResponse response = await httpClient.patch(
        "/translate/mod-source-info/${modSourceInfo.uuid}",
        body: {
          if (namespace != null) "namespace": namespace,
          if (mod != null) "modUUID": mod.uuid,
          if (patchouliAddons != null)
            "patchouliAddons": patchouliAddons.map((e) => e.uuid).toList(),
        },
        token: token);

    return ModSourceInfo.fromMap(response.data);
  }

  /// Delete a mod source info.
  /// **Parameters**
  /// - [modSourceInfo] The mod source info to delete.
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<void> deleteModSourceInfo(ModSourceInfo modSourceInfo,
      {String? token}) async {
    await httpClient.delete("/translate/mod-source-info/${modSourceInfo.uuid}",
        token: token);
  }

  /// Get a glossary by uuid.
  Future<Glossary> getGlossary(String uuid) async {
    APIHttpResponse response =
        await httpClient.get("/translate/glossary/$uuid");

    return Glossary.fromMap(response.data);
  }

  /// List all glossaries.
  /// **Parameters**
  /// - [language] filter by language.
  /// - [mod] filter by mod.
  /// - [filter] filter by term name or translated name.
  /// - [limit] limit the number of results. (max 50)
  /// - [skip] skip the first n results.
  Future<List<Glossary>> listGlossary(
      {String? language,
      MinecraftMod? mod,
      String? filter,
      int limit = 50,
      int skip = 0}) async {
    APIHttpResponse response =
        await httpClient.get("/translate/glossary/", query: {
      if (language != null) "language": language,
      if (mod != null) "modUUID": mod.uuid,
      if (filter != null) "filter": filter,
      "limit": limit,
      "skip": skip,
    });

    return List<Glossary>.from(
        (response.data as List).map((e) => Glossary.fromMap(e)));
  }

  /// Add a glossary.
  /// **Parameters**
  /// - [term] The term name of the glossary.
  /// - [translation] The translation of the glossary.
  /// - [description] The description of the glossary (optional).
  /// - [language] The language of the glossary.
  /// - [mod] The minecraft mod of the glossary (optional, If null, the global glossary).
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<Glossary> addGlossary(
      {required String term,
      required String translation,
      String? description,
      required String language,
      MinecraftMod? mod,
      String? token}) async {
    APIHttpResponse response = await httpClient.post("/translate/glossary/",
        body: {
          "term": term,
          "translation": translation,
          if (description != null) "description": description,
          "language": language,
          if (mod != null) "modUUID": mod.uuid,
        },
        token: token);

    return Glossary.fromMap(response.data);
  }

  /// Edit a glossary.
  /// **Parameters**
  /// - [glossary] The glossary to edit.
  /// - [term] The term name of the glossary (optional).
  /// - [translation] The translation of the glossary (optional).
  /// - [description] The description of the glossary (optional).
  /// - [mod] The minecraft mod of the glossary (optional).
  /// - [global] If the glossary is global (optional, if set true mod must be null).
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<Glossary> editGlossary(Glossary glossary,
      {String? term,
      String? translation,
      String? description,
      MinecraftMod? mod,
      String? token,
      bool global = false}) async {
    if (term == null &&
        translation == null &&
        description == null &&
        mod == null &&
        global == false) {
      return glossary;
    }

    APIHttpResponse response =
        await httpClient.patch("/translate/glossary/${glossary.uuid}",
            body: {
              if (term != null) "term": term,
              if (translation != null) "translation": translation,
              if (description != null) "description": description,
              if (global && mod == null)
                "modUUID": null
              else if (mod != null)
                "modUUID": mod.uuid,
            },
            token: token);

    return Glossary.fromMap(response.data);
  }

  /// Delete a glossary.
  /// **Parameters**
  /// - [glossary] The glossary to delete.
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<void> deleteGlossary(Glossary glossary, {String? token}) async {
    await httpClient.delete("/translate/glossary/${glossary.uuid}",
        token: token);
  }

  /// Get glossary highlight by text.
  /// **Parameters**
  /// - [text] The text to highlight.
  /// - [language] The language of the text.
  ///
  /// **Returns**
  /// Returns a map of the source word and glossary.
  /// Example:
  /// ```json
  /// {
  ///   "word1": <Glossary1>,
  ///   "word2": <Glossary2>
  /// }
  /// ```
  Future<Map<String, Glossary>> getGlossaryHighlight(
      String text, String language) async {
    APIHttpResponse response =
        await httpClient.get("/translate/glossary-highlight/", query: {
      "text": text,
      "language": language,
    });

    return Map<String, Glossary>.from((response.data as Map)
        .map((key, value) => MapEntry(key, Glossary.fromMap(value))));
  }

  /// Export translations.
  /// **Parameters**
  /// - [namespaces] The namespace of minecraft mods.
  /// - [language] The language of the translations.
  /// - [format] The format of the export.
  /// - [version] The game version of the translations.
  ///
  /// **Returns**
  /// If the format is `minecraftJson` or `patchouli`
  /// Returns a map of the source text and translation.  
  /// Example:  
  /// ```json
  /// {
  ///   "hello": "你好",
  ///   "world": "世界"
  /// }
  /// ```
  ///
  /// If the format is `customText`
  /// Returns a map of the source file path and translation texts.   
  /// Example:  
  /// ```json
  /// {
  ///  "assets/test/fqa.txt": "Q: RPMTW 是什麼？\n\nA: RPMTW 是個致力於推廣 Minecraft 中文社群\n並開發相關工具，希望為 Minecraft 玩家提供更好的體驗。",
  /// }
  /// ```
  Future<Map<String, String>> exportTranslations(
      {required List<String> namespaces,
      required Locale language,
      required TranslationExportFormat format,
      required String version}) async {
    APIHttpResponse response =
        await httpClient.post("/translate/export/", body: {
      "namespaces": namespaces,
      "language": language.toLanguageTag(),
      "format": format.name,
      "version": version,
    });

    return response.data;
  }
}
