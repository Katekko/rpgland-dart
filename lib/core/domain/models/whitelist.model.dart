import 'package:rpgland/core/data/dto/whitelist.data.dart';

class WhitelistModel {
  String? number;
  bool allow;
  String? telegramId;

  WhitelistModel({
    required this.number,
    required this.allow,
    required this.telegramId,
  });

  WhitelistData toData() {
    final item = WhitelistData(
      allow: allow,
      number: number,
      id: number ?? telegramId!,
      telegramId: telegramId,
    );

    return item;
  }

  static WhitelistModel fromData(WhitelistData data) {
    return WhitelistModel(
      allow: data.allow,
      number: data.number,
      telegramId: data.telegramId,
    );
  }
}
