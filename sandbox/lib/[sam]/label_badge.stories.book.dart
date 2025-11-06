// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering, unused_element, strict_raw_type

part of 'label_badge.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<LabelBadge, NumericBadgeInputArgs>;
typedef _Scenario = LabelBadgeScenario;
typedef _Story = LabelBadgeStory;
typedef _Args = NumericBadgeInputArgs;
final LabelBadgeComponent = Component<LabelBadge, NumericBadgeInputArgs>(
  name: meta.name ?? 'LabelBadge',
  path: meta.path ?? '[sam]',
  docs: meta.docs,
  stories: [
    $Primary..$generatedName = 'Primary',
    $Secondary..$generatedName = 'Secondary',
  ],
);
typedef LabelBadgeScenario = Scenario<LabelBadge, NumericBadgeInputArgs>;

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
         builder: builder ?? $builder,
         setup: setup ?? $setup,
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
