import 'package:flutter/material.dart';

import 'story_args.dart';

typedef SetupBuilder<TArgs> = Widget Function(
  BuildContext context,
  Widget story,
  TArgs args,
);

typedef ArgsBuilder<TWidget extends Widget, TArgs extends StoryArgs<TWidget>>
    = TWidget Function(BuildContext context, TArgs args);

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
  final SetupBuilder<TArgs> setup;
  final ArgsBuilder<TWidget, TArgs> argsBuilder;

  static Widget defaultSetup(
    BuildContext context,
    Widget story,
    dynamic args,
  ) {
    return story;
  }

  Widget build(BuildContext context) {
    return buildWithArgs(context, args);
  }

  /// Same as [build], but uses external [args] instead of [Story.args].
  Widget buildWithArgs(BuildContext context, TArgs args) {
    final story = argsBuilder(context, args);
    return setup(context, story, args);
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
