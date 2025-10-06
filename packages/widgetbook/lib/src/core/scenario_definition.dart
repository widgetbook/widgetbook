// ignore_for_file: strict_raw_type

import 'mode.dart';

typedef ModesMerger =
    List<Mode> Function(
      List<Mode> storyModes,
      List<Mode> scenarioModes,
    );

/// The default function to merge modes of a story and a scenario.
/// It puts the modes of the story first, and then adds the modes of the
/// scenario that are not already defined in the story.
List<Mode> defaultMergeModes(
  List<Mode> storyModes,
  List<Mode> scenarioModes,
) {
  final storyModesTypes = storyModes.map((mode) => mode.runtimeType).toSet();
  final filteredScenarioModes = scenarioModes.where(
    (mode) => !storyModesTypes.contains(mode.runtimeType),
  );

  return [
    ...storyModes,
    ...filteredScenarioModes,
  ];
}

/// Defines a template for generating scenarios.
class ScenarioDefinition {
  ScenarioDefinition({
    required this.name,
    required this.modes,
    this.mergeModes = defaultMergeModes,
  });

  final String name;
  final List<Mode> modes;

  /// A function to merge the [modes] defined in the story and the ones
  /// defined in this [Scenario] or [ScenarioDefinition].
  ///
  /// By default it puts the modes of the story first, and then adds
  /// the modes of the scenario that are not already defined in the story.
  final ModesMerger mergeModes;
}
