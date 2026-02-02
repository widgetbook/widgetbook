import 'package:flutter/widgets.dart';

import '../state/state.dart';
import 'docs.dart';

/// A [DocBlock] that displays all stories for the current component.
///
/// Used to show a list of all available stories.
class StoriesDocBlock extends DocBlock {
  const StoriesDocBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    final stories = state.component!.stories;

    return ComposerDocBlock(
      children: stories.map((story) => StoryDocBlock(story: story)).toList(),
    );
  }
}
