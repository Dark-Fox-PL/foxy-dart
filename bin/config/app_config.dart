import 'package:yaml/yaml.dart';

class AppConfig {
  static late YamlMap config;
  static final Map<String, AppConfig> _cache = {};

  AppConfig._internal(YamlMap _cfg) {
    config = _cfg;
  }

  factory AppConfig(YamlMap config) {
    late dynamic instance;

    if (_cache.containsKey('instance') && _cache['instance'] is AppConfig) {
      instance = _cache['instance'];
    } else {
      instance = AppConfig.set(config: config);
    }

    return instance is AppConfig ? instance : AppConfig.set(config: config);
  }

  factory AppConfig.set({required YamlMap config}) {
    return _cache.putIfAbsent('instance', () => AppConfig._internal(config));
  }

  static String get version => config['version'];

}