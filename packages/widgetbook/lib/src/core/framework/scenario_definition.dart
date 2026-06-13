// ignore_for_file: strict_raw_type

/// @docImport 'scenario.dart';
/// @docImport 'scenario_config.dart';
/// @docImport 'story.dart';
library;

import 'mode.dart';

/// Defines how a [ScenarioDefinition] from [ScenarioConfig.definitions]
/// is expanded into [Scenario]s for each [Story].
enum ScenarioStrategy {
  /// One standalone [Scenario] per [Story], built with the story's
  /// default args and without a `run` callback.
  perStory,

  /// One crossed [Scenario] per local scenario of each [Story], or per the
  /// implicit `Default` scenario if the story defines none. Crossed variants
  /// keep the local scenario's args and `run` callback and merge in the
  /// definition's [ScenarioDefinition.modes] (local modes win). The bare
  /// local scenarios are replaced by their variants.
  perScenario,

  /// The union of [perStory] and [perScenario]. The implicit `Default`
  /// scenario is not crossed, as the standalone scenario already covers
  /// that exact state.
  both,
}

typedef ModesMerger =
    List<Mode> Function(
      List<Mode> storyModes,
      List<Mode> scenarioModes,
    );

/// The default function to merge modes of a story and a scenario.
/// It puts the modes of the scenario first, and then adds the modes of the
/// story that are not already defined in the scenario.
List<Mode> defaultMergeModes(
  List<Mode> storyModes,
  List<Mode> scenarioModes,
) {
  final scenarioModesTypes = scenarioModes
      .map((mode) => mode.runtimeType)
      .toSet();

  final filteredStoryModes = storyModes.where(
    (mode) => !scenarioModesTypes.contains(mode.runtimeType),
  );

  return [
    ...scenarioModes,
    ...filteredStoryModes,
  ];
}

/// Defines a template for generating scenarios.
class ScenarioDefinition {
  ScenarioDefinition({
    required this.name,
    required this.modes,
    this.strategy = ScenarioStrategy.perScenario,
    this.mergeModes = defaultMergeModes,
  });

  final String name;
  final List<Mode> modes;

  /// How this definition is expanded into [Scenario]s for each [Story].
  ///
  /// Defaults to [ScenarioStrategy.perScenario].
  final ScenarioStrategy strategy;

  /// A function to merge the [modes] defined in the story and the ones
  /// defined in this [Scenario] or [ScenarioDefinition].
  ///
  /// By default it puts the modes of the story first, and then adds
  /// the modes of the scenario that are not already defined in the story.
  ///
  /// Only used for standalone scenarios created via
  /// [ScenarioStrategy.perStory]; crossed variants use the [mergeModes]
  /// of the local scenario they are based on.
  final ModesMerger mergeModes;
}
