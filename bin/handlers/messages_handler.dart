import 'package:nyxx/nyxx.dart';

import 'commands_handler.dart';

class MessagesHandler {
  Map<String, String> _config = {};
  late IMessageReceivedEvent _receivedEvent;

  MessagesHandler({required Map<String, String> config}) {
    _config = config;
  }

  void handle({required IMessageReceivedEvent event}) {
    _receivedEvent = event;

    if (_startsWithPrefix()) {
      CommandsHandler(receivedEvent: _receivedEvent);
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
