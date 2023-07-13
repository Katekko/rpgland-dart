import '../../../core/domain/abstractions/commands/command.dart';
import '../../../core/domain/models/custom_message.model.dart';
import '../../../core/domain/models/player.model.dart';
import '../../../core/i18n/translation.dart';

class HelpCommand extends Command {
  @override
  void injectDependencies(
    CommandTranslations i18n,
    PlayerModel? player,
    Map<String, dynamic> services,
  ) {
    this.i18n = i18n;
  }

  @override
  Future<void> execute(CustomMessage message, dynamic args) async {
    try {
      message.callbacks['reply']?.call(
        '${i18n.commands.help.title}\n\n${i18n.commands.help.start}\n\n${i18n.commands.help.hunt}\n\n${i18n.commands.help.heal}\n\n${i18n.commands.help.shop}\n\n${i18n.commands.help.profile}\n\n${i18n.commands.help.equip}\n\n${i18n.commands.help.ranking}\n\n${i18n.commands.help.language}',
      );
    } catch (err) {
      rethrow;
    }
  }
}
