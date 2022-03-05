import '../core/message.dart';
import 'foxy_commands.dart';

class Graphic extends FoxyCommands {
  Graphic({required Message message}) : super(message: message);

  @override
  FoxyCommands handle() {
    return this;
  }

}