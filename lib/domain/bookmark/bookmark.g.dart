// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bookmark _$BookmarkFromJson(Map<String, dynamic> json) => Bookmark(
      activeUid: json['activeUid'] as String,
      createdAt: json['createdAt'],
      postId: json['postId'] as String,
    );

Map<String, dynamic> _$BookmarkToJson(Bookmark instance) => <String, dynamic>{
      'activeUid': instance.activeUid,
      'createdAt': instance.createdAt,
      'postId': instance.postId,
    };
