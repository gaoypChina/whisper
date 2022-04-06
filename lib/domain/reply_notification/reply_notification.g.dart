// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyNotification _$ReplyNotificationFromJson(Map<String, dynamic> json) =>
    ReplyNotification(
      accountName: json['accountName'] as String,
      activeUid: json['activeUid'] as String,
      comment: json['comment'] as String,
      createdAt: json['createdAt'],
      postCommentId: json['postCommentId'] as String,
      followerCount: json['followerCount'] as int,
      isDelete: json['isDelete'] as bool,
      isNFTicon: json['isNFTicon'] as bool,
      isOfficial: json['isOfficial'] as bool,
      isRead: json['isRead'] as bool,
      mainWalletAddress: json['mainWalletAddress'] as String,
      masterReplied: json['masterReplied'] as bool,
      nftIconInfo: json['nftIconInfo'] as Map<String, dynamic>,
      notificationId: json['notificationId'] as String,
      passiveUid: json['passiveUid'] as String,
      postId: json['postId'] as String,
      postCommentDocRef: json['postCommentDocRef'],
      postCommentReplyId: json['postCommentReplyId'] as String,
      postDocRef: json['postDocRef'],
      notificationType: json['notificationType'] as String,
      reply: json['reply'] as String,
      replyLanguageCode: json['replyLanguageCode'] as String,
      replyNegativeScore: json['replyNegativeScore'] as num,
      replyPositiveScore: json['replyPositiveScore'] as num,
      replySentiment: json['replySentiment'] as String,
      replyScore: json['replyScore'] as num,
      updatedAt: json['updatedAt'],
      userImageURL: json['userImageURL'] as String,
      userImageNegativeScore: json['userImageNegativeScore'] as num,
      userName: json['userName'] as String,
      userNameLanguageCode: json['userNameLanguageCode'] as String,
      userNameNegativeScore: json['userNameNegativeScore'] as num,
      userNamePositiveScore: json['userNamePositiveScore'] as num,
      userNameSentiment: json['userNameSentiment'] as String,
    );

Map<String, dynamic> _$ReplyNotificationToJson(ReplyNotification instance) =>
    <String, dynamic>{
      'accountName': instance.accountName,
      'activeUid': instance.activeUid,
      'comment': instance.comment,
      'createdAt': instance.createdAt,
      'postCommentId': instance.postCommentId,
      'followerCount': instance.followerCount,
      'isDelete': instance.isDelete,
      'isNFTicon': instance.isNFTicon,
      'isOfficial': instance.isOfficial,
      'isRead': instance.isRead,
      'mainWalletAddress': instance.mainWalletAddress,
      'masterReplied': instance.masterReplied,
      'nftIconInfo': instance.nftIconInfo,
      'notificationId': instance.notificationId,
      'passiveUid': instance.passiveUid,
      'postId': instance.postId,
      'reply': instance.reply,
      'replyLanguageCode': instance.replyLanguageCode,
      'replyNegativeScore': instance.replyNegativeScore,
      'replyPositiveScore': instance.replyPositiveScore,
      'replySentiment': instance.replySentiment,
      'replyScore': instance.replyScore,
      'postCommentReplyId': instance.postCommentReplyId,
      'postCommentDocRef': instance.postCommentDocRef,
      'postDocRef': instance.postDocRef,
      'notificationType': instance.notificationType,
      'updatedAt': instance.updatedAt,
      'userImageURL': instance.userImageURL,
      'userImageNegativeScore': instance.userImageNegativeScore,
      'userName': instance.userName,
      'userNameLanguageCode': instance.userNameLanguageCode,
      'userNameNegativeScore': instance.userNameNegativeScore,
      'userNamePositiveScore': instance.userNamePositiveScore,
      'userNameSentiment': instance.userNameSentiment,
    };
