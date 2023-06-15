import 'package:json_annotation/json_annotation.dart';

import '../../domain/abstractions/models/data.model.dart';
import 'item.data.dart';

part 'mob.data.g.dart';

@JsonSerializable()
class MobData extends DataModel {
  final String name;
  final int level;
  final int expDrop;
  final List<ItemData> itemsDrop;
  final double chanceToAppear;
  final int attack;
  final int health;

  MobData({
    required super.id,
    required this.name,
    required this.level,
    required this.expDrop,
    required this.itemsDrop,
    required this.health,
    required this.chanceToAppear,
    required this.attack,
  });

  factory MobData.fromJson(Map<String, dynamic> json) =>
      _$MobDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MobDataToJson(this);
}
