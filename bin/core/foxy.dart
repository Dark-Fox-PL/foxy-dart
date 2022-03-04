import 'package:nyxx/nyxx.dart';

import '../handlers/messages_handler.dart';

class Foxy {
  final Map<String, String> _config = {};
  late final MessagesHandler _messagesHandler;

  Map<String, String> get config => _config;

  Foxy( { required String token, required String prefix } ) {
    _config['token'] = token;
    _config['prefix'] = prefix;

    _messagesHandler = MessagesHandler(config: _config);
  }

  Foxy setSettings( { required String token, required String prefix } ) {
    _config['token'] = token;
    _config['prefix'] = prefix;

    return this;
  }

  Foxy initializeBot() {
    final INyxxWebsocket bot = NyxxFactory.createNyxxWebsocket( _config['token'] ?? '', GatewayIntents.allUnprivileged )
      ..registerPlugin( Logging() )
      ..registerPlugin( CliIntegration() )
      ..connect();

    _runEventListeners( bot: bot );

    return this;
  }

  void _runEventListeners( { required INyxxWebsocket bot } ) {
    bot.eventsWs.onReady.listen( (e) => print( '> Bot Ready' ) );
    bot.eventsWs.onMessageReceived.listen( ( IMessageReceivedEvent event ) {
      if ( event.message.author.id == bot.self.id ) {
        return;
      }

      _messagesHandler.handle( event: event );
    } );
  }

}