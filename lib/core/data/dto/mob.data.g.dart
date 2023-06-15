// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mob.data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MobData _$MobDataFromJson(Map<String, dynamic> json) => MobData(
      id: json['id'] as String,
      name: json['name'] as String,
      level: json['level'] as int,
      expDrop: json['expDrop'] as int,
      itemsDrop: (json['itemsDrop'] as List<dynamic>)
          .map((e) => ItemData.fromJson(e as Map<String, dynamic>))
          .toList(),
      health: json['health'] as int,
      chanceToAppear: (json['chanceToAppear'] as num).toDouble(),
      attack: json['attack'] as int,
    );

Map<String, dynamic> _$MobDataToJson(MobData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'level': instance.level,
      'expDrop': instance.expDrop,
      'itemsDrop': instance.itemsDrop,
      'chanceToAppear': instance.chanceToAppear,
      'attack': instance.attack,
      'health': instance.health,
    };
