import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;

import 'meta.dart';
import 'story.dart';
import 'story_args.dart';

class Component<TWidget extends Widget, TArgs extends StoryArgs<TWidget>> {
  Component({
    required this.meta,
    required this.stories,
  }) {
    stories.forEach((story) {
      story.component = this;
    });
  }

  final Meta<TWidget> meta;
  final List<Story<TWidget, TArgs>> stories;

  String get name => meta.name;
  String? get path => meta.path;
  String? get docs => meta.docs;

  String get fullPath => p.join(path ?? '', name);
  String get docsPath => p.join(fullPath, 'Docs');

  String pathOf(Story story) {
    return p.join(
      fullPath,
      story.name.replaceAll(' ', '-'),
    );
  }
}
