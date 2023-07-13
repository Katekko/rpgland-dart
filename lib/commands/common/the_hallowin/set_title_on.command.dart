import 'package:rpgland/core/domain/models/player.model.dart';

import '../../../core/domain/abstractions/commands/command.dart';
import '../../../core/domain/abstractions/service/service.dart';
import '../../../core/domain/models/custom_message.model.dart';
import '../../../core/i18n/translation.dart';

class SetTitleOnCommand extends Command {
  @override
  void injectDependencies(
    CommandTranslations i18n,
    PlayerModel? player,
    Map<String, Service> services,
  ) {
    this.i18n = i18n;
  }

  @override
  Future<void> execute(CustomMessage message, dynamic args) async {
    message.callbacks['setTitle']?.call('ON 🟢 | The HalloweeN');
  }
}
