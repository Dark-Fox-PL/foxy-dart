import 'package:nyxx/nyxx.dart';

import '../config/bot_config.dart';
import 'commands_handler.dart';

class MessagesHandler {
  late IMessageReceivedEvent _receivedEvent;
  late INyxxWebsocket _bot;

  void handle({required IMessageReceivedEvent event, required INyxxWebsocket bot}) {
    _receivedEvent = event;
    _bot = bot;

    if (_startsWithPrefix()) {
      CommandsHandler(receivedEvent: _receivedEvent, bot: _bot).handle();
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
