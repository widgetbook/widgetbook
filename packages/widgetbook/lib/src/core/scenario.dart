import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

import 'mode.dart';
import 'story.dart';
import 'story_args.dart';

class Scenario<TWidget extends Widget, TArgs extends StoryArgs<TWidget>>
    extends StatelessWidget {
  const Scenario({
    super.key,
    required this.name,
    this.modes,
    this.args,
    required this.story,
  });

  final String name;
  // ignore: strict_raw_type
  final List<Mode>? modes;
  final TArgs? args;
  final Story<TWidget, TArgs> story;

  Widget build(BuildContext context) {
    final effectiveArgs = args ?? story.args;
    final effectiveStory = story.buildWithArgs(context, effectiveArgs);

    return modes == null || modes!.isEmpty
        ? effectiveStory
        : Nested(
          children:
              modes!
                  .map(
                    (mode) => SingleChildBuilder(
                      builder: (context, child) => mode.build(context, child!),
                    ),
                  )
                  .toList(),
          child: effectiveStory,
        );
  }
}
