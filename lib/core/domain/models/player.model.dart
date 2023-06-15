import 'dart:math';

import 'package:rpgland/core/data/dto/player.data.dart';
import 'package:uuid/uuid.dart';

import '../enums/item_type.enum.dart';
import '../enums/player_state.enum.dart';
import 'item.model.dart';
import 'mob.model.dart';

class PlayerModel {
  final String id;
  final String? telegramId;
  final String name;
  final String telephoneNumber;
  final List<ItemModel> inventory;

  late int health;

  int level;
  int exp;
  String language;
  PlayerState state;
  MobModel? huntAgainst;

  // TODO: Remove this constants and create a config file
  final int baseExp = 100;
  final double expMultiplier = 1.5;

  int getMaxHealth() {
    return _baseHealth;
  }

  // Max range of your attack
  int getMaxAttack() {
    return baseAttack * level;
  }

  // Random attack to attack the mob
  int getRandomAttack() {
    final playerAttack = getMaxAttack();
    final randomDamage = (Random().nextDouble() * (playerAttack - 1)) + 1;
    final roundedDamage = randomDamage.round();
    return roundedDamage;
  }

  // Base health of the player
  int get _baseHealth {
    //modificadores de gear
    return 40;
  }

  int get baseAttack {
    var baseAttack = 5; // Default base attack value
    final equippedItems = inventory
        .where((item) => item.equipped && item.type == ItemType.weapon);

    if (equippedItems.isNotEmpty) {
      baseAttack += equippedItems.fold(
        0,
        (totalAttack, item) => totalAttack + item.value,
      );
    }

    return baseAttack;
  }

  void setPlayerDeath() {
    state = PlayerState.idle;
    huntAgainst = null;
    level -= level == 1 ? 0 : 1;
    health = _baseHealth;
    exp = 0;
  }

  int getExpNeededForNextLevel() {
    return (baseExp * pow(expMultiplier, level - 1)).floor();
  }

  PlayerModel({
    required this.id,
    required this.name,
    required this.telephoneNumber,
    this.telegramId,
    int? health,
    this.level = 1,
    this.state = PlayerState.idle,
    this.exp = 0,
    this.inventory = const [],
    this.language = 'pt_BR',
    this.huntAgainst,
  }) {
    this.health = health ?? _baseHealth;
  }

  static PlayerModel createNew(
    String name,
    String telephone,
    String? telegramId,
  ) {
    telephone = telephone.replaceAll('+', '');
    final languagePtBr = telephone.startsWith('55');

    final player = PlayerModel(
      id: Uuid().v4(),
      name: name,
      telephoneNumber: telephone,
      language: languagePtBr ? 'pt_BR' : 'en',
      telegramId: telegramId,
    );

    return player;
  }

  PlayerData toData() {
    final player = PlayerData(
      id: id,
      telegramId: telegramId,
      name: name,
      telephoneNumber: telephoneNumber,
      health: health,
      exp: exp,
      language: language,
      level: level,
      state: state,
      huntAgainst: huntAgainst?.toData(),
      inventory: inventory.map((e) => e.toData()).toList(),
    );

    return player;
  }

  static PlayerModel fromData(PlayerData data) {
    final model = PlayerModel(
      id: data.id,
      name: data.name,
      telephoneNumber: data.telephoneNumber,
      exp: data.exp,
      health: data.health,
      language: data.language,
      level: data.level,
      state: data.state,
      telegramId: data.telegramId,
      inventory: data.inventory.map((e) => ItemModel.fromData(e)).toList(),
      huntAgainst: data.huntAgainst != null
          ? MobModel.fromData(data.huntAgainst!)
          : null,
    );

    return model;
  }
}
