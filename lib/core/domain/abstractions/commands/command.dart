import '../../../i18n/translation.dart';
import '../../models/custom_message.model.dart';
import '../../models/player.model.dart';
import '../service/service.dart';

abstract class Command {
  late final CommandTranslations i18n;

  void injectDependencies(
    CommandTranslations i18n,
    PlayerModel? player,
    Map<String, Service> services,
  );

  Future<void> execute(CustomMessage message, dynamic args);
}
