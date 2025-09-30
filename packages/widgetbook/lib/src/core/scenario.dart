import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

import 'mode.dart';
import 'story.dart';
import 'story_args.dart';

class Scenario<TWidget extends Widget, TArgs extends StoryArgs<TWidget>> {
  Scenario({
    required this.name,
    this.modes,
    TArgs? args,
    this.constraints,
  }) : _args = args;

  final String name;
  // ignore: strict_raw_type
  final List<Mode>? modes;
  final TArgs? _args;

  /// The constraints is helpful to limit the size for widgets that expand
  /// to the maximum size available.
  /// If not specified, the value from [Story.scenariosConstraints] is used.
  final ViewConstraints? constraints;

  /// A late back-reference to the story this scenario belongs to.
  /// It is initialized in the [Story] constructor.
  late final Story<TWidget, TArgs> story;

  TArgs get args => _args ?? story.args;

  Widget build(BuildContext context) {
    final effectiveStory = story.buildWithArgs(context, args);

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

  Scenario<TWidget, TArgs> copyWith({
    String? name,
    // ignore: strict_raw_type
    List<Mode>? modes,
    TArgs? args,
    ViewConstraints? constraints,
  }) {
    return Scenario<TWidget, TArgs>(
      name: name ?? this.name,
      modes: modes ?? this.modes,
      args: args ?? this.args,
      constraints: constraints ?? this.constraints,
    );
  }
}
