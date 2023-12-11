import 'package:flutter/material.dart';

import '../navigation/nodes/nodes.dart' as v3;
import 'args/story_args.dart';

typedef StoryBuilder = Widget Function(BuildContext context, Widget story);

@optionalTypeArgs
abstract class Story<TWidget extends Widget, TArgs extends StoryArgs<TWidget>>
    extends v3.WidgetbookUseCase {
  Story({
    required super.name,
    required this.args,
    super.designLink,
    this.setup = defaultSetup,
  }) : super(
          builder: (context) => const SizedBox.shrink(), // TODO: remove
        );

  final TArgs args;
  final StoryBuilder setup;

  static Widget defaultSetup(
    BuildContext context,
    Widget story,
  ) {
    return story;
  }

  @override
  Widget build(BuildContext context) {
    final story = buildWith(context, args);
    return setup(context, story);
  }

  TWidget buildWith(BuildContext context, TArgs args);

  @override
  Story<TWidget, TArgs> copyWith({
    String? name,
    List<v3.WidgetbookNode>? children,
  }) {
    return this;
  }
}
