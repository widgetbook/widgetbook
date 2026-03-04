// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static_methods.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<StaticMethodWidget, StaticMethodWidgetArgs>;
typedef _Scenario = StaticMethodWidgetScenario;
typedef _Defaults = StaticMethodWidgetDefaults;
typedef _Story = StaticMethodWidgetStory;
typedef _Args = StaticMethodWidgetArgs;
final StaticMethodWidgetComponent =
    Component<StaticMethodWidget, StaticMethodWidgetArgs>(
      name: meta.name ?? 'StaticMethodWidget',
      path: meta.path ?? '',
      docsBuilder: meta.docsBuilder,
      docComment: null,
      stories: [$Default..$generatedName = 'Default'],
    );
typedef StaticMethodWidgetScenario =
    Scenario<StaticMethodWidget, StaticMethodWidgetArgs>;
typedef StaticMethodWidgetDefaults =
    Defaults<StaticMethodWidget, StaticMethodWidgetArgs>;

class StaticMethodWidgetStory
    extends Story<StaticMethodWidget, StaticMethodWidgetArgs> {
  StaticMethodWidgetStory({
    super.name,
    super.setup,
    super.modes,
    StaticMethodWidgetArgs? args,
    StoryWidgetBuilder<StaticMethodWidget, StaticMethodWidgetArgs>? builder,
    super.scenarios,
  }) : super(
         args: args ?? StaticMethodWidgetArgs(),
         builder:
             builder ??
             (context, args) =>
                 StaticMethodWidget(key: args.key, builder: args.builder),
       );
}

class StaticMethodWidgetArgs extends StoryArgs<StaticMethodWidget> {
  StaticMethodWidgetArgs({
    Arg<Key?>? key,
    Arg<Widget Function(BuildContext)>? builder,
  }) : this.keyArg = $initArg('key', key, null),
       this.builderArg = $initArg(
         'builder',
         builder,
         ConstArg(StaticMethodWidget._defaultBuilder),
       )!;

  StaticMethodWidgetArgs.fixed({
    Key? key,
    Widget Function(BuildContext) builder = StaticMethodWidget._defaultBuilder,
  }) : this.keyArg = key == null ? null : Arg.fixed(key),
       this.builderArg = Arg.fixed(builder);

  final Arg<Key?>? keyArg;

  final Arg<Widget Function(BuildContext)> builderArg;

  Key? get key => keyArg?.value;

  Widget Function(BuildContext) get builder => builderArg.value;

  @override
  List<Arg?> get list => [keyArg, builderArg];
}
