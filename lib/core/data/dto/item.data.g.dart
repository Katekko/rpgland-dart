// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemData _$ItemDataFromJson(Map<String, dynamic> json) => ItemData(
      id: json['id'] as String,
      name: json['name'] as String,
      value: json['value'] as int,
      dropChance: (json['dropChance'] as num).toDouble(),
      amount: json['amount'] as int,
      type: $enumDecode(_$ItemTypeEnumMap, json['type']),
      price: json['price'] as int,
      equipped: json['equipped'] as bool,
    );

Map<String, dynamic> _$ItemDataToJson(ItemData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'value': instance.value,
      'dropChance': instance.dropChance,
      'amount': instance.amount,
      'type': _$ItemTypeEnumMap[instance.type]!,
      'price': instance.price,
      'equipped': instance.equipped,
    };

const _$ItemTypeEnumMap = {
  ItemType.currency: 'Currency',
  ItemType.healthPotion: 'HealthPotion',
  ItemType.weapon: 'Weapon',
};
