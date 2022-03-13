import 'package:nyxx/src/nyxx.dart';

import '../core/message.dart';
import 'foxy_commands.dart';

class Empty extends FoxyCommands {
  Empty({required Message message, required INyxxWebsocket bot}) : super(message: message, bot: bot);

  @override
  Future<FoxyCommands> handle() async => unrecognizableCommand();

}