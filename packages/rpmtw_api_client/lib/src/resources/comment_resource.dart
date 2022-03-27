import 'package:meta/meta.dart';
import 'package:rpmtw_api_client/src/http/api_http_client.dart';
import 'package:rpmtw_api_client/src/http/api_http_response.dart';
import 'package:rpmtw_api_client/src/models/api_model.dart';
import 'package:rpmtw_api_client/src/models/comment/comment.dart';
import 'package:rpmtw_api_client/src/models/comment/comment_type.dart';
import 'package:rpmtw_api_client/src/models/minecraft/minecraft_mod.dart';
import 'package:rpmtw_api_client/src/models/translate/translation.dart';
import 'package:rpmtw_api_client/src/resources/base_resource.dart';

class CommentResource extends APIResource {
  const CommentResource(APIHttpClient httpClient) : super(httpClient);

  /// Get a comment by uuid.
  Future<Comment> getComment(String uuid) async {
    APIHttpResponse response = await httpClient.get("/comment/$uuid");

    return Comment.fromMap(response.data);
  }

  /// List all comment
  /// **Parameters**
  /// - [type] Comment type
  /// - [parentUUID] The parent of comment (if type is translate parent is [Translation], if type is minecraft wiki parent is [MinecraftMod])
  /// - [replyComment] The comment to reply to (optional)
  /// - [limit] limit the number of results. (max 50)
  /// - [skip] skip the first n results.
  @internal
  Future<List<Comment>> listCommentInternal(
      {required CommentType type,
      required String parentUUID,
      Comment? replyComment,
      int limit = 50,
      skip = 0}) async {
    APIHttpResponse response = await httpClient.get("/comment/", query: {
      "type": type.name,
      "parentUUID": parentUUID,
      if (replyComment != null) "replyCommentUUID": replyComment.uuid,
      "limit": limit.toString(),
      "skip": skip.toString()
    });

    return List<Comment>.from(
        (response.data as List).map((comment) => Comment.fromMap(comment)));
  }

  /// List all comment
  /// **Parameters**
  /// - [type] Comment type
  /// - [parent] The parent of comment (if type is translate parent is [Translation], if type is minecraft wiki parent is [MinecraftMod])
  /// - [replyComment] The comment to reply to (optional)
  /// - [limit] limit the number of results. (max 50)
  /// - [skip] skip the first n results.
  Future<List<Comment>> listComment<T extends APIModel>(
      {required CommentType type,
      required T parent,
      Comment? replyComment,
      int limit = 50,
      skip = 0}) async {
    if (parent is Translation || parent is MinecraftMod) {
      return await listCommentInternal(
          type: type,
          parentUUID: parent.uuid,
          replyComment: replyComment,
          limit: limit,
          skip: skip);
    } else {
      throw Exception("parent must be a Translation or a MinecraftMod");
    }
  }

  /// Add a comment.
  /// **Parameters**
  /// - [type] Comment type
  /// - [parent] The parent of comment (if type is translate parent is [Translation], if type is minecraft wiki parent is [MinecraftMod])
  /// - [content] Comment content
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<Comment> addComment<T extends APIModel>(
      {required CommentType type,
      required T parent,
      required String content,
      String? token}) async {
    if (parent is Translation || parent is MinecraftMod) {
      APIHttpResponse response = await httpClient.post("/comment/",
          body: {
            "type": type.name,
            "parentUUID": parent.uuid,
            "content": content
          },
          token: token);

      return Comment.fromMap(response.data);
    } else {
      throw Exception("parent must be a Translation or a MinecraftMod");
    }
  }

  /// Edit a comment.
  /// **Parameters**
  /// - [comment] The comment to edit
  /// - [content] Comment content
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<Comment> editComment(
      {required Comment comment,
      required String content,
      String? token}) async {
    APIHttpResponse response = await httpClient.patch(
        "/comment/${comment.uuid}",
        body: {"content": content},
        token: token);

    return Comment.fromMap(response.data);
  }

  /// Delete a comment.
  /// **Parameters**
  /// - [comment] The comment to delete
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<void> deleteComment({required Comment comment, String? token}) async {
    await httpClient.delete("/comment/${comment.uuid}", token: token);
  }

  /// Reply to a comment.
  /// **Parameters**
  /// - [comment] The comment to reply to
  /// - [content] Comment content
  /// - [token] The token to use for authentication (optional if you have set a global token).
  Future<Comment> replyComment(
      {required Comment comment,
      required String content,
      String? token}) async {
    APIHttpResponse response = await httpClient.post(
        "/comment/${comment.uuid}/reply",
        body: {"content": content},
        token: token);

    return Comment.fromMap(response.data);
  }
}
