import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

import 'component.dart';
import 'scenario.dart';
import 'story_args.dart';

typedef SetupBuilder<TWidget extends Widget, TArgs extends StoryArgs<TWidget>> =
    Widget Function(
      BuildContext context,
      TWidget widget,
      TArgs args,
    );

typedef ArgsBuilder<TWidget extends Widget, TArgs extends StoryArgs<TWidget>> =
    TWidget Function(BuildContext context, TArgs args);

@optionalTypeArgs
abstract class Story<TWidget extends Widget, TArgs extends StoryArgs<TWidget>> {
  const Story({
    String? name,
    this.designLink,
    this.setup = defaultSetup,
    required this.args,
    required this.argsBuilder,
    this.scenarios = const [],
  }) : $name = name;

  final String? $name;
  final String? designLink;
  final TArgs args;
  final SetupBuilder<TWidget, TArgs> setup;
  final ArgsBuilder<TWidget, TArgs> argsBuilder;
  final List<Scenario<TWidget, TArgs>> scenarios;

  // We cannot initialize the Story's component in the component's constructor
  // because of generic types, as the component variable has `dynamic` types.
  // So we provide a getter that casts the generated component to the correct type.
  Component<TWidget, TArgs> get component;

  static Widget defaultSetup(
    BuildContext context,
    Widget widget,
    dynamic args,
  ) {
    return widget;
  }

  Widget build(BuildContext context) {
    return buildWithArgs(context, args);
  }

  /// Same as [build], but uses external [args] instead of [Story.args].
  Widget buildWithArgs(BuildContext context, TArgs args) {
    final widget = argsBuilder(context, args);
    final story = setup(context, widget, args);
    return story;
  }

  Widget buildWithScenario(
    BuildContext context,
    Scenario<TWidget, TArgs> scenario,
  ) {
    final effectiveArgs = scenario.args ?? args;
    final effectiveStory = buildWithArgs(context, effectiveArgs);

    return scenario.modes == null || scenario.modes!.isEmpty
        ? effectiveStory
        : Nested(
          children:
              scenario.modes!
                  .map(
                    (mode) => SingleChildBuilder(
                      builder: (context, child) => mode.build(context, child!),
                    ),
                  )
                  .toList(),
          child: effectiveStory,
        );
  }

  String get name {
    // A safe way to access [$name] in a non-nullable behavior for simplicity.
    // The name should ne provided via constructor or init method.
    assert(
      $name != null,
      'Name must be set via constructor or init method',
    );

    return $name!;
  }

  /// Creates a copy of this using the provided [name] for late initialization.
  /// If [$name] was already set, it should have precedence over [name].
  Story<TWidget, TArgs> init({
    required String name,
  });
}
