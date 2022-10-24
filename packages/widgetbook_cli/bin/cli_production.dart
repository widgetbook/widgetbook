import 'app/main.dart' as cli;
import 'flavor/flavor.dart';

void main(List<String> args) {
  Flavor().strategy = DeploymentStrategy.production;
  cli.main(args);
}
