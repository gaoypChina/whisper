// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whipser_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WhisperReply _$WhisperReplyFromJson(Map<String, dynamic> json) => WhisperReply(
      accountName: json['accountName'] as String,
      createdAt: json['createdAt'],
      postCommentId: json['postCommentId'] as String,
      followerCount: json['followerCount'] as int,
      isDelete: json['isDelete'] as bool,
      isNFTicon: json['isNFTicon'] as bool,
      isOfficial: json['isOfficial'] as bool,
      likeCount: json['likeCount'] as int,
      negativeScore: json['negativeScore'] as num,
      passiveUid: json['passiveUid'] as String,
      postId: json['postId'] as String,
      positiveScore: json['positiveScore'] as num,
      reply: json['reply'] as String,
      postCommentReplyId: json['postCommentReplyId'] as String,
      postDocRef: json['postDocRef'],
      score: json['score'] as num,
      uid: json['uid'] as String,
      updatedAt: json['updatedAt'],
      userName: json['userName'] as String,
      userImageURL: json['userImageURL'] as String,
    );

Map<String, dynamic> _$WhisperReplyToJson(WhisperReply instance) =>
    <String, dynamic>{
      'accountName': instance.accountName,
      'createdAt': instance.createdAt,
      'followerCount': instance.followerCount,
      'isDelete': instance.isDelete,
      'isNFTicon': instance.isNFTicon,
      'isOfficial': instance.isOfficial,
      'likeCount': instance.likeCount,
      'negativeScore': instance.negativeScore,
      'passiveUid': instance.passiveUid,
      'postId': instance.postId,
      'positiveScore': instance.positiveScore,
      'reply': instance.reply,
      'postCommentId': instance.postCommentId,
      'postCommentReplyId': instance.postCommentReplyId,
      'postDocRef': instance.postDocRef,
      'score': instance.score,
      'uid': instance.uid,
      'updatedAt': instance.updatedAt,
      'userName': instance.userName,
      'userImageURL': instance.userImageURL,
    };
