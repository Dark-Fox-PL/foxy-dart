import 'package:nyxx/nyxx.dart';

import '../core/message.dart';

abstract class FoxyCommands {
  Message message;

  FoxyCommands({required this.message});
  FoxyCommands handle();

  void reply({required String content}) => message.event.message.channel.sendMessage(MessageBuilder.content(content));

}