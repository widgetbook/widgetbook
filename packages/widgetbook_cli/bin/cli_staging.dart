import 'core/environment.dart';
import 'main.dart' as cli;

void main(List<String> args) {
  cli.main(args, StagingEnv());
}
