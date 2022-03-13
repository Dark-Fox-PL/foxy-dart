import 'package:nyxx/nyxx.dart';

import '../core/message.dart';
import '../helpers/colors.dart';

abstract class FoxyCommands {
  Message message;
  INyxxWebsocket bot;

  FoxyCommands({required this.message, required this.bot});
  Future<FoxyCommands> handle();

  Future<IMessage> printError() async => await embedReply(color: Colors.error, title: 'Something goes wrong...', fields: [{ 'content': 'Please try again later.' }]);

  Future<IMessage> reply({required String content}) async => await message.event.message.channel.sendMessage(MessageBuilder.content(content));

  Future<IMessage> embedReply({
    DiscordColor? color,
    String? title,
    String? description,
    String? image,
    String? authorName,
    String? authorUrl,
    String? authorIcon,
    String? footerContent,
    String? footerIcon,
    bool? withAuthor = false,
    List<Map<String, dynamic>>? fields
  }) async {
    EmbedBuilder embed = EmbedBuilder();

    if (color is DiscordColor) embed.color = color;
    if (title is String)       embed.title = title;
    if (image is String)       embed.imageUrl = image;
    if (description is String) embed.description = description;

    if (null != fields && fields.isNotEmpty) {
      for (var field in fields) {
        embed.addField(
          name: field['name'],
          content: field['content'],
          inline: field['inline'] ?? true,
        );
      }
    }

    if (true == withAuthor) {
      embed = _createAuthor(e: embed, name: authorName, url: authorUrl, icon: authorIcon);
    }

    embed = _createFooter(e: embed, content: footerContent, icon: footerIcon);

    return message.event.message.channel.sendMessage(MessageBuilder.embed(embed));
  }

  Future<FoxyCommands> unrecognizableCommand() async {
    reply(content: 'Unrecognizable command `${message.command}`.');
    return this;
  }

  EmbedBuilder _createAuthor({required EmbedBuilder e, String? name, String? url, String? icon}) {
    name = name ?? bot.self.username;
    url = url;
    icon = icon ?? bot.self.avatarURL();

    e.addAuthor((author) {
      author.name = name;
      author.iconUrl = icon;
      author.url = url;
    });

    return e;
  }

  EmbedBuilder _createFooter({required EmbedBuilder e, String? content, String? icon}) {
    e.addFooter((footer) {
      footer.text = content;
      footer.iconUrl = icon;
    });

    return e;
  }

}