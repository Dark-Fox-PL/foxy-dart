class BotConfig {
  static Map<String, dynamic> config = {};
  static final Map<String, BotConfig> _cache = {};

  BotConfig._internal(Map<String, dynamic> _cfg) {
    config = _cfg;
  }

  factory BotConfig(Map<String, dynamic> config) {
    late dynamic instance;

    if (_cache.containsKey('instance') && _cache['instance'] is BotConfig) {
      instance = _cache['instance'];
    } else {
      instance = BotConfig.set(config: config);
    }

    return instance is BotConfig ? instance : BotConfig.set(config: config);
  }

  factory BotConfig.set({required Map<String, dynamic> config}) {
    return _cache.putIfAbsent('instance', () => BotConfig._internal(config));
  }

  static String get token => config['token'];
  static String get prefix => config['prefix'];

}