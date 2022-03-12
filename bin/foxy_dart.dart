import 'core/foxy.dart';
import 'handlers/config_creator.dart';

void main(List<String> arguments) async {
  await ConfigCreator().run();

  final Foxy foxy = Foxy();
  foxy.initializeBot();
}
