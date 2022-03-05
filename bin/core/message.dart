import 'package:nyxx/nyxx.dart';

class Message {
  String command;
  String content;
  List<String> input;
  IMessageReceivedEvent event;

  Message({required this.command, required this.content, required this.input, required this.event});
}