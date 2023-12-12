import 'package:flutter/widgets.dart';

import '../navigation/nodes/nodes.dart' as v3;
import 'args/story_args.dart';
import 'meta.dart';
import 'story.dart';

class Component<TWidget extends Widget, TArgs extends StoryArgs<TWidget>>
    extends v3.WidgetbookComponent {
  Component({
    required this.meta,
    required this.stories,
  }) : super(
          name: meta.name,
          useCases: stories,
        );

  final Meta<TWidget> meta;
  final List<Story<TWidget, TArgs>> stories;
}
