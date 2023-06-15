import '../domain/models/item.model.dart';
import '../domain/models/mob.model.dart';
import '../domain/models/player.model.dart';

abstract class CommandTranslations {
  String getLocale();

  Map<String, dynamic> commands = {
    'help': {
      'title': '',
      'start': '',
      'hunt': '',
      'heal': '',
      'shop': '',
      'profile': '',
      'equip': '',
      'ranking': '',
      'language': '',
    },
    'start': {
      'welcome': (String name) => '',
      'error': '',
      'playerAlreadyStarted': '',
    },
    'commons': {
      'needToStart': '',
      'somethingWrong': '',
      'waitMessage': '',
      'notAuthorized': '',
      'botMaintenance': '',
      'commandOnlyForPrivate': '',
      'youAreNotKatekko': '',
      'commandNotFound': '',
    },
    'hunt': {
      'find': {
        'found': (MobModel mob) => '',
        'failedToSearch': '',
      },
      'attack': {
        'attacking': (String mob, int damage, int remainingHealth) => '',
        'attacked': (String mobName, int damage, int remainingHealth) => '',
        'defeated': (String mobName) => '',
        'mobDefeated': (String mobName, int exp) => '',
        'failedToAttack': '',
        'levelUp': (int level) => '',
        'itemFound': (ItemModel item) => '',
      },
    },
    'profile': (PlayerModel player) => '',
    'shop': {
      'info': (List<ItemModel> items) => '',
      'itemNotFound': (String itemName) => '',
      'missingArguments': '',
      'insufficientCoins': (String itemName) => '',
      'buy': (ItemModel item, int amount, int totalPrice) => '',
      'notIdle': '',
    },
    'ranking': {
      'leaderboard': (List<PlayerModel> players) => '',
    },
    'heal': {
      'healedWithItem':
          (int healedAmount, int currentHealth, String itemName) => '',
      'noPotion': '',
      'failedToHeal': '',
    },
    'inventory': {
      'emptyInventory': '',
      'open': (PlayerModel player) => '',
    },
    'language': {
      'changed': (String lang) => '',
      'error': '',
    },
    'migrate': {
      'mobs': '',
      'items': '',
      'players': '',
      'all': '',
      'error': '',
    },
    'equip': {
      'success': (String itemName) => '',
      'notWeapon': (String itemName) => '',
      'notFoundOrEquipped': (String itemName) => '',
      'noItemProvided': '',
    },
  };
}
