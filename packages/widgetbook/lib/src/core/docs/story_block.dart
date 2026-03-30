import 'package:flutter/material.dart';

import '../framework/framework.dart';
import '../state/state.dart';
import 'docs.dart';

/// A [DocBlock] that displays a single [Story] and its [StoryArgs].
///
/// By default, the story preview is rendered inside a fixed-height [SizedBox]
/// to provide bounded constraints. This prevents layout errors for widgets that
/// require finite height (e.g. [Scaffold], [Overlay], [Expanded]).
///
/// Use [StoryDocBlock.unconstrained] for simple widgets that have a natural
/// intrinsic height (e.g. buttons, cards).
class StoryDocBlock extends DocBlock {
  const StoryDocBlock({
    super.key,
    required this.story,
    this.height = defaultStoryHeight,
  });

  /// Creates a [StoryDocBlock] without a height constraint.
  ///
  /// The story preview renders at its natural size. Use this for simple
  /// widgets that have a defined intrinsic height (e.g. buttons, cards).
  ///
  /// Widgets that require bounded constraints (e.g. [Scaffold], [Overlay],
  /// [Expanded]) will fail with this constructor.
  const StoryDocBlock.unconstrained({
    super.key,
    required this.story,
  }) : height = null;

  final Story<Widget, StoryArgs<Widget>> story;

  /// The height in logical pixels for the story preview container.
  ///
  /// When non-null, the story is wrapped in a [SizedBox] with this height.
  /// Defaults to 500.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final args = story.args.safeList;

    var preview = story.buildWithConfig(
      context,
      WidgetbookState.of(context).config,
    );

    if (height != null) {
      preview = SizedBox(
        height: height,
        child: preview,
      );
    }

    return ComposerDocBlock(
      children: [
        SubtitleDocBlock(title: story.name),
        WidgetDocBlock(preview),
        if (args.isNotEmpty) ArgsDocBlock(args: args),
      ],
    );
  }
}
