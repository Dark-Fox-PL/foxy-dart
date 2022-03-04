import 'package:nyxx/nyxx.dart';

class MessagesHandler {
  Map config;
  IMessageReceivedEvent? _receivedEvent;

  MessagesHandler( { required Map<String, String> this.config } );

  void handle( { required IMessageReceivedEvent event } ) {
    _receivedEvent = event;
    
    event.message.channel.sendMessage(MessageBuilder.content(event.message.content));
  }

}