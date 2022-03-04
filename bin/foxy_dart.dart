import 'dart:convert';
import 'dart:io';

import 'core/foxy.dart';

void main(List<String> arguments) async {
  final String configFile = await File('./config/config.json').readAsString();
  assert( '' == configFile, 'Config file is empty.' );

  final botConfig = jsonDecode( configFile );
  assert( botConfig is! Map<String, dynamic>, 'Received file is not a valid JSON.' );

  final Foxy foxy = Foxy( token: botConfig?['token'], prefix: botConfig?['prefix'] );
  foxy.initializeBot();
}
