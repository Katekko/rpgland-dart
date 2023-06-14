import 'package:rpgland/platforms/telegram.platform.dart';
import 'package:rpgland/rpgland.dart';

void main(List<String> arguments) async {
  try {
    // TODO: Get the platform from the starting arguments
    final program = RpgLand();
    final platform = TelegramPlatform();
    await program.initiate(platform);
  } catch (err) {
    print(err);
  }
}
