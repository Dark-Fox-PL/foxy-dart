import 'dart:math';

import 'package:nyxx/nyxx.dart';

import '../core/message.dart';
import 'foxy_commands.dart';

class Fun extends FoxyCommands {
  Fun({required Message message, required INyxxWebsocket bot}) : super(message: message, bot: bot);

  @override
  Future<FoxyCommands> handle() async {
    switch (message.command) {
      case '8ball': return _process8BallCommand();
      case 'choice':
      case 'choose':
      case 'select': return _processChoiceCommand();
      default: return unrecognizableCommand();
    }
  }

  Future<FoxyCommands> _process8BallCommand() async {
    final Random r = Random();
    List<Map<String, dynamic>> choices = [
      { 'color': DiscordColor.springGreen, 'message': 'Yes... yes... I can see it.' },
      { 'color': DiscordColor.springGreen, 'message': 'Yes, it might be.' },
      { 'color': DiscordColor.springGreen, 'message': 'Ah... yes.' },
      { 'color': DiscordColor.springGreen, 'message': 'Yes, definitely.' },
      { 'color': DiscordColor.springGreen, 'message': 'The answer is: yes.' },

      { 'color': DiscordColor.yellow, 'message': 'Maybe yes or maybe no.' },
      { 'color': DiscordColor.yellow, 'message': 'Sorry, but your answer is in another castle.' },
      { 'color': DiscordColor.yellow, 'message': 'Try again later.' },
      { 'color': DiscordColor.yellow, 'message': 'I don\'t know.' },

      { 'color': DiscordColor.indianRed, 'message': 'I don\'t think so.' },
      { 'color': DiscordColor.indianRed, 'message': 'There\'s no chance.' },
      { 'color': DiscordColor.indianRed, 'message': 'I said: no.' },
      { 'color': DiscordColor.indianRed, 'message': 'Nope.' },
      { 'color': DiscordColor.indianRed, 'message': 'No.' },
    ];
    Map<String, dynamic> choice = choices[r.nextInt(choices.length)];

    try {
      embedReply(color: choice['color'], title: 'The 🎱 has spoken:', description: choice['message']);
    } catch (e) {
      print(e);
      printError();
    }

    return this;
  }

  Future<FoxyCommands> _processChoiceCommand() async {
    final Random r = Random();
    String pattern = message.content.contains('|') ? '|' : ' ';
    List<String> choices = message.content.split(pattern);
    String choice = choices[r.nextInt(choices.length)];

    try {
      embedReply(color: DiscordColor.indianRed, title: 'I choose...', description: choice);
    } catch (e) {
      print(e);
      printError();
    }

    return this;
  }

}