import 'package:nyxx/nyxx.dart';

import '../commands/empty.dart';
import '../commands/foxy_commands.dart';
import '../commands/graphic.dart';
import '../core/message.dart';

class CommandsHandler {
  late final Map<String, dynamic> _commands;
  late final IMessageReceivedEvent _receivedEvent;
  late final Message _messageHandler;

  String _prefix = '';

  List<String> _input = [];
  String _command = '';
  String _content = '';

  CommandsHandler({required IMessageReceivedEvent receivedEvent, required String prefix, required Map<String, dynamic> commands}) {
    _receivedEvent = receivedEvent;
    _commands = commands;
    _prefix = prefix;
  }

  CommandsHandler handle() {
    _parseInput();
    _prepareMessageHandler();
    _runCommand();

    return this;
  }

  void _parseInput() {
    String message = _receivedEvent.message.content.substring(_prefix.length).trim();
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
    if (!_commands.containsKey('commands')) {
      return;
    }

    Map<String, dynamic> command = _commands['commands']?[_command] ?? {};
    String family = command['family'] ?? '';

    late FoxyCommands implementation;

    switch (family) {
      case 'graphic':
        implementation = Graphic(message: _messageHandler);
        break;
      default:
        implementation = Empty(message: _messageHandler);
        break;
    }

    implementation.handle();
  }

}
