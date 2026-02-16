import 'package:flutter/widgets.dart';

import 'story.dart';
import 'story_args.dart';

class Defaults<TWidget extends Widget, TArgs extends StoryArgs<TWidget>> {
  const Defaults({
    this.setup,
    this.builder,
  });

  final SetupBuilder<TWidget, TArgs>? setup;
  final StoryWidgetBuilder<TWidget, TArgs>? builder;
}
