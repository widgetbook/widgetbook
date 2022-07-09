import 'flavor/flavor.dart';
import 'main.dart' as cli;

void main(List<String> args) {
  Flavor().strategy = DeploymentStrategy.staging;
  cli.main(args);
}
