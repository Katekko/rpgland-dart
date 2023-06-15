import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import '../core/data/services/players.service.dart';
import '../core/domain/models/player.model.dart';
import '../core/injector.dart';
import '../dotenv.dart';
import 'base_platform.dart';

class TelegramPlatform extends BasePlatform {
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
      var keyboard = ReplyKeyboardMarkup(
        resizeKeyboard: true,
        oneTimeKeyboard: true,
        keyboard: [
          [KeyboardButton(text: 'Share Contact', requestContact: true)]
        ],
      );

      msg.reply(
        'Please share your contact information.',
        replyMarkup: keyboard,
      );
    });

    teledart.onMessage().listen((message) async {
      if (message.contact != null) {
        final playersService = Injector.find<PlayersService>();
        var contact = message.contact!;

        message.reply(
          'Thank you for sharing your contact information.',
          replyMarkup: ReplyKeyboardRemove(removeKeyboard: true),
        );

        final player = PlayerModel.createNew(
          contact.firstName,
          contact.phoneNumber,
        );

        await playersService.savePlayer(player);
        return;
      }
    });

    print('[RPG LAND] Telegram platform initiated!');
  }
}
