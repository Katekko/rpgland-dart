import 'package:mongo_dart/mongo_dart.dart';
import 'package:rpgland/core/data/services/players.service.dart';
import 'package:rpgland/core/injector.dart';
import 'package:rpgland/platforms/base_platform.dart';

import 'core/data/mongo_store.dart';
import 'dotenv.dart';

class RpgLand {
  Future<void> initiate(BasePlatform platform) async {
    await injectDependecies();
    await platform.initiate();
  }

  Future<void> injectDependecies() async {
    print('[RPG LAND] Injecting dependencies...');
    dotenv.load();

    final uri = dotenv['MONGO_DB_URI'];
    var db = await Db.create(uri!);
    await db.open();

    final playersStore = MongoStore(collection: 'players', db: db);
    final playersService = PlayersService(playersStore);
    Injector.put<PlayersService>(playersService);

    print('[RPG LAND] Dependencies injected!');
  }
}
