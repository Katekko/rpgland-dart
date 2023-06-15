import '../../../core/domain/abstractions/commands/command.dart';
import '../../../core/domain/models/custom_message.model.dart';
import '../../../core/domain/models/player.model.dart';
import '../../../core/i18n/translation.dart';

class ProfileCommand extends Command {
  PlayerModel? player;

  @override
  void injectDependencies(
    CommandTranslations i18n,
    PlayerModel? player,
    Map<String, dynamic> services,
  ) {
    this.i18n = i18n;
    this.player = player;
  }

  @override
  Future<void> execute(CustomMessage message, dynamic args) async {
    try {
      message.reply(i18n.commands.profile.info(player!));
    } catch (err) {
      rethrow;
    }
  }
}
