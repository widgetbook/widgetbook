// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_constructor.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component =
    Component<MultiConstructorWidget, MultiConstructorWidgetArgs>;
typedef _Scenario = MultiConstructorWidgetScenario;
typedef _Defaults = MultiConstructorWidgetDefaults;
typedef _Story = MultiConstructorWidgetStory;
typedef _Args = MultiConstructorWidgetArgs;
final MultiConstructorWidgetComponent =
    Component<MultiConstructorWidget, MultiConstructorWidgetArgs>(
      name: meta.name ?? 'MultiConstructorWidget',
      path: meta.path ?? '',
      docsBuilder: meta.docsBuilder,
      docComment: null,
      stories: [$Default..$generatedName = 'Default'],
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
