// class CustomMessage {
//   int timestamp;
//   String phone;
//   String name;
//   String body;
//   void Function(String message) reply;
//   bool isGroup;

//   CustomMessage({
//     required this.timestamp,
//     required this.phone,
//     required this.body,
//     required this.reply,
//     required this.name,
//     required this.isGroup,
//   });
// }

// class HandleMessages {
//   CustomMessage message;
//   String commandChar;
//   PlayersService playersService;
//   CommonsService commonsService;
//   MobsService mobsService;
//   ItemsService itemsService;

//   Map<String, int> cooldowns = {};

//   HandleMessages({
//     required this.message,
//     required this.commandChar,
//     required this.playersService,
//     required this.commonsService,
//     required this.mobsService,
//     required this.itemsService,
//   });

//   bool verifyIfNeedToIgnore() {
//     final oneMinute = 60 * 1000;

//     final messageTimestamp = message.timestamp;
//     final currentTimestamp = DateTime.now().millisecondsSinceEpoch;
//     final messageDate = DateTime.fromMillisecondsSinceEpoch(
//       messageTimestamp * 1000,
//     );

//     return currentTimestamp - messageDate.millisecondsSinceEpoch > oneMinute;
//   }

//   bool verifyIfIsCommand() {
//     return message.body.startsWith(commandChar);
//   }

//   Future<CommandTranslations> defineLanguage(PlayerModel? player) async {
//     final ptBR = TranslationPtBr(commandChar);
//     final en = TranslationEn(commandChar);
//     if (player != null) {
//       final lang = player.language;
//       return lang == 'pt_BR' ? ptBR : en;
//     } else {
//       return message.phone.startsWith('55') ? ptBR : en;
//     }
//   }

//   bool verifyIfIsFlood(int currentTime, int cooldownDuration) {
//     final lastMessageTime = cooldowns[message.phone] ?? 0;
//     final timeDifference = currentTime - lastMessageTime;
//     return timeDifference < cooldownDuration;
//   }

//   Future<void> validateWhitelist(CommandTranslations i18n) async {
//     final commonsService = this.commonsService;
//     final whitelist = await commonsService.getWhitelist();
//     final phone = message.phone;
//     final name = message.name;

//     try {
//       final foundNumber = whitelist.firstWhere((item) => item.number == phone,
//           orElse: () => null);
//       if (foundNumber == null) {
//         throw NotAllowedException();
//       } else if (!foundNumber.allow) {
//         throw BotInMaintenanceException();
//       }
//     } catch (err) {
//       if (err is NotAllowedException) {
//         print('[RPG LAND] Not Authorized: $name | $phone');
//         message.reply(i18n.commands.commons.notAuthorized);
//       } else if (err is BotInMaintenanceException) {
//         message.reply(i18n.commands.commons.botMaintenance);
//         print('[RPG LAND] Bot in Maintenance: $name | $phone');
//       } else {
//         print(err);
//         message.reply(i18n.commands.commons.somethingWrong);
//       }

//       throw err;
//     }
//   }

//   Command? findCommand(String commandLine, CommandTranslations i18n,
//       [CommandMap? currentCommands]) {
//     try {
//       final commandParts = commandLine.split(' ');
//       currentCommands ??= commands;

//       for (final command in commandParts) {
//         if (currentCommands is Command) {
//           return currentCommands;
//         }

//         if (!currentCommands.containsKey(command)) {
//           throw Error();
//         }

//         currentCommands = currentCommands[command] as CommandMap?;
//       }

//       if (currentCommands is Command) {
//         return currentCommands;
//       }

//       throw Error();
//     } catch (error) {
//       message.reply(i18n.commands.commons.commandNotFound);
//       return null;
//     }
//   }

//   List<String> findArguments(String commandLine) {
//     final commandParts = commandLine.split(' ');
//     final args = <String>[];

//     CommandMap? currentCommand = commands;

//     for (var i = 0; i < commandParts.length; i++) {
//       final commandPart = commandParts[i];

//       if (currentCommand is Map && currentCommand.containsKey(commandPart)) {
//         currentCommand = currentCommand[commandPart] as CommandMap?;
//       } else {
//         args.add(commandPart);
//       }
//     }

//     return args;
//   }

//   bool commandOnlyForPrivate(CommandTranslations i18n, Command command) {
//     if (message.isGroup) {
//       final commandType = command.runtimeType;
//       if (privateCommands.contains(commandType)) {
//         message.reply(i18n.commands.commons.commandOnlyForPrivate);
//         return true;
//       }
//     }

//     return false;
//   }

//   bool commandNeedToStart(
//       CommandTranslations i18n, Command command, PlayerModel? player) {
//     final commandType = command.runtimeType;
//     if (needToStartCommands.contains(commandType) && player == null) {
//       message.reply(i18n.commands.commons.needToStart);
//       return true;
//     }

//     return false;
//   }

//   Future<void> handle() async {
//     try {
//       if (verifyIfNeedToIgnore()) return;
//       if (!verifyIfIsCommand()) return;
//       final player = await playersService.getPlayerByMessage(message);
//       final i18n = await defineLanguage(player);

//       final currentTime = DateTime.now().millisecondsSinceEpoch;
//       final isFlood = verifyIfIsFlood(currentTime, 1000);
//       if (isFlood) {
//         message.reply(i18n.commands.commons.waitMessage);
//         return;
//       }

//       await validateWhitelist(i18n);

//       final commandLine = message.body.split(commandChar)[1];
//       final command = findCommand(commandLine, i18n);
//       if (command == null) return null;
//       if (commandOnlyForPrivate(i18n, command)) return;
//       if (commandNeedToStart(i18n, command, player)) return;

//       final args = findArguments(commandLine);

//       command.injectDependencies(
//         i18n,
//         player,
//         PlayersService: playersService,
//         CommonsService: commonsService,
//         MobsService: mobsService,
//         ItemsService: itemsService,
//       );
//       command.execute(message, args);

//       print('[RPG LAND] ${message.name} ${message.body}');

//       cooldowns[message.phone] = currentTime;
//     } catch (err) {
//       print('[RPG LAND] $err');
//     }
//   }
// }
