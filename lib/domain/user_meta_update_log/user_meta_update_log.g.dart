// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_meta_update_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMetaUpdateLog _$UserMetaUpdateLogFromJson(Map<String, dynamic> json) =>
    UserMetaUpdateLog(
      email: json['email'] as String,
      gender: json['gender'] as String,
      ipv6: json['ipv6'] as String,
      uid: json['uid'] as String,
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$UserMetaUpdateLogToJson(UserMetaUpdateLog instance) =>
    <String, dynamic>{
      'email': instance.email,
      'gender': instance.gender,
      'ipv6': instance.ipv6,
      'uid': instance.uid,
      'updatedAt': instance.updatedAt,
    };
