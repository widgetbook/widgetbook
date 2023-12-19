import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;

import 'args/story_args.dart';
import 'meta.dart';
import 'story.dart';

class Component<TWidget extends Widget, TArgs extends StoryArgs<TWidget>> {
  Component({
    required this.meta,
    required this.stories,
  });

  final Meta<TWidget> meta;
  final List<Story<TWidget, TArgs>> stories;

  String get name => meta.name;
  String? get path => meta.path;

  String pathOf(Story story) {
    return p.join(path ?? '', name, story.name);
  }
}
