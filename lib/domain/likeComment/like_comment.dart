// packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'like_comment.g.dart';

@JsonSerializable()
class LikeComment {
  LikeComment({
    required this.activeUid,
    required this.commentId,
    required this.createdAt,
  });
  
  final String activeUid;
  final String commentId;
  final dynamic createdAt;

  factory LikeComment.fromJson(Map<String,dynamic> json) => _$LikeCommentFromJson(json);

  Map<String,dynamic> toJson() => _$LikeCommentToJson(this);
}