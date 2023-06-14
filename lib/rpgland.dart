import 'package:rpgland/platforms/base_platform.dart';

class RpgLand {
  Future<void> initiate(BasePlatform platform) async {
    await platform.initiate();
  }
}
