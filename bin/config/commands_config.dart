class CommandsConfig {
  static Map<String, dynamic> config = {};
  static final Map<String, CommandsConfig> _cache = {};

  CommandsConfig._internal(Map<String, dynamic> _cfg) {
    config = _cfg;
  }

  factory CommandsConfig(Map<String, dynamic> config) {
    late dynamic instance;

    if (_cache.containsKey('instance') && _cache['instance'] is CommandsConfig) {
      instance = _cache['instance'];
    } else {
      instance = CommandsConfig.set(config: config);
    }

    return instance is CommandsConfig ? instance : CommandsConfig.set(config: config);
  }

  factory CommandsConfig.set({required Map<String, dynamic> config}) {
    return _cache.putIfAbsent('instance', () => CommandsConfig._internal(config));
  }

  static Map<String, dynamic> get commands => config['commands'];
  static List<Map<String, dynamic>> get types => config['types'];

}