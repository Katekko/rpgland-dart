import 'package:collection/collection.dart';

import './translation.dart';
import '../domain/enums/item_type.enum.dart';
import '../domain/models/item.model.dart';
import '../domain/models/mob.model.dart';
import '../domain/models/player.model.dart';

class TranslationPtBr extends CommandTranslations {
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

  TranslationPtBr(this.commandChar) {
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
          '🌍 *Bem-vindo ao mundo de RPG Land!* 🌍\n```Embarque em uma jornada épica, conquiste áreas desafiadoras e torne-se um aventureiro lendário.\nVeja como jogar:```',
      start:
          '🎮 *START*   -> ```Comece sua aventura em RPG Land! Use este comando para iniciar sua jornada e explorar o vasto mundo repleto de desafios, tesouros e missões épicas.\n🌟 *$commandChar}start*```',
      hunt:
          '🏹 *HUNT*   -> ```Aventure-se na natureza selvagem para caçar criaturas perigosas e ganhar EXP e moedas.\n🕵️‍♂️ *$commandChar}hunt find*\n⚔️ *$commandChar}hunt attack*```',
      heal:
          '🩹 *HEAL*   -> ```Consuma uma poção de vida para restaurar seus pontos de vida (HP) ❤️ quando estiverem baixos.\n🍷 *$commandChar}heal <amount | 1>*```',
      shop:
          '🛍️ *SHOP*   -> ```Visite o mercado para gastar suas moedas suadas em vários itens, equipamentos e aprimoramentos.\n🛒 *$commandChar}shop info*\n💰 *$commandChar}shop buy <item name> <amount>*```',
      profile:
          '🧍 *PROFILE*   -> ```Verifique o perfil e as estatísticas de seu jogador.\n📊 *$commandChar}profile*```',
      equip:
          '⚔️ *EQUIP*   -> ```Equipe itens para se tornar mais forte.\n📊 *$commandChar}equip <nome do item>*```',
      ranking:
          '🏆 *RANKING*   -> ```Verifique a Ranking para ver os melhores jogadores por nível.\n👑 *$commandChar}ranking*```',
      language:
          '🌐 Para alterar o idioma do bot, use o comando *language* seguido do código do idioma desejado.\n\nExemplo: `--language pt_BR` ou `--language en`.',
    );

    startCommands = StartCommands(
      welcome: (String name) =>
          '🌍 Bem-vindo ao mundo de RPG Land, *$name*! 🌍\nEmbarque em uma jornada épica, conquiste áreas desafiadoras e torne-se um aventureiro lendário. ⚔️🛡️\n\n🕵️‍♂️ Para encontrar mobs, use o comando: *$commandChar}hunt find*\n⚔️ Para atacar um mob, use o comando: *$commandChar}hunt attack*',
      error: '❌ Falha no início de sua jornada ',
      playerAlreadyStarted: '❌ Ops! Parece que você já está no jogo.',
      initiateOnTelegran:
          '🌍 Para iniciar sua aventura, por favor, compartilhe suas informações de contato. 🌍',
    );

    commonsCommands = CommonsCommands(
      needToStart:
          '⚠️ Você precisa começar sua jornada primeiro\nEnvie: *$commandChar}start*',
      somethingWrong:
          '❌❌❌ Algo está errado, entre em contato com a Katekko ❌❌❌',
      waitMessage: '⏳ Aguarde um momento antes de enviar outra mensagem.',
      notAuthorized:
          '❌ Você não está autorizado a usar este bot. ❌\nEntre em contato com o administrador para obter acesso.\n*Katekko#1429* ',
      botMaintenance:
          '🛠️ O bot está passando por manutenção no momento. 🛠️\nTente novamente mais tarde.',
      commandOnlyForPrivate:
          '❌ Esse comando só pode ser usado em bate-papos privados. ❌',
      youAreNotKatekko: '❌ Você não é o katekko seu corno ❌',
      commandNotFound: '❌ Comando inexistente',
    );

    huntCommands = HuntCommands(
      find: HuntFindCommands(
        found: (MobModel mob) =>
            '🏹 Prepare-se para a batalha! 🏹\nVocê encontrou um *${mob.name}* com *${mob.health}*❤️ de vida!',
        failedToSearch:
            '⚠️ Você já está no modo de caça. Termine sua caçada atual antes de iniciar uma nova.',
      ),
      attack: HuntAttackCommands(
        attacking: (String mob, int damage, int remainingHealth) =>
            '⚔️ Você atacou o *$mob* e causou *$damage* de dano! ⚔️\nO *$mob* tem *$remainingHealth* ❤️ restantes.',
        attacked: (String mob, int damage, int remainingHealth) =>
            '🔥 O *$mob* atacou você e causou *$damage*!\nVocê tem *$remainingHealth* ❤️ restantes.',
        defeated: (String mob) =>
            '☠️ Você foi derrotado pelo *$mob*! ☠️\nVocê perdeu um nível.',
        mobDefeated: (String mob, int exp) =>
            '💥 Você derrotou o *$mob* e ganhou *$exp* pontos de experiência!',
        failedToAttack:
            '⚠️ No momento, você não está caçando nenhum mob. Use o comando *$commandChar}hunt find* para começar a caçar.',
        levelUp: (int level) =>
            '🎉 Parabéns! 🎉\nVocê atingiu o nível *$level*!',
        itemFound: (ItemModel item) =>
            '🎉 Você encontrou 💰${item.amount} ${item.name}! 🎉',
      ),
    );

    shopCommands = ShopCommands(
      info: (List<ItemModel> items) {
        final itemLines = items
            .map((item) => '🛒 *${item.name}* - Preço: *${item.price}* moedas')
            .toList();
        final itemsInfo = itemLines.join('\n');
        drawContinuousLine(int length) => '─' * length;
        final continuousLine = drawContinuousLine(20);
        return '🏪 Bem-vindo à loja! 🛍️\n$continuousLine\n$itemsInfo\n$continuousLine\nPara comprar um item, use o comando: *--shop buy <item name> <amount>*';
      },
      itemNotFound: (String itemName) =>
          '⚠️ O item *\'$itemName\'* não está disponível na loja.\nVerifique o nome do item e tente novamente.',
      missingArguments:
          '⚠️ Você precisa fornecer o nome do item e o valor que deseja comprar.\nUso: *--shop buy <item name> <amount>*',
      insufficientCoins: (String itemName) =>
          '⚠️ Você não tem moedas suficientes para comprar *$itemName*.',
      buy: (ItemModel item, int amount, int totalPrice) =>
          '✅ Você adquiriu com sucesso 🛒*$amount ${item.name}* por 💰*$totalPrice* moedas!\nAproveite sua nova compra! 🎉',
      notIdle:
          '⚠️ Não é possível acessar a loja enquanto estiver em outra atividade.\nTermine sua tarefa atual antes de visitar a loja.',
    );

    rankingCommands = RankingCommands(
      leaderboard: (List<PlayerModel> players) {
        final emojiPositions = ['🥇', '🥈', '🥉'];
        var leaderboardMessage =
            '🏆 Ranking - Melhores jogadores por nível 🏆\n\n';
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
          '🩹 Você regenerou *$healedAmount HP* usando uma $itemName! 🎉\nAtualmente você possui ❤️*$currentHealth HP*.',
      noPotion:
          '😰 Você não tem nenhuma *Poção de Cura restante*. Visite a loja ou continue caçando para obter mais.',
      failedToHeal:
          '⚠️ Você está ocupado e não pode se curar no momento. Termine sua atividade atual e tente novamente.',
    );

    inventoryCommands = InventoryCommands(
      emptyInventory: '🎒 Inventário 🎒\n\n📦 Seu inventário está vazio.',
      open: (PlayerModel player) {
        var inventoryMessage = '🎒 Inventário 🎒\n';
        drawContinuousLine(int length) => '─' * length;
        final continuousLine = drawContinuousLine(20);

        inventoryMessage += '$continuousLine\n';

        for (var i = 0; i < player.inventory.length; i++) {
          final item = player.inventory[i];
          inventoryMessage +=
              '${i + 1}. ${item.name} - Quantidade: ${item.amount}\n';
        }

        inventoryMessage += continuousLine;

        return inventoryMessage;
      },
    );

    languageCommands = LanguageCommands(
      changed: (String lang) => '✅ Idioma alterado com sucesso para *$lang*',
      error:
          '❌ Ocorreu um erro ao alterar o idioma. ❌\nEscolha entre estas duas opções: 🇧🇷 *pt_BR* ou 🇺🇸 *en*.',
    );

    migrateCommands = MigrateCommands(
      all: '✅ Migração completa de *todos os dados*.',
      mobs: '✅ Migração de *mobs* concluída.',
      players: '✅ Migração de *jogadores* concluída.',
      items: '✅ Migração de *itens* concluída.',
      error: '❌ Ocorreu um *erro* durante a migração.',
    );

    profileCommands = ProfileCommands(
      info: (PlayerModel player) {
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
