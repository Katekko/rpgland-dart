import 'common/both/ping.command.dart';
import 'rpg/both/help.command.dart';
import 'rpg/both/profile.command.dart';
import 'rpg/private/start.command.dart';

typedef CommandMap = Map<String, dynamic>;

/// All existent commands in the bot
final commands = <String, dynamic>{
  'ping': () => PingCommand(),
  'help': () => HelpCommand(),
  'start': () => StartCommand(),
  'profile': () => ProfileCommand(),
  // 'hunt': HuntCommand(),
  // 'hunt attack': HuntAttackCommand(),
  // 'shop info': ShopCommand(),
  // 'shop buy': ShopBuyCommand(),
  // 'ranking': RankingCommand(),
  // 'heal': HealCommand(),
  // 'inventory': InventoryCommand(),
  // 'admin add whitelist': AddWhitelistCommand(),
  // 'admin migrate mobs': MigrateMobsCommand(),
  // 'admin migrate items': MigrateItemsCommand(),
  // 'admin migrate players': MigratePlayersCommand(),
  // 'language': ChangeLanguageCommand(),
  // 'equip': EquipItemCommand(),
};

typedef PrivateCommandTypes = List<Type>;
typedef NeedToStartCommandTypes = List<Type>;

final privateCommands = <Type>[
  // StartCommand,
  // HuntCommand,
  // HuntAttackCommand,
  // ShopBuyCommand,
  // HealCommand,
  // MigrateMobsCommand,
  // MigrateItemsCommand,
  // MigratePlayersCommand,
];

final needToStartCommands = <Type>[
  // HuntCommand,
  // HuntAttackCommand,
  // ShopBuyCommand,
  // HealCommand,
  // InventoryCommand,
  // ProfileCommand,
  // ChangeLanguageCommand,
  // EquipItemCommand,
];
