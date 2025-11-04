// ignore_for_file: strict_raw_type

import 'package:collection/collection.dart';
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
    ArgsBuilder<TArgs>? args,
    this.run,
    super.mergeModes,
  }) : _modes = modes,
       _args = args,
       super(modes: modes ?? []);

  final List<Mode>? _modes;
  final ArgsBuilder<TArgs>? _args;

  /// A late back-reference to the story this scenario belongs to.
  /// It is initialized in the [Story] constructor.
  late final Story<TWidget, TArgs> story;

  /// A function that is executed during the test after the widget is built
  /// and before the screenshot is taken.
  /// It can be used to interact with the widget, e.g. to open a dropdown
  /// or to trigger an animation.
  final Future<void> Function(WidgetTester tester, TArgs args)? run;

  ArgsBuilder<TArgs> get args => _args ?? story.args;

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
  Future<void>? execute(WidgetTester tester, TArgs args) {
    return run?.call(tester, args);
  }

  /// Merges [modes] into [addons].
  /// For example if [addons] are [TextScaleAddon(1), ThemeAddon('dark')]
  /// and [modes] are [TextScaleMode(3)] the result should be
  /// [TextScaleAddon(3), ThemeAddon('dark')].
  ///
  /// If [modes] are for an addon type that is not present in [addons],
  /// an assertion error is thrown.
  List<Addon> mergeModesIntoAddons(List<Addon> addons) {
    final addonTypes = addons.map((addon) => addon.runtimeType).toSet();
    final unmatchedModes = modes.where(
      (mode) => !addonTypes.contains(mode.addon.runtimeType),
    );

    assert(
      unmatchedModes.isEmpty,
      'Modes [${unmatchedModes.map((e) => e.runtimeType).join(', ')}] '
      'do not have a corresponding addon in config.',
    );

    return addons.map((addon) {
      final matchingMode = modes.firstWhereOrNull(
        (mode) => mode.addon.runtimeType == addon.runtimeType,
      );

      return matchingMode?.addon ?? addon;
    }).toList();
  }

  /// Injects both [Config.appBuilder] and [Config.addons] into the
  /// built story, which is built using the [args] of this scenario.
  Widget buildWithConfig(BuildContext context, Config config) {
    final effectiveStory = story.buildWithArgs(context, args(context));
    final mergedAddons = mergeModesIntoAddons(config.addons ?? []);

    return config.appBuilder(
      context,
      NestedBuilder(
        items: mergedAddons,
        builder: (context, addon, child) => addon.build(context, child),
        child: effectiveStory,
      ),
    );
  }
}
