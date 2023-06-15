import 'package:json_annotation/json_annotation.dart';
import 'package:rpgland/core/domain/abstractions/models/data.model.dart';
import 'package:rpgland/core/domain/enums/item_type.enum.dart';

part 'item.data.g.dart';

@JsonSerializable()
class ItemData extends DataModel {
  final String name;
  final int value;
  final double dropChance;
  final int amount;
  final ItemType type;
  final int price;
  final bool equipped;

  ItemData({
    required super.id,
    required this.name,
    required this.value,
    required this.dropChance,
    required this.amount,
    required this.type,
    required this.price,
    required this.equipped,
  });

  factory ItemData.fromJson(Map<String, dynamic> json) =>
      _$ItemDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ItemDataToJson(this);
}
