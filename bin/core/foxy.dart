import 'package:nyxx/nyxx.dart';

import '../config/bot_config.dart';
import '../handlers/messages_handler.dart';

class Foxy {
  late final MessagesHandler _messagesHandler;

  Foxy() {
    _messagesHandler = MessagesHandler();
  }

  Foxy initializeBot() {
    final INyxxWebsocket bot = NyxxFactory.createNyxxWebsocket(BotConfig.token, GatewayIntents.allUnprivileged)
      ..registerPlugin(Logging())
      ..registerPlugin(CliIntegration())
      ..connect();

    _runEventListeners(bot: bot);
    _registerSlashCommands(bot: bot);

    return this;
  }

  void _runEventListeners({required INyxxWebsocket bot}) {
    bot.eventsWs.onReady.listen((e) => print('> Bot Ready'));
    bot.eventsWs.onMessageReceived.listen((IMessageReceivedEvent event) {
      if (event.message.author.id == bot.self.id) {
        return;
      }

      _messagesHandler.handle(event: event, bot: bot);
    });
  }

  void _registerSlashCommands({required INyxxWebsocket bot}) {

  }

}
