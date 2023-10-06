import 'flavor/flavor.dart';
import 'main.dart' as cli;

void main(List<String> args) {
  Flavor().strategy = DeploymentStrategy.production;
  cli.main(args);
}
