/// @docImport 'config.dart';
library;

import 'component.dart';
import 'scenario.dart';
import 'scenario_definition.dart';
import 'story.dart';

/// Configuration applied to every [Scenario] discovered from a [Config].
///
/// Currently exposes [definitions] that are expanded into a [Scenario] for
/// every [Story] of every [Component]. Acts as the home for future
/// scenario-level configuration.
class ScenarioConfig {
  const ScenarioConfig({
    this.definitions = const [],
  });

  /// [ScenarioDefinition]s applied to every [Story] of every [Component].
  ///
  /// For each definition, a [Scenario] is created on every [Story].
  final List<ScenarioDefinition> definitions;
}
