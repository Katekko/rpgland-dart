// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerData _$PlayerDataFromJson(Map<String, dynamic> json) => PlayerData(
      id: json['id'] as String,
      name: json['name'] as String,
      inventory: (json['inventory'] as List<dynamic>)
          .map((e) => ItemData.fromJson(e as Map<String, dynamic>))
          .toList(),
      telephoneNumber: json['telephoneNumber'] as String,
      health: json['health'] as int,
      exp: json['exp'] as int,
      huntAgainst: json['huntAgainst'] == null
          ? null
          : MobData.fromJson(json['huntAgainst'] as Map<String, dynamic>),
      language: json['language'] as String,
      level: json['level'] as int,
      state: $enumDecode(_$PlayerStateEnumMap, json['state']),
    );

Map<String, dynamic> _$PlayerDataToJson(PlayerData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'telephoneNumber': instance.telephoneNumber,
      'inventory': instance.inventory,
      'health': instance.health,
      'level': instance.level,
      'exp': instance.exp,
      'language': instance.language,
      'state': _$PlayerStateEnumMap[instance.state]!,
      'huntAgainst': instance.huntAgainst,
    };

const _$PlayerStateEnumMap = {
  PlayerState.idle: 'Idle',
  PlayerState.hunting: 'Hunting',
};
