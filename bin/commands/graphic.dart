import '../core/message.dart';
import 'foxy_commands.dart';

class Graphic extends FoxyCommands {
  Graphic({required Message message}) : super(message: message);

  @override
  FoxyCommands handle() {
    switch (message.command) {
      case 'fox': return _processFoxCommand();
      default: return unrecognizableCommand();
    }
  }

  FoxyCommands _processFoxCommand() {
    return this;
  }

}