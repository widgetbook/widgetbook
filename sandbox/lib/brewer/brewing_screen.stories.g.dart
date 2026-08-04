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
  path: component.path ?? 'brewer',
  docsBuilder: component.docsBuilder,
  docComment:
      r'''Shows [warning] for two seconds before revealing its [phase], so that a lost
[State] is visible in the workbench: a remounted screen falls back to the
warning and its mount number goes up.''',
  stories: [
    $Brewing..$generatedName = 'Brewing',
    $Diluting..$generatedName = 'Diluting',
    $BrewingFinished..$generatedName = 'BrewingFinished',
    $Flushing..$generatedName = 'Flushing',
    $BrewingAborted..$generatedName = 'BrewingAborted',
    $PistonRemoved..$generatedName = 'PistonRemoved',
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
             (context, args) => BrewingScreen(
               key: args.key,
               phase: args.phase,
               warning: args.warning,
             ),
       );
}

class BrewingScreenArgs extends StoryArgs<BrewingScreen> {
  BrewingScreenArgs({
    Arg<Key?>? key,
    Arg<BrewPhase>? phase,
    Arg<String>? warning,
  }) : this.keyArg = $initArg('key', key, null),
       this.phaseArg = $initArg(
         'phase',
         phase,
         EnumArg<BrewPhase>(BrewPhase.brewing, values: BrewPhase.values),
       )!,
       this.warningArg = $initArg(
         'warning',
         warning,
         StringArg('Watch out. Hot water'),
       )!;

  BrewingScreenArgs.fixed({
    Key? key,
    BrewPhase phase = BrewPhase.brewing,
    String warning = 'Watch out. Hot water',
  }) : this.keyArg = $initArg('key', key == null ? null : Arg.fixed(key), null),
       this.phaseArg = $initArg('phase', Arg.fixed(phase), null)!,
       this.warningArg = $initArg('warning', Arg.fixed(warning), null)!;

  final Arg<Key?>? keyArg;

  final Arg<BrewPhase> phaseArg;

  final Arg<String> warningArg;

  Key? get key => keyArg?.value;

  BrewPhase get phase => phaseArg.value;

  String get warning => warningArg.value;

  @override
  List<Arg?> get list => [keyArg, phaseArg, warningArg];
}
