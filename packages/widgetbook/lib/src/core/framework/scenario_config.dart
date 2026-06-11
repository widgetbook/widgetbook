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

/// Callback wrapping the entire execution of a [Scenario] during
/// [testWidgetbook].
///
/// Implementations must await `body` exactly once.
typedef ScenarioWrapper =
    Future<void> Function(
      WidgetTester tester,
      Scenario scenario,
      Future<void> Function() body,
    );

/// Configuration applied to every [Scenario] discovered from a [Config].
///
/// Exposes [definitions] that are expanded into a [Scenario] for every
/// [Story] of every [Component], plus optional [setUp] and [tearDown] hooks
/// invoked around each [Scenario] during [testWidgetbook].
class ScenarioConfig {
  const ScenarioConfig({
    this.definitions = const [],
    this.setUp,
    this.tearDown,
    this.wrapper,
  });

  /// [ScenarioDefinition]s applied to every [Story] of every [Component].
  ///
  /// For each definition, a [Scenario] is created on every [Story].
  final List<ScenarioDefinition> definitions;

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

  /// Wraps the entire execution of each [Scenario]. Only applied during
  /// [testWidgetbook].
  ///
  /// Since the wrapper stays on the call stack while the scenario runs,
  /// `Zone`-scoped configuration becomes visible to the widgets, e.g.
  /// faking time with `package:clock`:
  ///
  /// ```dart
  /// ScenarioConfig(
  ///   wrapper: (tester, scenario, body) =>
  ///     withClock(Clock.fixed(DateTime(2024, 6, 15)), body),
  /// )
  /// ```
  final ScenarioWrapper? wrapper;
}
