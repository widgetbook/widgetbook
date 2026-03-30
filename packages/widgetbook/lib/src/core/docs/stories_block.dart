import 'package:flutter/widgets.dart';

import '../state/state.dart';
import 'docs.dart';

/// A [DocBlock] that displays all stories for the current component.
///
/// The [height] parameter is forwarded to each [StoryDocBlock], controlling
/// how story previews are laid out within the docs page.
///
/// Example — unconstrained sizing for simple widget components:
/// ```dart
/// final meta = Meta<MyButton>(
///   docsBuilder: (blocks) => blocks.replaceFirst<StoriesDocBlock>(
///     const StoriesDocBlock.unconstrained(),
///   ),
/// );
/// ```
class StoriesDocBlock extends DocBlock {
  const StoriesDocBlock({
    super.key,
    this.height = defaultStoryHeight,
  });

  /// Creates a [StoriesDocBlock] without height constraints on story previews.
  ///
  /// Each story renders at its natural size. Use this for simple widgets
  /// that have a defined intrinsic height (e.g. buttons, cards).
  const StoriesDocBlock.unconstrained({super.key}) : height = null;

  /// The height in logical pixels for each story preview.
  ///
  /// When non-null, each story is wrapped in a [SizedBox] with this height.
  /// Defaults to 500.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);
    final stories = state.component!.stories;

    return ComposerDocBlock(
      children: stories.map((story) {
        if (height != null) {
          return StoryDocBlock(story: story, height: height!);
        }
        return StoryDocBlock.unconstrained(story: story);
      }).toList(),
    );
  }
}
