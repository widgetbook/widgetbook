/// @docImport '../../test/test.dart';
/// @docImport 'config.dart';
library;

import 'package:flutter_test/flutter_test.dart';

import 'component.dart';
import 'scenario.dart';
import 'scenario_definition.dart';
import 'story.dart';

/// Callback invoked around each [Scenario] run by [testWidgetbook].
///
/// Receives the active [WidgetTester] and the [Scenario] currently being
/// executed.
typedef ScenarioCallback =
    Future<void> Function(WidgetTester tester, Scenario scenario);

/// Builds the name of a crossed [Scenario] that is generated when a
/// [ScenarioDefinition] with [ScenarioStrategy.perScenario] or
/// [ScenarioStrategy.both] is applied to a [Story].
///
/// [scenario] is the base scenario being crossed — a local scenario of the
/// story, or the implicit `Default` scenario if the story defines none. The
/// modes involved are accessible via [ScenarioDefinition.modes],
/// [Scenario.modes], and [Story.modes].
///
/// The returned name must not contain `/`, which is reserved for
/// [Scenario.path].
typedef ScenarioNameBuilder =
    String Function(
      ScenarioDefinition definition,
      Story story,
      Scenario scenario,
    );

/// Separator used by [defaultScenarioNameBuilder] between the name of the
/// base scenario and the name of the [ScenarioDefinition] it is crossed with.
const scenarioNameSeparator = '•';

/// The default [ScenarioNameBuilder].
///
/// Returns the definition's name when the base [scenario] is the implicit
/// `Default` scenario, which keeps the scenario paths of stories without
/// local scenarios identical to [ScenarioStrategy.perStory]. Otherwise,
/// combines both names using [scenarioNameSeparator], e.g. `Empty • Dark`.
String defaultScenarioNameBuilder(
  ScenarioDefinition definition,
  Story story,
  Scenario scenario,
) {
  return scenario.type == ScenarioType.$default
      ? definition.name
      : '${scenario.name} $scenarioNameSeparator ${definition.name}';
}

/// Configuration applied to every [Scenario] discovered from a [Config].
///
/// Exposes [definitions] that are expanded into [Scenario]s for every
/// [Story] of every [Component], plus optional [setUp] and [tearDown] hooks
/// invoked around each [Scenario] during [testWidgetbook].
class ScenarioConfig {
  const ScenarioConfig({
    this.definitions = const [],
    this.nameBuilder = defaultScenarioNameBuilder,
    this.setUp,
    this.tearDown,
  });

  /// [ScenarioDefinition]s applied to every [Story] of every [Component],
  /// expanded according to each definition's [ScenarioDefinition.strategy].
  final List<ScenarioDefinition> definitions;

  /// Builds the names of crossed [Scenario]s generated from [definitions]
  /// with [ScenarioStrategy.perScenario] or [ScenarioStrategy.both].
  ///
  /// Defaults to [defaultScenarioNameBuilder].
  final ScenarioNameBuilder nameBuilder;

  /// Runs after each [Scenario] has been pumped but before its `run` callback
  /// executes.
  ///
  /// Use it to seed shared state, prime caches, or stub dependencies the
  /// scenario depends on. Only applied during [testWidgetbook].
  final ScenarioCallback? setUp;

  /// Runs after each [Scenario]'s screenshot and semantics data have been
  /// written to disk.
  ///
  /// Use it to reset state mutated by [setUp] or the scenario itself. Only
  /// applied during [testWidgetbook].
  final ScenarioCallback? tearDown;
}
