import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;

import 'story.dart';
import 'story_args.dart';

class Component<TWidget extends Widget, TArgs extends StoryArgs<TWidget>> {
  Component({
    required this.name,
    this.path = '',
    this.docs,
    required this.stories,
  }) {
    stories.forEach((story) {
      story.component = this;
    });
  }

  final String name;
  final String path;
  final String? docs;
  final List<Story<TWidget, TArgs>> stories;

  String get fullPath => p.join(path, name);
  String get docsPath => p.join(fullPath, 'Docs');
}
