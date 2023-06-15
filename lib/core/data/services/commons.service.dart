import 'package:rpgland/core/data/dto/whitelist.data.dart';

import '../../domain/abstractions/service/service.dart';
import '../../domain/abstractions/service/store.dart';
import '../../domain/models/whitelist.model.dart';

class CommonsService extends Service {
  CommonsService(Store store) : super(store);

  Future<List<WhitelistModel>> getWhitelist() async {
    try {
      final whitelist = await store.getAll(mapper: WhitelistData.fromJson);
      final models = whitelist.map((e) => WhitelistModel.fromData(e)).toList();
      return models;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> checkIfIsAllowed(String? phoneNumber, String? telegramId) async {
    try {
      final byTelegramId = await store.getBy(
        field: 'telegramId',
        value: telegramId,
        mapper: WhitelistData.fromJson,
      );

      if (byTelegramId == null) {
        final byPhone = await store.getBy(
          field: 'telephoneNumber',
          value: phoneNumber ?? '',
          mapper: WhitelistData.fromJson,
        );

        return byPhone != null;
      } else {
        return true;
      }
    } catch (error) {
      rethrow;
    }
  }
}
