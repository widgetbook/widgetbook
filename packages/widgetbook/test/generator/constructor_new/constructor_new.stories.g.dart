// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'constructor_new.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<ConstructorNewWidget, ConstructorNewWidgetArgs>;
typedef _Scenario = ConstructorNewWidgetScenario;
typedef _Defaults = ConstructorNewWidgetDefaults;
typedef _Story = ConstructorNewWidgetStory;
typedef _Args = ConstructorNewWidgetArgs;
final ConstructorNewWidgetComponent =
    Component<ConstructorNewWidget, ConstructorNewWidgetArgs>(
      name: meta.name ?? 'ConstructorNewWidget',
      path: meta.path ?? '',
      docsBuilder: meta.docsBuilder,
      docComment: null,
      stories: [$Default..$generatedName = 'Default'],
    );
typedef ConstructorNewWidgetScenario =
    Scenario<ConstructorNewWidget, ConstructorNewWidgetArgs>;
typedef ConstructorNewWidgetDefaults =
    Defaults<ConstructorNewWidget, ConstructorNewWidgetArgs>;

class ConstructorNewWidgetStory
    extends Story<ConstructorNewWidget, ConstructorNewWidgetArgs> {
  ConstructorNewWidgetStory({
    super.name,
    super.setup,
    super.modes,
    ConstructorNewWidgetArgs? args,
    StoryWidgetBuilder<ConstructorNewWidget, ConstructorNewWidgetArgs>? builder,
    super.scenarios,
  }) : super(
         args: args ?? ConstructorNewWidgetArgs(),
         builder:
             builder ??
             (context, args) =>
                 ConstructorNewWidget(key: args.key, count: args.count),
       );
}

class ConstructorNewWidgetArgs extends StoryArgs<ConstructorNewWidget> {
  ConstructorNewWidgetArgs({Arg<Key?>? key, Arg<int>? count})
    : this.keyArg = $initArg('key', key, null),
      this.countArg = $initArg('count', count, IntArg(0))!;

  ConstructorNewWidgetArgs.fixed({Key? key, int count = 0})
    : this.keyArg = key == null ? null : Arg.fixed(key),
      this.countArg = Arg.fixed(count);

  final Arg<Key?>? keyArg;

  final Arg<int> countArg;

  Key? get key => keyArg?.value;

  int get count => countArg.value;

  @override
  List<Arg?> get list => [keyArg, countArg];
}
