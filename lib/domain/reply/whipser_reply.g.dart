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
      isHidden: json['isHidden'] as bool,
      isNFTicon: json['isNFTicon'] as bool,
      isOfficial: json['isOfficial'] as bool,
      isPinned: json['isPinned'] as bool,
      likeCount: json['likeCount'] as int,
      mainWalletAddress: json['mainWalletAddress'] as String,
      muteCount: json['muteCount'] as int,
      nftIconInfo: json['nftIconInfo'] as Map<String, dynamic>,
      passiveUid: json['passiveUid'] as String,
      postId: json['postId'] as String,
      reply: json['reply'] as String,
      replyLanguageCode: json['replyLanguageCode'] as String,
      replyNegativeScore: json['replyNegativeScore'] as num,
      replyPositiveScore: json['replyPositiveScore'] as num,
      replySentiment: json['replySentiment'] as String,
      postCommentReplyId: json['postCommentReplyId'] as String,
      postCreatorUid: json['postCreatorUid'] as String,
      postDocRef: json['postDocRef'],
      reportCount: json['reportCount'] as int,
      score: json['score'] as num,
      uid: json['uid'] as String,
      updatedAt: json['updatedAt'],
      userImageURL: json['userImageURL'] as String,
      userImageNegativeScore: json['userImageNegativeScore'] as num,
      userName: json['userName'] as String,
      userNameLanguageCode: json['userNameLanguageCode'] as String,
      userNameNegativeScore: json['userNameNegativeScore'] as num,
      userNamePositiveScore: json['userNamePositiveScore'] as num,
      userNameSentiment: json['userNameSentiment'] as String,
    );

Map<String, dynamic> _$WhisperReplyToJson(WhisperReply instance) =>
    <String, dynamic>{
      'accountName': instance.accountName,
      'createdAt': instance.createdAt,
      'followerCount': instance.followerCount,
      'isHidden': instance.isHidden,
      'isNFTicon': instance.isNFTicon,
      'isOfficial': instance.isOfficial,
      'isPinned': instance.isPinned,
      'likeCount': instance.likeCount,
      'mainWalletAddress': instance.mainWalletAddress,
      'muteCount': instance.muteCount,
      'nftIconInfo': instance.nftIconInfo,
      'passiveUid': instance.passiveUid,
      'postId': instance.postId,
      'reply': instance.reply,
      'replyLanguageCode': instance.replyLanguageCode,
      'replyNegativeScore': instance.replyNegativeScore,
      'replyPositiveScore': instance.replyPositiveScore,
      'replySentiment': instance.replySentiment,
      'postCommentId': instance.postCommentId,
      'postCommentReplyId': instance.postCommentReplyId,
      'postCreatorUid': instance.postCreatorUid,
      'postDocRef': instance.postDocRef,
      'reportCount': instance.reportCount,
      'score': instance.score,
      'uid': instance.uid,
      'updatedAt': instance.updatedAt,
      'userImageURL': instance.userImageURL,
      'userImageNegativeScore': instance.userImageNegativeScore,
      'userName': instance.userName,
      'userNameLanguageCode': instance.userNameLanguageCode,
      'userNameNegativeScore': instance.userNameNegativeScore,
      'userNamePositiveScore': instance.userNamePositiveScore,
      'userNameSentiment': instance.userNameSentiment,
    };
