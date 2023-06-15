import '../domain/models/item.model.dart';
import '../domain/models/mob.model.dart';
import '../domain/models/player.model.dart';

class HelpCommands {
  final String title;
  final String start;
  final String hunt;
  final String heal;
  final String shop;
  final String profile;
  final String equip;
  final String ranking;
  final String language;

  HelpCommands({
    required this.title,
    required this.start,
    required this.hunt,
    required this.heal,
    required this.shop,
    required this.profile,
    required this.equip,
    required this.ranking,
    required this.language,
  });
}

class StartCommands {
  final Function(String) welcome;
  final String error;
  final String playerAlreadyStarted;
  final String initiateOnTelegran;

  StartCommands({
    required this.welcome,
    required this.error,
    required this.playerAlreadyStarted,
    required this.initiateOnTelegran,
  });
}

class CommonsCommands {
  final String needToStart;
  final String somethingWrong;
  final String waitMessage;
  final String notAuthorized;
  final String botMaintenance;
  final String commandOnlyForPrivate;
  final String youAreNotKatekko;
  final String commandNotFound;

  CommonsCommands({
    required this.needToStart,
    required this.somethingWrong,
    required this.waitMessage,
    required this.notAuthorized,
    required this.botMaintenance,
    required this.commandOnlyForPrivate,
    required this.youAreNotKatekko,
    required this.commandNotFound,
  });
}

class HuntCommands {
  final HuntFindCommands find;
  final HuntAttackCommands attack;

  HuntCommands({required this.find, required this.attack});
}

class HuntFindCommands {
  final Function(MobModel) found;
  final String failedToSearch;
  HuntFindCommands({required this.found, required this.failedToSearch});
}

class HuntAttackCommands {
  final Function(String, int, int) attacking;
  final Function(String, int, int) attacked;
  final Function(String) defeated;
  final Function(String, int) mobDefeated;
  final String failedToAttack;
  final Function(int) levelUp;
  final Function(ItemModel) itemFound;

  HuntAttackCommands({
    required this.attacking,
    required this.attacked,
    required this.defeated,
    required this.mobDefeated,
    required this.failedToAttack,
    required this.levelUp,
    required this.itemFound,
  });
}

class ProfileCommands {
  final Function(PlayerModel) info;
  ProfileCommands({required this.info});
}

class ShopCommands {
  final Function(List<ItemModel>) info;
  final Function(String) itemNotFound;
  final String missingArguments;
  final Function(String) insufficientCoins;
  final Function(ItemModel, int, int) buy;
  final String notIdle;

  ShopCommands({
    required this.info,
    required this.itemNotFound,
    required this.missingArguments,
    required this.insufficientCoins,
    required this.buy,
    required this.notIdle,
  });
}

class RankingCommands {
  final Function(List<PlayerModel>) leaderboard;

  RankingCommands({
    required this.leaderboard,
  });
}

class HealCommands {
  final Function(int, int, String) healedWithItem;
  final String noPotion;
  final String failedToHeal;

  HealCommands({
    required this.healedWithItem,
    required this.noPotion,
    required this.failedToHeal,
  });
}

class InventoryCommands {
  final String emptyInventory;
  final Function(PlayerModel) open;

  InventoryCommands({
    required this.emptyInventory,
    required this.open,
  });
}

class LanguageCommands {
  final Function(String) changed;
  final String error;

  LanguageCommands({
    required this.changed,
    required this.error,
  });
}

class MigrateCommands {
  final String all;
  final String mobs;
  final String players;
  final String items;
  final String error;

  MigrateCommands({
    required this.all,
    required this.mobs,
    required this.players,
    required this.items,
    required this.error,
  });
}

class CommandsI18n {
  final HelpCommands help;
  final StartCommands start;
  final CommonsCommands commons;
  final HuntCommands hunt;
  final ShopCommands shop;
  final RankingCommands ranking;
  final HealCommands heal;
  final InventoryCommands inventory;
  final LanguageCommands language;
  final MigrateCommands migrate;
  final ProfileCommands profile;

  CommandsI18n({
    required this.help,
    required this.start,
    required this.commons,
    required this.hunt,
    required this.shop,
    required this.ranking,
    required this.heal,
    required this.inventory,
    required this.language,
    required this.migrate,
    required this.profile,
  });
}

abstract class CommandTranslations {
  String getLocale();
  CommandsI18n get commands;
}
