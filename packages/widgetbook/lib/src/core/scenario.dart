// ignore_for_file: strict_raw_type

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../addons/addons.dart';
import '../utils.dart';
import 'addon.dart';
import 'config.dart';
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

  /// Merge [addons] with [modes], with [modes] taking precedence
  /// For example if [addons] are [TextScaleAddon(1), ThemeAddon('dark')]
  /// and [modes] are [TextScaleMode(3), LocaleMode('fr')] the result should be
  /// [TextScaleAddon(3), ThemeAddon('dark'), LocaleAddon('fr')]
  List<Addon> mergeAddonsWithModes(List<Addon> addons) {
    final addonsCopy = List<Addon>.from(addons);

    for (final mode in modes) {
      final existingIndex = addonsCopy.indexWhere(
        (addon) => addon.runtimeType == mode.addon.runtimeType,
      );

      if (existingIndex != -1) {
        // if there's an addon for the given mode,
        // we replace it with the mode's addon
        addonsCopy[existingIndex] = mode.addon;
      } else {
        // Otherwise, we add the mode's addon
        // to the end of the list
        addonsCopy.add(mode.addon);
      }
    }

    return addonsCopy;
  }

  /// Injects both [Config.appBuilder] and [Config.addons] into the
  /// built story, which is built using the [args] of this scenario.
  Widget buildWithConfig(BuildContext context, Config config) {
    final effectiveStory = story.buildWithArgs(context, args);
    final mergedAddons = mergeAddonsWithModes(config.addons ?? []);

    return config.appBuilder(
      context,
      NestedBuilder(
        items: mergedAddons,
        builder: (context, addon, child) => addon.build(context, child),
        child: effectiveStory,
      ),
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
