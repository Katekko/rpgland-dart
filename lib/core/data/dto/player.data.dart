import 'package:json_annotation/json_annotation.dart';
import 'package:rpgland/core/domain/abstractions/models/data.model.dart';

import '../../domain/enums/player_state.enum.dart';
import 'item.data.dart';
import 'mob.data.dart';

part 'player.data.g.dart';

@JsonSerializable()
class PlayerData extends DataModel {
  // final String telegramId;
  final String name;
  final String telephoneNumber;
  final List<ItemData> inventory;
  final int health;
  final int level;
  final int exp;
  final String language;
  final PlayerState state;
  final MobData? huntAgainst;

  PlayerData({
    required super.id,
    // required this.telegramId,
    required this.name,
    required this.inventory,
    required this.telephoneNumber,
    required this.health,
    required this.exp,
    required this.huntAgainst,
    required this.language,
    required this.level,
    required this.state,
  });

  factory PlayerData.fromJson(Map<String, dynamic> json) =>
      _$PlayerDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PlayerDataToJson(this);
}
