import 'package:flutter/material.dart';

import '../framework/framework.dart';
import '../state/state.dart';
import 'docs.dart';

/// A [DocBlock] that displays a single [Story] and its [StoryArgs].
///
/// Used to render an individual story and its details.
class StoryDocBlock extends DocBlock {
  const StoryDocBlock({super.key, required this.story});

  final Story<Widget, StoryArgs<Widget>> story;

  @override
  Widget build(BuildContext context) {
    final args = story.args.safeList;
    return ComposerDocBlock(
      children: [
        SubtitleDocBlock(title: story.name),
        story.buildWithConfig(
          context,
          WidgetbookState.of(context).config,
        ),
        if (args.isNotEmpty) ArgsDocBlock(args: args),
      ],
    );
  }
}
