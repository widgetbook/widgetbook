import 'package:flutter/material.dart';

import '../navigation/nodes/nodes.dart' as v3;
import 'args/story_args.dart';

typedef SetupBuilder = Widget Function(BuildContext context, Widget story);
typedef ArgsBuilder<TWidget extends Widget, TArgs extends StoryArgs<TWidget>>
    = TWidget Function(BuildContext context, TArgs args);

@optionalTypeArgs
abstract class Story<TWidget extends Widget, TArgs extends StoryArgs<TWidget>>
    extends v3.WidgetbookUseCase {
  Story({
    required super.name,
    super.designLink,
    this.setup = defaultSetup,
    required this.args,
    required this.argsBuilder,
  }) : super(
          builder: (context) => const SizedBox.shrink(), // TODO: remove
        );

  final TArgs args;
  final SetupBuilder setup;
  final ArgsBuilder<TWidget, TArgs> argsBuilder;

  static Widget defaultSetup(
    BuildContext context,
    Widget story,
  ) {
    return story;
  }

  @override
  Widget build(BuildContext context) {
    final story = argsBuilder(context, args);
    return setup(context, story);
  }

  @override
  Story<TWidget, TArgs> copyWith({
    String? name,
    List<v3.WidgetbookNode>? children,
  }) {
    return this;
  }
}
