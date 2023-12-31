import 'package:rpgland/core/data/dto/player.data.dart';

import '../../domain/abstractions/service/service.dart';
import '../../domain/abstractions/service/store.dart';
import '../../domain/models/custom_message.model.dart';
import '../../domain/models/player.model.dart';

class PlayersService extends Service {
  PlayersService(Store store) : super(store);

  Future<void> savePlayer(PlayerModel player) async {
    try {
      await store.save(player.toData());
    } catch (error) {
      rethrow;
    }
  }

  Future<PlayerModel?> _getPlayerByPhone(String phone) async {
    try {
      final player = await store.getBy<PlayerData>(
        field: 'telephoneNumber',
        value: phone,
        mapper: PlayerData.fromJson,
      );

      if (player != null) {
        final model = PlayerModel.fromData(player);
        return model;
      }

      return null;
    } catch (error) {
      rethrow;
    }
  }

  Future<PlayerModel?> _getPlayerByTelegramId(String id) async {
    try {
      final player = await store.getBy<PlayerData>(
        field: 'telegramId',
        value: id,
        mapper: PlayerData.fromJson,
      );

      if (player != null) {
        final model = PlayerModel.fromData(player);
        return model;
      }

      return null;
    } catch (error) {
      rethrow;
    }
  }

  Future<PlayerModel?> getPlayerByMessage(CustomMessage message) async {
    try {
      final phone = message.phone;
      if (phone != null) {
        return _getPlayerByPhone(phone);
      } else if (message.telegramId != null) {
        return _getPlayerByTelegramId(message.telegramId!);
      }

      return null;
    } catch (err) {
      rethrow;
    }
  }

  Future<List<PlayerModel>> getAllPlayers() async {
    try {
      final response = await store.getAll<PlayerData>(
        mapper: PlayerData.fromJson,
      );
      final models = response.map((e) => PlayerModel.fromData(e)).toList();
      return models;
    } catch (err) {
      rethrow;
    }
  }

  Future<void> migrate() async {
    try {
      final players = await getAllPlayers();
      final items = players.map((e) => e.toData()).toList();
      await store.saveAll(items);
      print('[RPG LAND] PLAYERS - Migration completed successfully.');
    } catch (err) {
      print('[RPG LAND] PLAYERS - Migration failed: $err');
      rethrow;
    }
  }
}
