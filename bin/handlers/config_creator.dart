import 'dart:convert';
import 'dart:io';

import '../config/bot_config.dart';
import '../config/commands_config.dart';

class ConfigCreator {
  Map<String, dynamic> _bot = {};
  Map<String, dynamic> _commands = {};

  Future<void> run() async {
    _bot = await _loadBotConfig();
    _commands = await _loadCommands();

    _initializeConfigs();
  }

  void _initializeConfigs() {
    BotConfig.set(config: _bot);
    CommandsConfig.set(config: _commands);
  }

  Future<Map<String, dynamic>> _loadBotConfig() async {
    final String configFile = await File('./config/config.json').readAsString();
    assert('' != configFile, 'Config file is empty.');

    final botConfig = jsonDecode(configFile);
    assert(botConfig is Map<String, dynamic>, 'Received config file is not a valid JSON.');

    return botConfig;
  }

  Future<Map<String, dynamic>> _loadCommands() async {
    final String commandsFile = await File('./commands.json').readAsString();
    assert('' != commandsFile, 'Commands file is empty.');

    final commands = jsonDecode(commandsFile);
    assert(commands is Map<String, dynamic>, 'Received commands file is not a valid JSON.');

    return commands;
  }

}