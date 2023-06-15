import '../../../core/data/services/players.service.dart';
import '../../../core/domain/abstractions/commands/command.dart';
import '../../../core/domain/models/custom_message.model.dart';
import '../../../core/domain/models/player.model.dart';
import '../../../core/i18n/translation.dart';

class StartCommand extends Command {
  late final PlayersService playersService;
  late final PlayerModel? player;

  @override
  void injectDependencies(
    CommandTranslations i18n,
    PlayerModel? player,
    Map<String, dynamic> services,
  ) {
    this.i18n = i18n;
    this.player = player;
    playersService = services['playersService'] as PlayersService;
  }

  @override
  Future<void> execute(CustomMessage message, dynamic args) async {
    try {
      try {
        if (message.phone != null && message.phone!.isNotEmpty) {
          if (player == null) {
            final player = PlayerModel.createNew(
              message.name,
              message.phone!,
              message.telegramId,
            );
            await playersService.savePlayer(player);
            message.reply(i18n.commands.start.welcome(player.name));
          } else {
            message.reply(i18n.commands.start.playerAlreadyStarted);
          }
        }
      } catch (err) {
        print('Error adding player: $err');
        message.reply(i18n.commands.start.error);
      }
    } catch (err) {
      rethrow;
    }
  }
}
