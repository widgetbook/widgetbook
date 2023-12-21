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
    required this.name,
    this.designLink,
    this.setup = defaultSetup,
    required this.args,
    required this.argsBuilder,
  });

  final String name;
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
}
