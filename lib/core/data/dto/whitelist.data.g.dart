// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whitelist.data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WhitelistData _$WhitelistDataFromJson(Map<String, dynamic> json) =>
    WhitelistData(
      id: json['id'] as String,
      number: json['number'] as String?,
      allow: json['allow'] as bool,
      telegramId: json['telegramId'] as String?,
    );

Map<String, dynamic> _$WhitelistDataToJson(WhitelistData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'allow': instance.allow,
      'telegramId': instance.telegramId,
    };
