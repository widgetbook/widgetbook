import 'package:flutter/widgets.dart';

import 'mode.dart';
import 'story.dart';
import 'story_args.dart';

class Scenario<TWidget extends Widget, TArgs extends StoryArgs<TWidget>> {
  Scenario({
    required this.name,
    this.modes,
    this.args,
  });

  final String name;
  // ignore: strict_raw_type
  final List<Mode>? modes;
  final TArgs? args;

  /// A late back-reference to the story this scenario belongs to.
  /// It is initialized in the [Story] constructor.
  late final Story<TWidget, TArgs> story;

  Scenario<TWidget, TArgs> copyWith({
    String? name,
    // ignore: strict_raw_type
    List<Mode>? modes,
    TArgs? args,
  }) {
    return Scenario<TWidget, TArgs>(
      name: name ?? this.name,
      modes: modes ?? this.modes,
      args: args ?? this.args,
    );
  }
}
