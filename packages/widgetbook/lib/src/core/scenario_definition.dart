import 'mode.dart';

/// Defines a template for generating scenarios.
class ScenarioDefinition {
  ScenarioDefinition({
    required this.name,
    required this.modes,
  });

  final String name;
  // ignore: strict_raw_type
  final List<Mode> modes;
}
