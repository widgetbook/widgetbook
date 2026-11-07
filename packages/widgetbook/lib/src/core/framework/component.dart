import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p show posix;

import '../docs/docs.dart';
import 'story.dart';
import 'story_args.dart';

class Component<TWidget extends Widget, TArgs extends StoryArgs<TWidget>> {
  Component({
    required this.name,
    this.path = '',
    this.docsBuilder,
    this.docComment,
    required this.stories,
  }) {
    stories.forEach((story) {
      story.component = this;
    });
  }

  final String name;
  final String path;
  final String? docComment;
  final DocsBuilderFunction? docsBuilder;
  final List<Story<TWidget, TArgs>> stories;

  String get fullPath => p.posix.join(path, name);
  String get docsPath => p.posix.join(fullPath, 'Docs');
}
