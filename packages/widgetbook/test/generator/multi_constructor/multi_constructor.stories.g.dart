// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_constructor.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component =
    Component<MultiConstructorWidget, StoryArgs<MultiConstructorWidget>>;
typedef _Scenario = MultiConstructorWidgetScenario;
typedef _Defaults = MultiConstructorWidgetDefaults;
typedef _Story = MultiConstructorWidgetStory;
typedef _Args = MultiConstructorWidgetArgs;
typedef _OtherScenario = MultiConstructorWidgetOtherScenario;
typedef _OtherDefaults = MultiConstructorWidgetOtherDefaults;
typedef _OtherStory = MultiConstructorWidgetOtherStory;
typedef _OtherArgs = MultiConstructorWidgetOtherArgs;
final MultiConstructorWidgetComponent =
    Component<MultiConstructorWidget, StoryArgs<MultiConstructorWidget>>(
      name: 'MultiConstructorWidget',
      path: '',
      docComment: null,
      stories: [
        $Default..$generatedName = 'Default',
        $Other..$generatedName = 'Other',
      ],
    );
typedef MultiConstructorWidgetScenario =
    Scenario<MultiConstructorWidget, MultiConstructorWidgetArgs>;
typedef MultiConstructorWidgetDefaults =
    Defaults<MultiConstructorWidget, MultiConstructorWidgetArgs>;

class MultiConstructorWidgetStory
    extends Story<MultiConstructorWidget, MultiConstructorWidgetArgs> {
  MultiConstructorWidgetStory({
    super.name,
    super.setup,
    super.modes,
    MultiConstructorWidgetArgs? args,
    StoryWidgetBuilder<MultiConstructorWidget, MultiConstructorWidgetArgs>?
    builder,
    super.scenarios,
  }) : super(
         args: args ?? MultiConstructorWidgetArgs(),
         builder:
             builder ??
             (context, args) =>
                 MultiConstructorWidget(key: args.key, count: args.count),
       );
}

class MultiConstructorWidgetArgs extends StoryArgs<MultiConstructorWidget> {
  MultiConstructorWidgetArgs({Arg<Key?>? key, Arg<int>? count})
    : this.keyArg = $initArg('key', key, null),
      this.countArg = $initArg('count', count, IntArg(0))!;

  MultiConstructorWidgetArgs.fixed({Key? key, int count = 0})
    : this.keyArg = key == null ? null : Arg.fixed(key),
      this.countArg = Arg.fixed(count);

  final Arg<Key?>? keyArg;

  final Arg<int> countArg;

  Key? get key => keyArg?.value;

  int get count => countArg.value;

  @override
  List<Arg?> get list => [keyArg, countArg];
}

typedef MultiConstructorWidgetOtherScenario =
    Scenario<MultiConstructorWidget, MultiConstructorWidgetOtherArgs>;
typedef MultiConstructorWidgetOtherDefaults =
    Defaults<MultiConstructorWidget, MultiConstructorWidgetOtherArgs>;

class MultiConstructorWidgetOtherStory
    extends Story<MultiConstructorWidget, MultiConstructorWidgetOtherArgs> {
  MultiConstructorWidgetOtherStory({
    super.name,
    super.setup,
    super.modes,
    MultiConstructorWidgetOtherArgs? args,
    StoryWidgetBuilder<MultiConstructorWidget, MultiConstructorWidgetOtherArgs>?
    builder,
    super.scenarios,
  }) : super(
         args: args ?? MultiConstructorWidgetOtherArgs(),
         builder:
             builder ??
             (context, args) =>
                 MultiConstructorWidget.other(key: args.key, label: args.label),
       );
}

class MultiConstructorWidgetOtherArgs
    extends StoryArgs<MultiConstructorWidget> {
  MultiConstructorWidgetOtherArgs({Arg<Key?>? key, Arg<String>? label})
    : this.keyArg = $initArg('key', key, null),
      this.labelArg = $initArg('label', label, StringArg(''))!;

  MultiConstructorWidgetOtherArgs.fixed({Key? key, String label = ''})
    : this.keyArg = key == null ? null : Arg.fixed(key),
      this.labelArg = Arg.fixed(label);

  final Arg<Key?>? keyArg;

  final Arg<String> labelArg;

  Key? get key => keyArg?.value;

  String get label => labelArg.value;

  @override
  List<Arg?> get list => [keyArg, labelArg];
}
