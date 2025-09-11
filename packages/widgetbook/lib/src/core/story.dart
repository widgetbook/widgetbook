import 'package:flutter/material.dart';

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
  }) : $name = name;

  final String? $name;
  final String? designLink;
  final TArgs args;
  final SetupBuilder<TWidget, TArgs> setup;
  final ArgsBuilder<TWidget, TArgs> argsBuilder;

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
