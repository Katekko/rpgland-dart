import 'package:rpgland/handle_messages.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import '../commands/rpg/private/start.command.dart';
import '../core/data/services/players.service.dart';
import '../core/domain/models/custom_message.model.dart';
import '../core/domain/models/player.model.dart';
import '../core/i18n/en.dart';
import '../core/i18n/pt_br.dart';
import '../core/i18n/translation.dart';
import '../core/injector.dart';
import '../dotenv.dart';
import 'base_platform.dart';

class TelegramPlatform extends BasePlatform {
  static CustomMessage messageToCustom(TeleDartMessage msg) {
    final callbacks = {'reply': (message) => msg.reply(message)};

    final customMessage = CustomMessage(
      body: msg.text ?? '',
      telegramId: msg.from?.id.toString(),
      timestamp: msg.date,
      isGroup: msg.chat.type == Chat.typeGroup,
      name: msg.chat.firstName ?? '',
      phone: msg.contact?.phoneNumber.replaceAll('+', ''),
      callbacks: callbacks,
    );

    return customMessage;
  }

  void handleMessages(TeleDartMessage msg) async {
    final playersService = Injector.find<PlayersService>();
    final customMessage = TelegramPlatform.messageToCustom(msg);

    final handler = HandleMessages(
      message: customMessage,
      commandChar: '/',
      playersService: playersService,
    );

    await handler.handle();
  }

  @override
  Future<void> initiate() async {
    print('[RPG LAND] Initiating Telegram platform...');
    final botToken = dotenv['TELEGRAM_BOT_KEY'];

    if (botToken == null) {
      throw Exception('TELEGRAM_BOT_KEY is not set in .env file');
    }

    final username = (await Telegram(botToken).getMe()).username;
    var teledart = TeleDart(botToken, Event(username!));

    teledart.start();

    teledart.onCommand('start').listen((msg) async {
      final playersService = Injector.find<PlayersService>();
      final customMessage = TelegramPlatform.messageToCustom(msg);
      final player = await playersService.getPlayerByMessage(customMessage);
      final language = await defineLanguage(player, customMessage);

      if (player != null) {
        msg.reply(language.commands.start.playerAlreadyStarted);
        return;
      }

      var keyboard = ReplyKeyboardMarkup(
        resizeKeyboard: true,
        oneTimeKeyboard: true,
        keyboard: [
          [KeyboardButton(text: 'Share Contact', requestContact: true)]
        ],
      );

      msg.reply(
        language.commands.start.initiateOnTelegran,
        replyMarkup: keyboard,
      );
    });

    teledart.onMessage().listen((msg) async {
      final playersService = Injector.find<PlayersService>();
      final customMessage = TelegramPlatform.messageToCustom(msg);
      final player = await playersService.getPlayerByMessage(customMessage);
      final language = await defineLanguage(player, customMessage);

      if (msg.contact != null) {
        final playersService = Injector.find<PlayersService>();

        final command = StartCommand();
        command.injectDependencies(
          language,
          player,
          {'playersService': playersService},
        );

        await command.execute(customMessage, []);
      }
    });

    teledart.onCommand().listen(handleMessages);

    print('[RPG LAND] Telegram platform initiated!');
  }

  Future<CommandTranslations> defineLanguage(
    PlayerModel? player,
    CustomMessage message,
  ) async {
    final ptBR = TranslationPtBr('/');
    final en = TranslationEn('/');
    if (player != null) {
      final lang = player.language;
      return lang == 'pt_BR' ? ptBR : en;
    } else {
      return (message.phone?.startsWith('55') ?? false) ? ptBR : en;
    }
  }
}
