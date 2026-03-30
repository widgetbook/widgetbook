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
  const PrimaryStoryDocBlock({super.key, this.height = defaultStoryHeight});

  /// Creates a [PrimaryStoryDocBlock] without a height constraint.
  const PrimaryStoryDocBlock.unconstrained({super.key}) : height = null;

  /// The height in logical pixels for the story preview container.
  ///
  /// When non-null, the story is wrapped in a [SizedBox] with this height.
  /// Defaults to 500.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    final primaryStory = state.component!.stories.first;

    if (height != null) {
      return StoryDocBlock(story: primaryStory, height: height!);
    }
    return StoryDocBlock.unconstrained(story: primaryStory);
  }
}
