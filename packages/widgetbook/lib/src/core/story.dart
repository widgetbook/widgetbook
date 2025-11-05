import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

import '../state/state.dart';
import 'builder_arg.dart';
import 'component.dart';
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
  // ignore: strict_raw_type
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

  String get path {
    return p.join(
      component.fullPath,
      name.replaceAll(' ', '-'),
    );
  }

  static Widget defaultSetup(
    BuildContext context,
    Widget widget,
    dynamic args,
  ) {
    return widget;
  }

  @internal
  void syncArgs(BuildContext context) {
    final state = WidgetbookState.of(context);
    args.safeList.forEach((arg) {
      arg.syncValueWithQueryGroup(state.queryGroups[arg.groupName]);
    });

    // ignore: strict_raw_type
    args.list.whereType<BuilderArg>().forEach((arg) {
      arg.syncValueWithContext(context);
    });
  }

  @internal
  void resetArgs() {
    args.safeList.forEach((arg) => arg.resetValue());
  }

  Widget build(BuildContext context) {
    syncArgs(context);
    return buildWithArgs(context, args);
  }

  /// Same as [build], but uses external [args] instead of [Story.args].
  Widget buildWithArgs(BuildContext context, TArgs args) {
    final widget = builder(context, args);
    final story = setup(context, widget, args);
    return story;
  }

  Scenario<TWidget, TArgs> generateScenarioFrom(
    ScenarioDefinition definition,
  ) {
    return Scenario<TWidget, TArgs>(
      name: definition.name,
      modes: definition.modes,
      mergeModes: definition.mergeModes,
    )..story = this;
  }
}
