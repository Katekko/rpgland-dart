import 'package:rpgland/core/data/dto/item.data.dart';

import '../enums/item_type.enum.dart';

class ItemModel {
  final String id;
  final String name;
  final int value;
  final double dropChance;
  final int amount;
  final ItemType type;
  final int price;
  final bool equipped;

  ItemModel({
    required this.id,
    required this.name,
    required this.value,
    required this.dropChance,
    required this.amount,
    required this.type,
    required this.price,
    required this.equipped,
  });

  ItemData toData() {
    final item = ItemData(
      id: id,
      amount: amount,
      dropChance: dropChance,
      equipped: equipped,
      name: name,
      price: price,
      type: type,
      value: value,
    );

    return item;
  }

  static ItemModel fromData(ItemData data) {
    return ItemModel(
      id: data.id,
      name: data.name,
      value: data.value,
      dropChance: data.dropChance,
      amount: data.amount,
      type: data.type,
      price: data.price,
      equipped: data.equipped,
    );
  }
}
