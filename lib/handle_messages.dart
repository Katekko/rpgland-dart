import 'package:rpgland/core/data/services/commons.service.dart';
import 'package:rpgland/core/injector.dart';

import 'commands/commands.dart';
import 'core/data/services/players.service.dart';
import 'core/domain/abstractions/commands/command.dart';
import 'core/domain/exceptions/not_allowed.exception.dart';
import 'core/domain/models/custom_message.model.dart';
import 'core/domain/models/player.model.dart';
import 'core/i18n/en.dart';
import 'core/i18n/pt_br.dart';
import 'core/i18n/translation.dart';

class HandleMessages {
  CustomMessage message;
  String commandChar;
  PlayersService playersService;
  // CommonsService commonsService;
  // MobsService mobsService;
  // ItemsService itemsService;

  Map<String, int> cooldowns = {};

  HandleMessages({
    required this.message,
    required this.commandChar,
    required this.playersService,
    // required this.commonsService,
    // required this.mobsService,
    // required this.itemsService,
  });

  bool verifyIfNeedToIgnore() {
    final oneMinute = 60 * 1000;

    final messageTimestamp = message.timestamp;
    final currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    final messageDate = DateTime.fromMillisecondsSinceEpoch(
      messageTimestamp * 1000,
    );

    return currentTimestamp - messageDate.millisecondsSinceEpoch > oneMinute;
  }

  bool verifyIfIsCommand() {
    return message.body.startsWith(commandChar);
  }

  Future<CommandTranslations> defineLanguage(PlayerModel? player) async {
    final ptBR = TranslationPtBr(commandChar);
    final en = TranslationEn(commandChar);
    if (player != null) {
      final lang = player.language;
      return lang == 'pt_BR' ? ptBR : en;
    } else {
      return (message.phone?.startsWith('55') ?? true) ? ptBR : en;
    }
  }

  bool verifyIfIsFlood(int currentTime, int cooldownDuration) {
    final lastMessageTime = cooldowns[message.phone] ?? 0;
    final timeDifference = currentTime - lastMessageTime;
    return timeDifference < cooldownDuration;
  }

  Future<void> validateWhitelist(CommandTranslations i18n) async {
    final commonsService = Injector.find<CommonsService>();
    final phone = message.phone;
    final name = message.name;

    final allowed = await commonsService.checkIfIsAllowed(
      phone,
      message.telegramId,
    );

    try {
      if (!allowed) {
        throw NotAllowedException();
      }
    } catch (err) {
      if (err is NotAllowedException) {
        print('[RPG LAND] Not Authorized: $name | $phone');
        message.reply(i18n.commands.commons.notAuthorized);
      } else {
        print(err);
        message.reply(i18n.commands.commons.somethingWrong);
      }

      rethrow;
    }
  }

  Command? findCommand(String commandLine, CommandTranslations i18n) {
    try {
      final List<String> commandParts = commandLine.split(' ');
      return _traverseCommands(commands, commandParts, i18n);
    } catch (error) {
      message.reply(i18n.commands.commons.commandNotFound);
      return null;
    }
  }

  Command? _traverseCommands(
    dynamic commands,
    List<String> commandParts,
    CommandTranslations i18n,
  ) {
    if (commandParts.isEmpty) {
      if (commands is Command Function()) {
        return commands();
      } else {
        message.reply(i18n.commands.commons.commandNotFound);
        return null;
      }
    }

    final commandPart = commandParts.first;
    final remainingCommandParts = commandParts.sublist(1);

    if (commands is CommandMap && commands.containsKey(commandPart)) {
      final nestedCommand = commands[commandPart];
      return _traverseCommands(nestedCommand, remainingCommandParts, i18n);
    } else {
      message.reply(i18n.commands.commons.commandNotFound);
      return null;
    }
  }

  List<String> findArguments(String commandLine) {
    final List<String> commandParts = commandLine.split(' ');
    commandParts.removeAt(0); // Remove the first part (command)

    final List<String> arguments = [];

    for (final part in commandParts) {
      if (arguments.isEmpty || part.startsWith('-')) {
        arguments.add(part); // Add arguments or subcommands that start with '-'
      } else {
        final lastArgumentIndex = arguments.length - 1;
        arguments[lastArgumentIndex] +=
            ' $part'; // Combine non-dashed parts with the last argument
      }
    }

    return arguments;
  }

  bool commandOnlyForPrivate(CommandTranslations i18n, Command command) {
    if (message.isGroup) {
      final commandType = command.runtimeType;
      if (privateCommands.contains(commandType)) {
        message.reply(i18n.commands.commons.commandOnlyForPrivate);
        return true;
      }
    }

    return false;
  }

  bool commandNeedToStart(
    CommandTranslations i18n,
    Command command,
    PlayerModel? player,
  ) {
    final commandType = command.runtimeType;
    if (needToStartCommands.contains(commandType) && player == null) {
      message.reply(i18n.commands.commons.needToStart);
      return true;
    }

    return false;
  }

  Future<void> handle() async {
    try {
      if (verifyIfNeedToIgnore()) return;
      if (!verifyIfIsCommand()) return;
      final player = await playersService.getPlayerByMessage(message);
      final i18n = await defineLanguage(player);

      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final isFlood = verifyIfIsFlood(currentTime, 1000);
      if (isFlood) {
        message.reply(i18n.commands.commons.waitMessage);
        return;
      }

      // TODO: Make whitelists for groups and single persons
      // await validateWhitelist(i18n);

      final commandLine = message.body.split(commandChar)[1];
      final command = findCommand(commandLine, i18n);
      if (command == null) return;
      if (commandOnlyForPrivate(i18n, command)) return;
      if (commandNeedToStart(i18n, command, player)) return;

      final args = findArguments(commandLine);

      command.injectDependencies(
        i18n,
        player,
        {'playersService': playersService},
      );

      await command.execute(message, args);

      print('[RPG LAND] ${message.name} ${message.body}');

      // TODO: Fix cooldowns
      // cooldowns[message.phone] = currentTime;
    } catch (err) {
      print('[RPG LAND] $err');
    }
  }
}
