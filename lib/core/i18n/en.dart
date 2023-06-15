import 'package:collection/collection.dart';

import './translation.dart';
import '../domain/enums/item_type.enum.dart';
import '../domain/models/item.model.dart';
import '../domain/models/mob.model.dart';
import '../domain/models/player.model.dart';

class TranslationEn extends CommandTranslations {
  final String commandChar;
  late final HelpCommands helpCommands;
  late final StartCommands startCommands;
  late final CommonsCommands commonsCommands;
  late final HuntCommands huntCommands;
  late final ShopCommands shopCommands;
  late final RankingCommands rankingCommands;
  late final HealCommands healCommands;
  late final InventoryCommands inventoryCommands;
  late final LanguageCommands languageCommands;
  late final MigrateCommands migrateCommands;
  late final ProfileCommands profileCommands;

  TranslationEn(this.commandChar) {
    createCommands();
  }

  @override
  String getLocale() {
    return 'pt_BR';
  }

  String _createProfileBox(String profile) {
    final width = 20;
    final horizontalLine = '─' * width;
    final boxTop = '╭$horizontalLine╮\n';
    final boxBottom = '\n╰$horizontalLine╯';
    final emptyLine = ' ' * width;
    return '$boxTop$emptyLine\n\t$profile\n$emptyLine$boxBottom';
  }

  void createCommands() {
    helpCommands = HelpCommands(
      title:
          '🌍 *Welcome to the RPG Land world!* 🌍\n```Embark on an epic journey, conquer challenging areas, and become a legendary adventurer.\nLearn how to play:```',
      start:
          '🎮 *START*   -> ```Begin your adventure in RPG Land! Use this command to start your journey and explore the vast world full of challenges, treasures, and epic quests.\n🌟 *$commandChar}start*```',
      hunt:
          '🏹 *HUNT*   -> ```Venture into the wild to hunt dangerous creatures and earn EXP and coins.\n🕵️‍♂️ *$commandChar}hunt find*\n⚔️ *$commandChar}hunt attack*```',
      heal:
          '🩹 *HEAL*   -> ```Consume a health potion to restore your health points (HP) ❤️ when they are low.\n🍷 *$commandChar}heal <amount | 1>*```',
      shop:
          '🛍️ *SHOP*   -> ```Visit the market to spend your hard-earned coins on various items, equipment, and upgrades.\n🛒 *$commandChar}shop info*\n💰 *$commandChar}shop buy <item name> <amount>*```',
      profile:
          '🧍 *PROFILE*   -> ```Check your player profile and statistics.\n📊 *$commandChar}profile*```',
      equip:
          '⚔️ *EQUIP*   -> ```Equip items to become stronger.\n📊 *$commandChar}equip <item name>*```',
      ranking:
          '🏆 *RANKING*   -> ```Check the ranking to see the top players by level.\n👑 *$commandChar}ranking*```',
      language:
          '🌐 To change the bot language, use the *language* command followed by the desired language code.\n\nExample: `--language en` or `--language pt_BR`.',
    );

    startCommands = StartCommands(
      welcome: (String name) =>
          '🌍 Welcome to the world of RPG Land, *$name*! 🌍\nEmbark on an epic journey, conquer challenging areas, and become a legendary adventurer. ⚔️🛡️\n\n🕵️‍♂️ To find mobs, use the command: *$commandChar}hunt find*\n⚔️ To attack a mob, use the command: *$commandChar}hunt attack*',
      error: '❌ Failed to start your journey',
      playerAlreadyStarted:
          '❌ Oops! It looks like you are already in the game.',
      initiateOnTelegran:
          '🌍 To initiate your adventure, please share your contact information. 🌍',
    );

    commonsCommands = CommonsCommands(
      needToStart:
          '⚠️ You need to start your journey first\nSend: *$commandChar}start*',
      somethingWrong: '❌❌❌ Something went wrong, please contact Katekko ❌❌❌',
      waitMessage: '⏳ Please wait a moment before sending another message.',
      notAuthorized:
          '❌ You are not authorized to use this bot. ❌\nContact the administrator for access.\n*Katekko#1429* ',
      botMaintenance:
          '🛠️ The bot is currently undergoing maintenance. 🛠️\nPlease try again later.',
      commandOnlyForPrivate:
          '❌ This command can only be used in private chats. ❌',
      youAreNotKatekko: '❌ You are not Katekko, you scoundrel. ❌',
      commandNotFound: '❌ Command not found',
    );

    huntCommands = HuntCommands(
      find: HuntFindCommands(
        found: (MobModel mob) =>
            '🏹 Get ready for battle! 🏹\nYou have encountered a *${mob.name}* with *${mob.health}*❤️ health!',
        failedToSearch:
            '⚠️ You are already in hunting mode. Finish your current hunt before starting a new one.',
      ),
      attack: HuntAttackCommands(
        attacking: (String mob, int damage, int remainingHealth) =>
            '⚔️ You attacked *$mob* and dealt *$damage* damage! ⚔️\n*$mob* has *$remainingHealth* ❤️ remaining.',
        attacked: (String mob, int damage, int remainingHealth) =>
            '🔥 *$mob* attacked you and dealt *$damage* damage!\nYou have *$remainingHealth* ❤️ remaining.',
        defeated: (String mob) =>
            '☠️ You were defeated by *$mob*! ☠️\nYou lost a level.',
        mobDefeated: (String mob, int exp) =>
            '💥 You defeated *$mob* and gained *$exp* experience points!',
        failedToAttack:
            '⚠️ Currently, you are not hunting any mobs. Use the *$commandChar}hunt find* command to start hunting.',
        levelUp: (int level) =>
            '🎉 Congratulations! 🎉\nYou have reached level *$level*!',
        itemFound: (ItemModel item) =>
            '🎉 You found 💰${item.amount} ${item.name}! 🎉',
      ),
    );

    shopCommands = ShopCommands(
      info: (List<ItemModel> items) {
        final itemLines = items
            .map((item) => '🛒 *${item.name}* - Price: *${item.price}* coins')
            .toList();
        final itemsInfo = itemLines.join('\n');
        drawContinuousLine(int length) => '─' * length;
        final continuousLine = drawContinuousLine(20);
        return '🏪 Welcome to the shop! 🛍️\n$continuousLine\n$itemsInfo\n$continuousLine\nTo buy an item, use the command: *--shop buy <item name> <amount>*';
      },
      itemNotFound: (String itemName) =>
          '⚠️ The item *\'$itemName\'* is not available in the shop.\nCheck the item name and try again.',
      missingArguments:
          '⚠️ You need to provide the item name and the amount you want to buy.\nUsage: *--shop buy <item name> <amount>*',
      insufficientCoins: (String itemName) =>
          '⚠️ You don\'t have enough coins to buy *$itemName*.',
      buy: (ItemModel item, int amount, int totalPrice) =>
          '✅ You have successfully acquired 🛒*$amount ${item.name}* for 💰*$totalPrice* coins!\nEnjoy your new purchase! 🎉',
      notIdle:
          '⚠️ You cannot access the shop while engaged in another activity.\nFinish your current task before visiting the shop.',
    );

    rankingCommands = RankingCommands(
      leaderboard: (List<PlayerModel> players) {
        final emojiPositions = ['🥇', '🥈', '🥉'];
        var leaderboardMessage = '🏆 Ranking - Top players by level 🏆\n\n';
        for (var i = 0; i < players.length && i < 10; i++) {
          final player = players[i];
          final positionEmoji = i < 3 ? emojiPositions[i] : '#${i + 1}';
          leaderboardMessage +=
              '$positionEmoji ${player.name} - Level ${player.level}\n';
        }
        return leaderboardMessage;
      },
    );

    healCommands = HealCommands(
      healedWithItem: (int healedAmount, int currentHealth, String itemName) =>
          '🩹 You regenerated *$healedAmount HP* using a $itemName! 🎉\nYou currently have ❤️*$currentHealth HP*.',
      noPotion:
          '😰 You don\'t have any *Healing Potions* left. Visit the shop or continue hunting to get more.',
      failedToHeal:
          '⚠️ You are busy and cannot heal at the moment. Finish your current activity and try again.',
    );

    inventoryCommands = InventoryCommands(
      emptyInventory: '🎒 Inventory 🎒\n\n📦 Your inventory is empty.',
      open: (PlayerModel player) {
        var inventoryMessage = '🎒 Inventory 🎒\n';
        drawContinuousLine(int length) => '─' * length;
        final continuousLine = drawContinuousLine(20);

        inventoryMessage += '$continuousLine\n';

        for (var i = 0; i < player.inventory.length; i++) {
          final item = player.inventory[i];
          inventoryMessage +=
              '${i + 1}. ${item.name} - Quantity: ${item.amount}\n';
        }

        inventoryMessage += continuousLine;

        return inventoryMessage;
      },
    );

    languageCommands = LanguageCommands(
      changed: (String lang) => '✅ Language successfully changed to *$lang*',
      error:
          '❌ An error occurred while changing the language. ❌\nChoose between these two options: 🇧🇷 *pt_BR* or 🇺🇸 *en*.',
    );

    migrateCommands = MigrateCommands(
      all: '✅ Migration of *all data* complete.',
      mobs: '✅ Mob migration complete.',
      players: '✅ Player migration complete.',
      items: '✅ Item migration complete.',
      error: '❌ An *error* occurred during migration.',
    );

    profileCommands = ProfileCommands(
      profile: (PlayerModel player) {
        final progressBarLength = 10;
        final filledBarCount =
            (player.exp / player.getExpNeededForNextLevel()).floor() *
                progressBarLength;
        final emptyBarCount = progressBarLength - filledBarCount;

        final filledBar = '▓' * filledBarCount;
        final emptyBar = '░' * emptyBarCount;

        final coinItem = player.inventory.firstWhereOrNull(
          (item) => item.type == ItemType.currency,
        );

        final potionCount = player.inventory
            .where((item) => item.type == ItemType.healthPotion)
            .fold<int>(0, (total, item) => total + item.amount);

        return _createProfileBox(
          '```${player.state.toString()}```\n\t🧍 *${player.name}* > *Lv. ${player.level}*\n\t[$filledBar$emptyBar] (${player.exp}/${player.getExpNeededForNextLevel()})\n\n\t❤️ ${player.health}/${player.getMaxHealth()}   ⚔️ *${player.getMaxAttack()}   💰 ${coinItem?.amount ?? 0}   🍷 $potionCount*',
        );
      },
    );
  }

  @override
  CommandsI18n get commands {
    return CommandsI18n(
      help: helpCommands,
      start: startCommands,
      commons: commonsCommands,
      hunt: huntCommands,
      shop: shopCommands,
      ranking: rankingCommands,
      heal: healCommands,
      inventory: inventoryCommands,
      language: languageCommands,
      migrate: migrateCommands,
      profile: profileCommands,
    );
  }
}
