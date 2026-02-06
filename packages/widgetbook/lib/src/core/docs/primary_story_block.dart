import 'package:flutter/widgets.dart';

import '../framework/component.dart';
import '../framework/story.dart';
import '../state/state.dart';
import 'docs.dart';

/// A [DocBlock] that displays the [Story] defined first in the list of stories
/// of the current [Component].
///
/// Used to highlight the main example.
class PrimaryStoryDocBlock extends DocBlock {
  const PrimaryStoryDocBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    final primaryStory = state.component!.stories.first;

    return StoryDocBlock(story: primaryStory);
  }
}
