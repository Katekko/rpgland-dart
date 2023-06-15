import 'package:collection/collection.dart';

import '../domain/enums/item_type.enum.dart';
import '../domain/models/item.model.dart';
import '../domain/models/mob.model.dart';
import '../domain/models/player.model.dart';
import './translation.dart';

class TranslationEn extends CommandTranslations {
  String commandChar;
  TranslationEn(this.commandChar) : super();

  @override
  String getLocale() {
    return 'en';
  }

  String _createProfileBox(String profile) {
    final width = 20;
    final horizontalLine = '─' * width;
    final boxTop = '╭$horizontalLine╮\n';
    final boxBottom = '\n╰$horizontalLine╯';
    final emptyLine = ' ' * width;
    return '$boxTop$emptyLine\n\t$profile\n$emptyLine$boxBottom';
  }

  @override
  Map<String, dynamic> get commands => {
        'help': {
          'title':
              '🌍 *Welcome to the world of RPG Land!* 🌍\n```Embark on an epic journey, conquer challenging areas, and become a legendary adventurer.\nHere\'s how to play:```',
          'start':
              '🎮 *START*   -> ```Begin your adventure in RPG Land! Use this command to initiate your journey and explore the vast world filled with challenges, treasures, and epic quests.\n🌟 *$commandChar'
                  'start*```',
          'hunt':
              '🏹 *HUNT*   -> ```Venture into the wilderness to hunt dangerous creatures and earn XP and coins.\n🕵️‍♂️ *${commandChar}hunt find*\n⚔️ *${commandChar}hunt attack*```',
          'heal':
              '🩹 *HEAL*   -> ```Consume a life potion to restore your health points (HP)❤️ when it\'s low.\n🍷 *${commandChar}heal <amount | 1>*```',
          'shop':
              '🛍️ *SHOP*   -> ```Visit the marketplace to spend your hard-earned coins on various items, gear, and enhancements.\n🛒 *${commandChar}shop info*\n💰 *${commandChar}shop buy <item name> <amount>*```',
          'profile':
              '🧍 *PROFILE*   -> ```Check your player profile and stats.\n📊 *${commandChar}profile*```',
          'equip':
              '🧍 *EQUIP*   -> ```Equip items to become stronger.\n📊 *${commandChar}equip <item name>*```',
          'ranking':
              '🏆 *RANKING*   -> ```Check the leaderboard to see the top players by level.\n👑 *${commandChar}ranking*```',
          'language':
              '🌐 To change the language of the bot, use the *language* command with the desired language code.\n\nExample: `${commandChar}language pt_BR` or `${commandChar}language en`.',
        },
        'start': {
          'welcome': (String name) =>
              '🌍 Welcome to the world of RPG Land, *$name*! 🌍\nEmbark on an epic journey, conquer challenging areas, and become a legendary adventurer. ⚔️🛡️\n\n🕵️‍♂️ To find mobs, use the command: *${commandChar}hunt find*\n⚔️ To attack a mob, use the command: *${commandChar}hunt attack*',
          'error': '❌ Failed start your journey ',
          'playerAlreadyStarted':
              "❌ Oops! Looks like you're already in the game.",
        },
        'commons': {
          'needToStart':
              '⚠️ You need to start your journey first\nType: *${commandChar}start*',
          'somethingWrong': '❌❌❌ Something is off, please call Katekko ❌❌❌',
          'waitMessage':
              '⏳ Please wait a moment before sending another message.',
          'notAuthorized':
              '❌ You are not authorized to use this bot. ❌\nPlease contact the administrator for access.\n*Katekko#1429* ',
          'botMaintenance':
              '*🛠️ The bot is currently undergoing maintenance. 🛠️\nPlease try again later.*',
          'commandOnlyForPrivate':
              '❌ This command can only be used in private chats. ❌',
          'youAreNotKatekko': '❌ You are not Katekko, you little bastard. ❌',
          'commandNotFound': '❌ Command not found',
        },
        'hunt': {
          'find': {
            'found': (MobModel mob) =>
                '🏹 Get ready to battle! 🏹\nYou found a *${mob.name}* with *${mob.health}*❤️ health!',
            'failedToSearch':
                '⚠️ You are already in hunting mode. Finish your current hunt before starting a new one.',
          },
          'attack': {
            'attacking': (String mob, int damage, int remainingHealth) =>
                '⚔️ You attacked the *$mob* and dealt *$damage* damage! ⚔️\nThe *$mob* has *$remainingHealth* ❤️ remaining.',
            'attacked': (String mob, int damage, int remainingHealth) =>
                '🔥 The *$mob* attacked you and dealt *$damage* damage! 🔥\nYou have *$remainingHealth* ❤️ remaining.',
            'defeated': (String mob) =>
                '☠️ You were defeated by the *$mob*! ☠️\nYou have lost one level.',
            'mobDefeated': (String mob, int exp) =>
                '💥 You have defeated the *$mob* and earned *$exp* experience points!',
            'failedToAttack':
                '⚠️ You are not currently hunting any mob. Use the command *${commandChar}hunt find* to start hunting.',
            'levelUp': (int level) =>
                '🎉 Congratulations! 🎉\nYou have reached level *$level*!',
            'itemFound': (ItemModel item) =>
                '🎉 You found ${item.amount} ${item.name}! 🎉',
          },
        },
        'profile': (PlayerModel player) {
          final progressBarLength = 10;
          final filledBarCount = (player.exp /
                  player.getExpNeededForNextLevel() *
                  progressBarLength)
              .floor();
          final emptyBarCount = progressBarLength - filledBarCount;

          final filledBar = '▓' * filledBarCount;
          final emptyBar = '░' * emptyBarCount;

          final coinItem = player.inventory.firstWhereOrNull(
            (item) => item.type == ItemType.currency,
          );

          final potionCount = player.inventory
              .where((item) => item.type == ItemType.healthPotion)
              .fold(0, (total, item) => total + item.amount);
          return _createProfileBox(
            '```${player.state.toString()}```\n\t🧍 *${player.name}* > *Lv. ${player.level}*\n\t[$filledBar$emptyBar] (${player.exp}/${player.getExpNeededForNextLevel()})\n\n\t❤️ ${player.health}/${player.getMaxHealth()}   ⚔️ *${player.getMaxAttack()}   💰 ${coinItem?.amount ?? 0}   🍷 $potionCount*',
          );
        },
        'shop': {
          'info': (List<ItemModel> items) {
            final itemLines = items
                .map((item) =>
                    '🛒 *${item.name}* - Price: *${item.price}* coins')
                .toList();
            final itemsInfo = itemLines.join('\n');
            String drawContinuousLine(int length) {
              return '\u2500' * length;
            }

            final continuousLine = drawContinuousLine(20);
            return '🏪 Welcome to the Shop! 🛍️\n$continuousLine\n$itemsInfo\n$continuousLine\nTo buy an item, use the command: *${commandChar}shop buy <item name> <amount>*';
          },
          'itemNotFound': (String itemName) {
            return '⚠️ The item *\'$itemName\'* is not available in the shop.\nPlease check the item name and try again.';
          },
          'missingArguments':
              '⚠️ You need to provide the item name and the amount you want to buy.\nUsage: *--shop buy <item name> <amount>*',
          'insufficientCoins': (String itemName) =>
              '⚠️ You don\'t have enough coins to purchase *$itemName*.',
          'buy': (ItemModel item, int amount, int totalPrice) =>
              '✅ You have successfully purchased 🛒*$amount ${item.name}* for 💰*$totalPrice* coins!\nEnjoy your new item! 🎉',
          'notIdle':
              '⚠️ You cannot access the shop while you are engaged in another activity.\nPlease finish your current task before visiting the shop.',
        },
        'ranking': {
          'leaderboard': (List<PlayerModel> players) {
            const emojiPositions = ['🥇', '🥈', '🥉'];
            var leaderboardMessage =
                '🏆 Leaderboard - Top Players by Level 🏆\n\n';
            for (var i = 0; i < players.length.clamp(0, 10); i++) {
              final player = players[i];
              final positionEmoji = i < 3 ? emojiPositions[i] : '#${i + 1}';
              leaderboardMessage +=
                  '$positionEmoji ${player.name} - Level ${player.level}\n';
            }
            return leaderboardMessage;
          },
        },
        'heal': {
          'healedWithItem': (
            int healedAmount,
            int currentHealth,
            String itemName,
          ) =>
              '🩹 You have been healed by *$healedAmount HP* using a $itemName! 🎉\nYour current health is ❤️*$currentHealth HP*.',
          'noPotion':
              "😰 You don't have any *health potions left*. Visit the shop or continue hunting to obtain more.",
          'failedToHeal':
              '⚠️ You are currently busy and cannot heal at the moment. Finish your current activity and try again.',
        },
        'inventory': {
          'emptyInventory': '🎒 Inventory 🎒\n\n📦 Your inventory is empty.',
          'open': (PlayerModel player) {
            var inventoryMessage = '🎒 Inventory 🎒\n';
            String drawContinuousLine(int length) {
              return '\u2500' * length;
            }

            final continuousLine = drawContinuousLine(20);

            inventoryMessage += '$continuousLine\n';

            for (var i = 0; i < player.inventory.length; i++) {
              final item = player.inventory[i];
              inventoryMessage +=
                  '${i + 1}. ${item.name} - Amount: ${item.amount}\n';
            }

            inventoryMessage += continuousLine;

            return inventoryMessage;
          },
        },
        'language': {
          'changed': (String lang) =>
              '✅ Language changed successfully to *$lang*',
          'error':
              '❌ Error occurred while changing the language. ❌\nChoose between these two options: 🇧🇷 *pt_BR* or 🇺🇸 *en*.',
        },
        'migrate': {
          'all': '✅ Migration completed for *all data*.',
          'mobs': '✅ Mob migration completed.',
          'players': '✅ Player migration completed.',
          'items': '✅ Item migration completed.',
          'error': '❌ An *error* occurred during migration.',
        },
        'equip': {
          'success': (String itemName) =>
              '✅ You have successfully equipped the item *$itemName*!',
          'notWeapon': (String itemName) =>
              '⚠️ The item *$itemName* is not a weapon and cannot be equipped.',
          'notFoundOrEquipped': (String itemName) =>
              '⚠️ The item *$itemName* was not found in your inventory or is already equipped.',
          'noItemProvided':
              '⚠️ You did not provide the name of the item to equip.',
        },
      };
}
