// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'official_advertisement_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfficialAdvertisementConfig _$OfficialAdvertisementConfigFromJson(
        Map<String, dynamic> json) =>
    OfficialAdvertisementConfig(
      createdAt: json['createdAt'],
      intervalSeconds: json['intervalSeconds'] as int,
      timeInSecForIosWeb: json['timeInSecForIosWeb'] as int,
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$OfficialAdvertisementConfigToJson(
        OfficialAdvertisementConfig instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'intervalSeconds': instance.intervalSeconds,
      'timeInSecForIosWeb': instance.timeInSecForIosWeb,
      'updatedAt': instance.updatedAt,
    };
