import 'package:flutter/widgets.dart';

import 'mode.dart';
import 'story_args.dart';

class Scenario<TWidget extends Widget, TArgs extends StoryArgs<TWidget>> {
  const Scenario({
    required this.name,
    this.modes,
    this.args,
  });

  final String name;
  // ignore: strict_raw_type
  final List<Mode>? modes;
  final TArgs? args;
}
