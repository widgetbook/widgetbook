import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

import 'addons/base/mode.dart';
import 'args/story_args.dart';
import 'story.dart';

class Scenario<T> extends StatelessWidget {
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
  final StoryArgs<T>? args;
  final Story<T> story;

  Widget build(BuildContext context) {
    final effectiveArgs = args ?? story.args;
    final effectiveStory = effectiveArgs.build(context);

    return modes == null || modes!.isEmpty
        ? effectiveStory
        : Nested(
            children: modes!
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
