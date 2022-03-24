import 'package:nyxx/nyxx.dart';

import '../config/app_config.dart';
import '../core/message.dart';
import 'foxy_commands.dart';

class General extends FoxyCommands {
  General({required Message message, required INyxxWebsocket bot}) : super(message: message, bot: bot);

  @override
  Future<FoxyCommands> handle() async {
    switch (message.command) {
      case 'info': return _processInfoCommand();
      default: return unrecognizableCommand();
    }
  }

  Future<FoxyCommands> _processInfoCommand() async {
    embedReply(
      color: DiscordColor.cornflowerBlue,
      title: bot.self.username,
      fields: [
        { 'name': 'Version', 'content': '${AppConfig.version} alpha 2', 'inline': false },
        { 'name': 'Release note', 'content': 'Please note that the bot is still under development.', 'inline': false },
        { 'name': 'Current commands', 'content': '`fox`, `cat`, `dog`, `8ball`, `choice`', 'inline': false },
      ]
    );

    return this;
  }

}