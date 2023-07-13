import 'package:rpgland/platforms/wpp.platform.dart';
import 'package:rpgland/rpgland.dart';

void main(List<String> arguments) async {
  try {
    // TODO: Get the platform from the starting arguments
    final program = RpgLand();
    // final platform = TelegramPlatform();
    final platform = WppPlatform();
    await program.initiate(platform);
  } catch (err) {
    print(err);
  }
}
