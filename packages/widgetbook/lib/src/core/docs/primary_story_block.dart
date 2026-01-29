import 'package:flutter/widgets.dart';

import '../../../widgetbook.dart';

/// A [DocBlock] that displays the [Story] defined first in the list of stories
/// of the current [Component].
///
/// Used to highlight the main example.
class PrimaryStoryBlock extends DocBlock {
  const PrimaryStoryBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    final primaryStory = state.component!.stories.first;

    return StoryBlock(story: primaryStory);
  }
}
