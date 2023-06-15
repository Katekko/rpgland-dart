import './item.model.dart';
import '../../data/dto/mob.data.dart';

class MobModel {
  final String id;
  final String name;
  final int level;
  final int expDrop;
  final List<ItemModel> itemsDrop;
  final double chanceToAppear;
  final int attack;

  int health;

  MobModel({
    required this.id,
    required this.name,
    required this.level,
    required this.expDrop,
    required this.itemsDrop,
    required this.health,
    required this.chanceToAppear,
    required this.attack,
  });

  MobData toData() {
    final mob = MobData(
      id: id,
      name: name,
      level: level,
      expDrop: expDrop,
      health: health,
      chanceToAppear: chanceToAppear,
      attack: attack,
      itemsDrop: itemsDrop.map((e) => e.toData()).toList(),
    );

    return mob;
  }

  static MobModel fromData(MobData data) {
    final model = MobModel(
      id: data.id,
      name: data.name,
      level: data.level,
      expDrop: data.expDrop,
      health: data.health,
      chanceToAppear: data.chanceToAppear,
      attack: data.attack,
      itemsDrop: data.itemsDrop.map((e) => ItemModel.fromData(e)).toList(),
    );
    return model;
  }
}
