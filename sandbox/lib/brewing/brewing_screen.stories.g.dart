// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering, unused_element, strict_raw_type

part of 'brewing_screen.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<BrewingScreen, StoryArgs<BrewingScreen>>;
typedef _Scenario = BrewingScreenScenario;
typedef _Defaults = BrewingScreenDefaults;
typedef _Story = BrewingScreenStory;
typedef _Args = BrewingScreenArgs;
final BrewingScreenComponent = Component<BrewingScreen, StoryArgs<BrewingScreen>>(
  name: component.name ?? 'BrewingScreen',
  path: component.path ?? 'brewing',
  docsBuilder: component.docsBuilder,
  docComment:
      r'''A screen that reads [status] once in its [State], like screens that set up
controllers, animations or derived data for the state they were built with.''',
  stories: [
    $Brewing..$generatedName = 'Brewing',
    $Diluting..$generatedName = 'Diluting',
    $Flushing..$generatedName = 'Flushing',
    $Finished..$generatedName = 'Finished',
  ],
);
typedef BrewingScreenScenario = Scenario<BrewingScreen, BrewingScreenArgs>;
typedef BrewingScreenDefaults = Defaults<BrewingScreen, BrewingScreenArgs>;

class BrewingScreenStory extends Story<BrewingScreen, BrewingScreenArgs> {
  BrewingScreenStory({
    super.name,
    super.designLink,
    super.setup,
    super.modes,
    BrewingScreenArgs? args,
    StoryWidgetBuilder<BrewingScreen, BrewingScreenArgs>? builder,
    super.scenarios,
    super.excludeFromTests,
  }) : super(
         args: args ?? BrewingScreenArgs(),
         builder:
             builder ??
             (context, args) =>
                 BrewingScreen(key: args.key, status: args.status),
       );
}

class BrewingScreenArgs extends StoryArgs<BrewingScreen> {
  BrewingScreenArgs({Arg<Key?>? key, Arg<String>? status})
    : this.keyArg = $initArg('key', key, null),
      this.statusArg = $initArg('status', status, StringArg(''))!;

  BrewingScreenArgs.fixed({Key? key, String status = ''})
    : this.keyArg = $initArg('key', key == null ? null : Arg.fixed(key), null),
      this.statusArg = $initArg('status', Arg.fixed(status), null)!;

  final Arg<Key?>? keyArg;

  final Arg<String> statusArg;

  Key? get key => keyArg?.value;

  String get status => statusArg.value;

  @override
  List<Arg?> get list => [keyArg, statusArg];
}
