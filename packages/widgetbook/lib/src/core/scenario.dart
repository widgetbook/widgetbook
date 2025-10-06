// ignore_for_file: strict_raw_type

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nested/nested.dart';

import '../addons/addons.dart';
import 'mode.dart';
import 'scenario_definition.dart';
import 'story.dart';
import 'story_args.dart';

typedef ScenarioRunner<TArgs extends StoryArgs> =
    Future<void> Function(
      WidgetTester tester,
      TArgs args,
    );

class Scenario<TWidget extends Widget, TArgs extends StoryArgs<TWidget>>
    extends ScenarioDefinition {
  Scenario({
    required super.name,
    List<Mode>? modes,
    TArgs? args,
    this.run,
    super.mergeModes,
  }) : _modes = modes,
       _args = args,
       super(modes: modes ?? []);

  final List<Mode>? _modes;
  final TArgs? _args;

  /// A late back-reference to the story this scenario belongs to.
  /// It is initialized in the [Story] constructor.
  late final Story<TWidget, TArgs> story;

  /// A function that is executed during the test after the widget is built
  /// and before the screenshot is taken.
  /// It can be used to interact with the widget, e.g. to open a dropdown
  /// or to trigger an animation.
  final Future<void> Function(WidgetTester tester, TArgs args)? run;

  TArgs get args => _args ?? story.args;

  /// Combines the [modes] defined in the [story] and the ones defined
  /// in this scenario. If both are null, returns null.
  @override
  List<Mode> get modes {
    final storyModes = story.modes;

    if (_modes == null && storyModes == null) return [];
    if (_modes == null) return storyModes ?? [];
    if (storyModes == null) return _modes;

    return mergeModes(storyModes, _modes);
  }

  /// Gets the viewport from the [modes] if a [ViewportMode] is present.
  /// Otherwise, returns null.
  ViewportData? get viewport {
    return modes.whereType<ViewportMode>().firstOrNull?.value;
  }

  // Wrapper to handle generic type parameters and avoid subtype errors like:
  // type `(WidgetTester, MyArgs) => Future<void>` is not a subtype
  // of type `(WidgetTester, StoryArgs<Widget>) => Future<void>`
  Future<void>? execute(WidgetTester tester) {
    return run?.call(tester, args);
  }

  Widget build(BuildContext context) {
    final effectiveStory = story.buildWithArgs(context, args);

    return modes.isEmpty
        ? effectiveStory
        : Nested(
          children:
              modes
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
    List<Mode>? modes,
    TArgs? args,
    ScenarioRunner<TArgs>? run,
    ModesMerger? mergeModes,
  }) {
    return Scenario<TWidget, TArgs>(
      name: name ?? this.name,
      modes: modes ?? this.modes,
      args: args ?? this.args,
      run: run ?? this.run,
      mergeModes: mergeModes ?? this.mergeModes,
    );
  }
}
