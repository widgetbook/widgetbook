import 'package:flutter/material.dart';

import '../framework/framework.dart';
import '../state/state.dart';
import 'docs.dart';

/// A [DocBlock] that displays a single [Story] and its [StoryArgs].
///
/// Used to render an individual story and its details.
class StoryBlock extends DocBlock {
  const StoryBlock({super.key, required this.story});

  final Story<Widget, StoryArgs<Widget>> story;

  @override
  Widget build(BuildContext context) {
    final args = story.args.safeList;
    return ComposerBlock(
      children: [
        SubtitleBlock(title: story.name),
        story.buildWithConfig(
          context,
          WidgetbookState.of(context).config,
        ),
        if (args.isNotEmpty) ArgsBlock(args: args),
      ],
    );
  }
}
