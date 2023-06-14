import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:dotenv/dotenv.dart';
import 'base_platform.dart';

class TelegramPlatform extends BasePlatform {
  @override
  Future<void> initiate() async {
    final dotenv = DotEnv();
    dotenv.load();
    final botToken = dotenv['TELEGRAM_BOT_KEY'];

    if (botToken == null) {
      throw Exception('TELEGRAM_BOT_KEY is not set in .env file');
    }

    final username = (await Telegram(botToken).getMe()).username;
    var teledart = TeleDart(botToken, Event(username!));

    teledart.start();

    teledart.onCommand('start').listen((message) {
      message.reply('Hello, ${message.from?.firstName}!');
    });
  }
}
