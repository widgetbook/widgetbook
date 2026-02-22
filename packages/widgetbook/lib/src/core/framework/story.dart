// ignore_for_file: strict_raw_type

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

import '../state/state.dart';
import '../utils.dart';
import 'addon.dart';
import 'builder_arg.dart';
import 'component.dart';
import 'config.dart';
import 'mode.dart';
import 'scenario.dart';
import 'scenario_definition.dart';
import 'story_args.dart';

typedef SetupBuilder<TWidget extends Widget, TArgs extends StoryArgs<TWidget>> =
    Widget Function(
      BuildContext context,
      TWidget widget,
      TArgs args,
    );

typedef StoryWidgetBuilder<
  TWidget extends Widget,
  TArgs extends StoryArgs<TWidget>
> = TWidget Function(BuildContext context, TArgs args);

@optionalTypeArgs
abstract class Story<TWidget extends Widget, TArgs extends StoryArgs<TWidget>> {
  Story({
    String? name,
    this.designLink,
    this.setup = defaultSetup,
    this.modes,
    required this.args,
    required this.builder,
    this.scenarios = const [],
  }) : this._name = name,
       assert(name != 'Docs', 'Story name cannot be "Docs"') {
    scenarios.forEach((scenario) {
      scenario.story = this;
    });
  }

  final String? _name;
  late final String $generatedName;
  String get name => _name ?? $generatedName;

  final String? designLink;
  final TArgs args;
  final SetupBuilder<TWidget, TArgs> setup;
  final List<Scenario<TWidget, TArgs>> scenarios;

  /// Defines how the [TWidget] is built using the provided [TArgs].
  final StoryWidgetBuilder<TWidget, TArgs> builder;

  /// These [Mode]s are only applied to [Scenario]s in this [Story] using
  /// the [Scenario.mergeModes] function to combine them with [Scenario.modes].
  /// They are not applied to the [Story] itself.
  ///
  /// This is useful to inject story-specific modes in addition to the
  /// ones defined in [ScenarioDefinition]s.
  final List<Mode>? modes;

  /// A late back-reference to the component this story belongs to.
  /// It is initialized in the [Component] constructor.
  // No type params are specified due generic stories.
  // Suppose that there are two stories in a component:
  // - Story1<TWidget<T1>, TArgs>
  // - Story2<TWidget<T2>, TArgs>
  // Then they both should be able to reference the component of type
  // `Component<TWidget, TArgs>` not `Component<TWidget<T1>, TArgs>` or
  // `Component<TWidget<T2>, TArgs>`.
  late final Component component;

  String get path => p.join(component.fullPath, name);

  /// By default, Widgetbook forces a rebuild when args change as otherwise
  /// StatefulWidgets might not reflect the latest arg values.
  /// However, if a story has internal state that should be preserved across
  /// arg changes, this can be achieved by overriding the [setup] function and
  /// returning the widget unchanged.
  static Widget defaultSetup(
    BuildContext context,
    Widget widget,
    StoryArgs args,
  ) {
    final key = ValueKey(
      Object.hashAll(
        args.safeList.map((arg) => arg.toQueryGroup()),
      ),
    );

    return KeyedSubtree(
      key: key,
      child: widget,
    );
  }

  @internal
  void syncArgs(BuildContext context) {
    final state = WidgetbookState.maybeOf(context);

    // State can be absent if no scope is found in the context.
    // This happens when building a scenario.
    if (state == null) return;

    args.safeList.forEach((arg) {
      arg.syncValue(state.queryGroups[arg.groupName]);
    });
  }

  @internal
  void resetArgs() {
    args.safeList.forEach((arg) => arg.resetValue());
  }

  // Called separately from [syncArgs] to initialize BuilderArgs
  // in [buildWithArgs] when building [Scenario]s with external args.
  @internal
  void initBuilderArgs(BuildContext context, TArgs args) {
    args.list.whereType<BuilderArg>().forEach((arg) {
      arg.init(context);
    });
  }

  /// Builds the story widget wrapped with addons from the provided [config].
  /// Optionally, [args] and [modes] can be provided to override
  /// the story's default args and merge modes into the addons.
  Widget buildWithConfig(
    BuildContext context,
    Config config, {
    TArgs? args,
    List<Mode>? modes,
  }) {
    final effectiveArgs = args ?? this.args;
    final effectiveAddons = mergeModesIntoAddons(modes, config.addons ?? []);

    syncArgs(context);
    initBuilderArgs(context, effectiveArgs);

    final widget = builder(context, effectiveArgs);
    final story = setup(context, widget, effectiveArgs);

    return config.appBuilder(
      context,
      NestedBuilder(
        items: effectiveAddons,
        builder: (context, addon, child) => addon.build(context, child),
        child: story,
      ),
    );
  }

  /// Merges [modes] into [addons].
  /// For example if [addons] are [TextScaleAddon(1), ThemeAddon('dark')]
  /// and [modes] are [TextScaleMode(3)] the result should be
  /// [TextScaleAddon(3), ThemeAddon('dark')].
  ///
  /// If [modes] are for an addon type that is not present in [addons],
  /// an assertion error is thrown.
  List<Addon> mergeModesIntoAddons(List<Mode>? modes, List<Addon>? addons) {
    if (addons == null) return [];
    if (modes == null) return addons;

    final addonTypes = addons.map((addon) => addon.runtimeType).toSet();
    final unmatchedModes = modes.where(
      (mode) => !addonTypes.contains(mode.addon.runtimeType),
    );

    assert(
      unmatchedModes.isEmpty,
      'Modes [${unmatchedModes.map((e) => e.runtimeType).join(', ')}] '
      'do not have a corresponding addon in config.',
    );

    return addons.map((addon) {
      final matchingMode = modes.firstWhereOrNull(
        (mode) => mode.addon.runtimeType == addon.runtimeType,
      );

      return matchingMode?.addon ?? addon;
    }).toList();
  }

  /// A list of all scenarios for this story. The list includes the local ones
  /// defined in [scenarios] as well as the ones generated from the
  /// [ScenarioDefinition]s defined in the [Config].
  /// If no scenarios are defined, a default scenario is returned.
  List<Scenario<TWidget, TArgs>> allScenarios(Config config) {
    final localScenarios = scenarios;
    final globalScenarios = config.scenarios.map(
      (definition) => Scenario<TWidget, TArgs>(
        type: ScenarioType.global,
        name: definition.name,
        modes: definition.modes,
        mergeModes: definition.mergeModes,
      )..story = this,
    );

    final defaultScenario = Scenario<TWidget, TArgs>(
      type: ScenarioType.$default,
      name: 'Default',
    )..story = this;

    return globalScenarios.isEmpty && localScenarios.isEmpty
        ? [defaultScenario]
        : [...globalScenarios, ...localScenarios];
  }
}
