import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:nyxx/nyxx.dart';

import '../config/commands_config.dart';
import '../core/message.dart';
import '../helpers/colors.dart';
import 'foxy_commands.dart';

class Graphic extends FoxyCommands {
  Graphic({required Message message, required INyxxWebsocket bot}) : super(message: message, bot: bot);

  @override
  Future<FoxyCommands> handle() async {
    switch (message.command) {
      case 'fox': return _processFoxCommand();
      default: return unrecognizableCommand();
    }
  }

  Future<FoxyCommands> _processFoxCommand() async {
    String apiUrl = CommandsConfig.commands['fox']?['options']['url'] ?? 'https://randomfox.ca/floof/';
    http.Response response = await http.get(Uri.parse(apiUrl));

    if ('' == response.body) {
      return this;
    }

    final responseJson = jsonDecode(response.body);

    if (responseJson is! Map<String, dynamic>) {
      printError();
      return this;
    }

    try {
      embedReply(
        color: Colors.foxy,
        title: 'What a Fox!',
        image: responseJson['image'] ?? '',
        description: 'What a cute Fox, just for you!',
      );
    } catch (e) {
      printError();
      print(e);
    }

    return this;
  }

}