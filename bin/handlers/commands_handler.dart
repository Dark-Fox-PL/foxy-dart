import 'package:nyxx/nyxx.dart';

import '../commands/empty.dart';
import '../commands/foxy_commands.dart';
import '../commands/fun.dart';
import '../commands/general.dart';
import '../commands/graphic.dart';
import '../config/bot_config.dart';
import '../config/commands_config.dart';
import '../core/message.dart';

class CommandsHandler {
  late final IMessageReceivedEvent _receivedEvent;
  late final INyxxWebsocket _bot;
  late final Message _messageHandler;

  List<String> _input = [];
  String _command = '';
  String _content = '';

  CommandsHandler({required IMessageReceivedEvent receivedEvent, required INyxxWebsocket bot}) {
    _receivedEvent = receivedEvent;
    _bot = bot;
  }

  CommandsHandler handle() {
    _parseInput();
    _prepareMessageHandler();
    _runCommand();

    return this;
  }

  void _parseInput() {
    String message = _receivedEvent.message.content.substring(BotConfig.prefix.length).trim();
    _input = message.split(' ');

    if (_input.isEmpty) {
      return;
    }

    _command = _input[0];
    _input.removeAt(0);
    _content = _input.join(' ');
  }

  void _prepareMessageHandler() => _messageHandler = Message(command: _command, content: _content, input: _input, event: _receivedEvent);

  void _runCommand() {
    Map<String, dynamic> command = CommandsConfig.commands[_command] ?? {};
    String family = command['family'] ?? '';

    late FoxyCommands fC;

    switch (family) {
      case 'fun': fC = Fun(message: _messageHandler, bot: _bot); break;
      case 'general': fC = General(message: _messageHandler, bot: _bot); break;
      case 'graphic': fC = Graphic(message: _messageHandler, bot: _bot); break;
      default: fC = Empty(message: _messageHandler, bot: _bot); break;
    }

    fC.handle();
  }

}
