// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeReply _$LikeReplyFromJson(Map<String, dynamic> json) => LikeReply(
      activeUid: json['activeUid'] as String,
      createdAt: json['createdAt'],
      postCommentReplyId: json['postCommentReplyId'] as String,
      tokenId: json['tokenId'] as String,
      tokenType: json['tokenType'] as String,
      postCommentReplyDocRef: json['postCommentReplyDocRef'],
    );

Map<String, dynamic> _$LikeReplyToJson(LikeReply instance) => <String, dynamic>{
      'activeUid': instance.activeUid,
      'createdAt': instance.createdAt,
      'postCommentReplyId': instance.postCommentReplyId,
      'tokenId': instance.tokenId,
      'tokenType': instance.tokenType,
      'postCommentReplyDocRef': instance.postCommentReplyDocRef,
    };
