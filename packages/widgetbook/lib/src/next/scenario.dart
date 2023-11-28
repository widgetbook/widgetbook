import 'package:flutter/widgets.dart';

import 'args/story_args.dart';
import 'mode.dart';
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

    return effectiveArgs.build(context);
  }
}
