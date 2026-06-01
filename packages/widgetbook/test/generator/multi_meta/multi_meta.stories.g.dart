// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_meta.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<MultiMetaWidget, StoryArgs<MultiMetaWidget>>;
typedef _Scenario = MultiMetaWidgetScenario;
typedef _Defaults = MultiMetaWidgetDefaults;
typedef _Story = MultiMetaWidgetStory;
typedef _CounterStory = MultiMetaWidgetCounterStory;
typedef _Args = MultiMetaWidgetArgs;
typedef _CounterArgs = MultiMetaWidgetCounterArgs;
final MultiMetaWidgetComponent =
    Component<MultiMetaWidget, StoryArgs<MultiMetaWidget>>(
      name: meta.name ?? 'MultiMetaWidget',
      path: meta.path ?? '',
      docsBuilder: meta.docsBuilder,
      docComment: null,
      stories: [
        $Default..$generatedName = 'Default',
        $FiveCounts..$generatedName = 'FiveCounts',
      ],
    );
typedef MultiMetaWidgetScenario =
    Scenario<MultiMetaWidget, MultiMetaWidgetArgs>;
typedef MultiMetaWidgetDefaults =
    Defaults<MultiMetaWidget, MultiMetaWidgetArgs>;

class MultiMetaWidgetStory extends Story<MultiMetaWidget, MultiMetaWidgetArgs> {
  MultiMetaWidgetStory({
    super.name,
    super.setup,
    super.modes,
    MultiMetaWidgetArgs? args,
    StoryWidgetBuilder<MultiMetaWidget, MultiMetaWidgetArgs>? builder,
    super.scenarios,
  }) : super(
         args: args ?? MultiMetaWidgetArgs(),
         builder:
             builder ??
             (context, args) =>
                 MultiMetaWidget(key: args.key, label: args.label),
       );
}

class MultiMetaWidgetCounterStory
    extends Story<MultiMetaWidget, MultiMetaWidgetCounterArgs> {
  MultiMetaWidgetCounterStory({
    super.name,
    super.setup,
    super.modes,
    MultiMetaWidgetCounterArgs? args,
    StoryWidgetBuilder<MultiMetaWidget, MultiMetaWidgetCounterArgs>? builder,
    super.scenarios,
  }) : super(
         args: args ?? MultiMetaWidgetCounterArgs(),
         builder:
             builder ??
             (context, args) =>
                 MultiMetaWidget.counter(key: args.key, count: args.count),
       );
}

class MultiMetaWidgetArgs extends StoryArgs<MultiMetaWidget> {
  MultiMetaWidgetArgs({Arg<Key?>? key, Arg<String>? label})
    : this.keyArg = $initArg('key', key, null),
      this.labelArg = $initArg('label', label, StringArg(''))!;

  MultiMetaWidgetArgs.fixed({Key? key, String label = ''})
    : this.keyArg = key == null ? null : Arg.fixed(key),
      this.labelArg = Arg.fixed(label);

  final Arg<Key?>? keyArg;

  final Arg<String> labelArg;

  Key? get key => keyArg?.value;

  String get label => labelArg.value;

  @override
  List<Arg?> get list => [keyArg, labelArg];
}

class MultiMetaWidgetCounterArgs extends StoryArgs<MultiMetaWidget> {
  MultiMetaWidgetCounterArgs({Arg<Key?>? key, Arg<int>? count})
    : this.keyArg = $initArg('key', key, null),
      this.countArg = $initArg('count', count, IntArg(0))!;

  MultiMetaWidgetCounterArgs.fixed({Key? key, int count = 0})
    : this.keyArg = key == null ? null : Arg.fixed(key),
      this.countArg = Arg.fixed(count);

  final Arg<Key?>? keyArg;

  final Arg<int> countArg;

  Key? get key => keyArg?.value;

  int get count => countArg.value;

  @override
  List<Arg?> get list => [keyArg, countArg];
}
