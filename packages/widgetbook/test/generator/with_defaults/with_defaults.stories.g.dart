// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'with_defaults.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<DefaultsVarWidget, DefaultsVarInputArgs>;
typedef _Scenario = DefaultsVarWidgetScenario;
typedef _Defaults = DefaultsVarWidgetDefaults;
typedef _Story = DefaultsVarWidgetStory;
typedef _Args = DefaultsVarInputArgs;
final DefaultsVarWidgetComponent =
    Component<DefaultsVarWidget, DefaultsVarInputArgs>(
      name: meta.name ?? 'DefaultsVarWidget',
      path: meta.path ?? '',
      docsBuilder: meta.docsBuilder,
      docComment: null,
      stories: [$Default..$generatedName = 'Default'],
    );
typedef DefaultsVarWidgetScenario =
    Scenario<DefaultsVarWidget, DefaultsVarInputArgs>;
typedef DefaultsVarWidgetDefaults =
    Defaults<DefaultsVarWidget, DefaultsVarInputArgs>;

class DefaultsVarWidgetStory
    extends Story<DefaultsVarWidget, DefaultsVarInputArgs> {
  DefaultsVarWidgetStory({
    super.name,
    SetupBuilder<DefaultsVarWidget, DefaultsVarInputArgs>? setup,
    super.modes,
    DefaultsVarInputArgs? args,
    StoryWidgetBuilder<DefaultsVarWidget, DefaultsVarInputArgs>? builder,
    super.scenarios,
  }) : super(
         args: args ?? DefaultsVarInputArgs(),
         builder: builder ?? defaults.builder!,
         setup: setup ?? defaults.setup!,
       );
}

class DefaultsVarInputArgs extends StoryArgs<DefaultsVarWidget> {
  DefaultsVarInputArgs({Arg<String>? label})
    : this.labelArg = $initArg('label', label, StringArg(''))!;

  DefaultsVarInputArgs.fixed({String label = ''})
    : this.labelArg = Arg.fixed(label);

  final Arg<String> labelArg;

  String get label => labelArg.value;

  @override
  List<Arg?> get list => [labelArg];
}
