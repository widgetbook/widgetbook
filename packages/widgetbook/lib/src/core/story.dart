import 'package:flutter/material.dart';

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
  Story({
    String? name,
    this.designLink,
    this.setup = defaultSetup,
    required this.args,
    required this.argsBuilder,
    this.scenarios = const [],
  }) : $name = name {
    scenarios.forEach((scenario) {
      scenario.story = this;
    });
  }

  final String? $name;
  final String? designLink;
  final TArgs args;
  final SetupBuilder<TWidget, TArgs> setup;
  final ArgsBuilder<TWidget, TArgs> argsBuilder;
  final List<Scenario<TWidget, TArgs>> scenarios;

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
