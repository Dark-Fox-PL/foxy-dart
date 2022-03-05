import 'package:nyxx/nyxx.dart';

import 'commands_handler.dart';

class MessagesHandler {
  late final Map<String, String> _config;
  late final Map<String, dynamic> _commands;
  late IMessageReceivedEvent _receivedEvent;

  MessagesHandler({required Map<String, String> config, required Map<String, dynamic> commands}) {
    _config = config;
    _commands = commands;
  }

  void handle({required IMessageReceivedEvent event}) {
    _receivedEvent = event;

    if (_startsWithPrefix()) {
      CommandsHandler(receivedEvent: _receivedEvent, prefix: _config['prefix'].toString(), commands: _commands).handle();
    }
  }

  bool _startsWithPrefix() {
    return _receivedEvent.message.content.startsWith(_config['prefix'].toString())
        ? true
        : _receivedEvent.message.content.startsWith(_config['prefix'].toString().toUpperCase())
            ? true
            : false;
  }
}
