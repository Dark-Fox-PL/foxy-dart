import 'package:nyxx/nyxx.dart';

import '../config/bot_config.dart';
import 'commands_handler.dart';

class MessagesHandler {
  late IMessageReceivedEvent _receivedEvent;

  void handle({required IMessageReceivedEvent event}) {
    _receivedEvent = event;

    if (_startsWithPrefix()) {
      CommandsHandler(receivedEvent: _receivedEvent).handle();
    }
  }

  bool _startsWithPrefix() {
    return _receivedEvent.message.content.startsWith(BotConfig.prefix)
        ? true
        : _receivedEvent.message.content.startsWith(BotConfig.prefix.toUpperCase())
            ? true
            : false;
  }
}
