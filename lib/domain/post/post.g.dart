// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      accountName: json['accountName'] as String,
      audioURL: json['audioURL'] as String,
      bookmarkCount: json['bookmarkCount'] as int,
      commentsState: json['commentsState'] as String,
      country: json['country'] as String,
      createdAt: json['createdAt'],
      description: json['description'] as String,
      descriptionLanguageCode: json['descriptionLanguageCode'] as String,
      descriptionNegativeScore: json['descriptionNegativeScore'] as num,
      descriptionPositiveScore: json['descriptionPositiveScore'] as num,
      descriptionSentiment: json['descriptionSentiment'] as String,
      genre: json['genre'] as String,
      hashTags:
          (json['hashTags'] as List<dynamic>).map((e) => e as String).toList(),
      imageURLs:
          (json['imageURLs'] as List<dynamic>).map((e) => e as String).toList(),
      impressionCount: json['impressionCount'] as int,
      isNFTicon: json['isNFTicon'] as bool,
      isOfficial: json['isOfficial'] as bool,
      isPinned: json['isPinned'] as bool,
      likeCount: json['likeCount'] as int,
      links: (json['links'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      mainWalletAddress: json['mainWalletAddress'] as String,
      muteCount: json['muteCount'] as int,
      nftIconInfo: json['nftIconInfo'] as Map<String, dynamic>,
      playCount: json['playCount'] as int,
      postState: json['postState'] as String,
      postId: json['postId'] as String,
      postCommentCount: json['postCommentCount'] as int,
      recommendState: json['recommendState'] as String,
      reportCount: json['reportCount'] as int,
      score: json['score'] as num,
      storagePostName: json['storagePostName'] as String,
      searchToken: json['searchToken'] as Map<String, dynamic>,
      tagAccountNames: (json['tagAccountNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      title: json['title'] as String,
      titleLanguageCode: json['titleLanguageCode'],
      titleNegativeScore: json['titleNegativeScore'] as num,
      titlePositiveScore: json['titlePositiveScore'] as num,
      titleSentiment: json['titleSentiment'] as String,
      uid: json['uid'] as String,
      updatedAt: json['updatedAt'],
      userImageURL: json['userImageURL'] as String,
      userName: json['userName'] as String,
      userNameLanguageCode: json['userNameLanguageCode'] as String,
      userNameNegativeScore: json['userNameNegativeScore'] as num,
      userNamePositiveScore: json['userNamePositiveScore'] as num,
      userNameSentiment: json['userNameSentiment'] as String,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'accountName': instance.accountName,
      'audioURL': instance.audioURL,
      'bookmarkCount': instance.bookmarkCount,
      'commentsState': instance.commentsState,
      'country': instance.country,
      'createdAt': instance.createdAt,
      'description': instance.description,
      'descriptionLanguageCode': instance.descriptionLanguageCode,
      'descriptionNegativeScore': instance.descriptionNegativeScore,
      'descriptionPositiveScore': instance.descriptionPositiveScore,
      'descriptionSentiment': instance.descriptionSentiment,
      'genre': instance.genre,
      'hashTags': instance.hashTags,
      'imageURLs': instance.imageURLs,
      'impressionCount': instance.impressionCount,
      'isNFTicon': instance.isNFTicon,
      'isOfficial': instance.isOfficial,
      'isPinned': instance.isPinned,
      'likeCount': instance.likeCount,
      'links': instance.links,
      'mainWalletAddress': instance.mainWalletAddress,
      'muteCount': instance.muteCount,
      'nftIconInfo': instance.nftIconInfo,
      'playCount': instance.playCount,
      'postState': instance.postState,
      'postCommentCount': instance.postCommentCount,
      'postId': instance.postId,
      'recommendState': instance.recommendState,
      'reportCount': instance.reportCount,
      'score': instance.score,
      'storagePostName': instance.storagePostName,
      'searchToken': instance.searchToken,
      'tagAccountNames': instance.tagAccountNames,
      'title': instance.title,
      'titleLanguageCode': instance.titleLanguageCode,
      'titleNegativeScore': instance.titleNegativeScore,
      'titlePositiveScore': instance.titlePositiveScore,
      'titleSentiment': instance.titleSentiment,
      'uid': instance.uid,
      'updatedAt': instance.updatedAt,
      'userImageURL': instance.userImageURL,
      'userName': instance.userName,
      'userNameLanguageCode': instance.userNameLanguageCode,
      'userNameNegativeScore': instance.userNameNegativeScore,
      'userNamePositiveScore': instance.userNamePositiveScore,
      'userNameSentiment': instance.userNameSentiment,
    };
