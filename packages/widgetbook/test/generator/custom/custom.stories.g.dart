// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<LabelBadge, NumericBadgeInputArgs>;
typedef _Scenario = LabelBadgeScenario;
typedef _Defaults = LabelBadgeDefaults;
typedef _Story = LabelBadgeStory;
typedef _Args = NumericBadgeInputArgs;
final LabelBadgeComponent = Component<LabelBadge, NumericBadgeInputArgs>(
  name: meta.name ?? 'LabelBadge',
  path: meta.path ?? '',
  docsBuilder: meta.docsBuilder,
  docComment: null,
  stories: [$Default..$generatedName = 'Default'],
);
typedef LabelBadgeScenario = Scenario<LabelBadge, NumericBadgeInputArgs>;
typedef LabelBadgeDefaults = Defaults<LabelBadge, NumericBadgeInputArgs>;

class LabelBadgeStory extends Story<LabelBadge, NumericBadgeInputArgs> {
  LabelBadgeStory({
    super.name,
    SetupBuilder<LabelBadge, NumericBadgeInputArgs>? setup,
    super.modes,
    NumericBadgeInputArgs? args,
    StoryWidgetBuilder<LabelBadge, NumericBadgeInputArgs>? builder,
    super.scenarios,
  }) : super(
         args: args ?? NumericBadgeInputArgs(),
         builder: builder ?? defaults.builder!,
       );
}

class NumericBadgeInputArgs extends StoryArgs<LabelBadge> {
  NumericBadgeInputArgs({Arg<int>? number})
    : this.numberArg = $initArg('number', number, IntArg(0))!;

  NumericBadgeInputArgs.fixed({int number = 0})
    : this.numberArg = Arg.fixed(number);

  final Arg<int> numberArg;

  int get number => numberArg.value;

  @override
  List<Arg?> get list => [numberArg];
}
