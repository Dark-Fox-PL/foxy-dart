import '../core/message.dart';
import 'foxy_commands.dart';

class Empty extends FoxyCommands {
  Empty({required Message message}) : super(message: message);

  @override
  FoxyCommands handle() {
    reply(content: 'Unrecognizable command `${message.command}`.');
    return this;
  }

}