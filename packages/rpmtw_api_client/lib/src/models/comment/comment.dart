import "dart:convert";

import "package:rpmtw_api_client/src/models/api_model.dart";
import "package:rpmtw_api_client/src/models/comment/comment_type.dart";

class Comment implements APIModel {
  @override
  final String uuid;

  /// Comment content in Markdown format.
  /// Can use @[userUUID] to tag others. (UUID will not be displayed in the UI, but the username)
  final String content;

  /// The type of the comment.
  final CommentType type;

  /// UUID of the user who sent this comment
  final String userUUID;

  /// If the type is [CommentType.translate] parent is the [SourceText]
  /// If the type is [CommentType.wiki] parent is the [MinecraftMod].
  final String parentUUID;

  /// The time when the comment was created.
  final DateTime createdAt;

  /// The time when the comment was last updated.
  final DateTime updatedAt;

  final bool isHidden;

  /// If the comment is a reply to another comment, this field will be set.
  final String? replyCommentUUID;
  Comment({
    required this.uuid,
    required this.content,
    required this.type,
    required this.userUUID,
    required this.parentUUID,
    required this.createdAt,
    required this.updatedAt,
    required this.isHidden,
    this.replyCommentUUID,
  });

  Future<List<Comment>> getReplies() async {
    return Comment.list(
      type: type,
      parentUUID: uuid,
    );
  }

  Comment copyWith({
    String? uuid,
    String? content,
    CommentType? type,
    String? userUUID,
    String? parentUUID,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isHidden,
    String? replyCommentUUID,
  }) {
    return Comment(
      uuid: uuid ?? this.uuid,
      content: content ?? this.content,
      type: type ?? this.type,
      userUUID: userUUID ?? this.userUUID,
      parentUUID: parentUUID ?? this.parentUUID,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isHidden: isHidden ?? this.isHidden,
      replyCommentUUID: replyCommentUUID ?? this.replyCommentUUID,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "uuid": uuid,
      "content": content,
      "type": type.name,
      "userUUID": userUUID,
      "parentUUID": parentUUID,
      "createdAt": createdAt.millisecondsSinceEpoch,
      "updatedAt": updatedAt.millisecondsSinceEpoch,
      "isHidden": isHidden,
      "replyCommentUUID": replyCommentUUID,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      uuid: map["uuid"] ?? "",
      content: map["content"] ?? "",
      type: CommentType.values.byName(map["type"]),
      userUUID: map["userUUID"] ?? "",
      parentUUID: map["parentUUID"] ?? "",
      createdAt: DateTime.fromMillisecondsSinceEpoch(map["createdAt"]),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map["updatedAt"]),
      isHidden: map["isHidden"] ?? false,
      replyCommentUUID: map["replyCommentUUID"],
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));

  @override
  String toString() {
    return "Comment(uuid: $uuid, content: $content, type: $type, userUUID: $userUUID, parentUUID: $parentUUID, createdAt: $createdAt, updatedAt: $updatedAt, isHidden: $isHidden, replyCommentUUID: $replyCommentUUID)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment &&
        other.uuid == uuid &&
        other.content == content &&
        other.type == type &&
        other.userUUID == userUUID &&
        other.parentUUID == parentUUID &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.isHidden == isHidden &&
        other.replyCommentUUID == replyCommentUUID;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        content.hashCode ^
        type.hashCode ^
        userUUID.hashCode ^
        parentUUID.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        isHidden.hashCode ^
        replyCommentUUID.hashCode;
  }

  static Future<Comment?> getByUUID(String uuid) => throw UnimplementedError();

  static Future<List<Comment>> list(
          {required CommentType type,
          String? parentUUID,
          String? replyCommentUUID,
          int? limit,
          int? skip}) =>
      throw UnimplementedError();
}
