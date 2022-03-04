import 'package:nyxx/nyxx.dart';

class CommandsHandler {
  late final IMessageReceivedEvent _receivedEvent;

  CommandsHandler({required IMessageReceivedEvent receivedEvent}) {
    _receivedEvent = receivedEvent;
  }
}
