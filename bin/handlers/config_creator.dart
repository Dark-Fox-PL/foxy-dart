import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

import '../config/app_config.dart';
import '../config/bot_config.dart';
import '../config/commands_config.dart';

class ConfigCreator {
  late YamlMap _app;
  Map<String, dynamic> _bot = {};
  Map<String, dynamic> _commands = {};

  Future<void> run() async {
    _app = await _loadAppConfig();
    _bot = await _loadBotConfig();
    _commands = await _loadCommands();

    _initializeConfigs();
  }

  void _initializeConfigs() {
    AppConfig.set(config: _app);
    BotConfig.set(config: _bot);
    CommandsConfig.set(config: _commands);
  }

  Future<YamlMap> _loadAppConfig() async {
    final String pubspecFile = await File('./pubspec.yaml').readAsString();
    assert('' != pubspecFile, 'Pubspec file is empty.');

    final config = loadYaml(pubspecFile);
    assert(config is YamlMap, 'Received config file is not a valid Yaml.');

    return config;
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