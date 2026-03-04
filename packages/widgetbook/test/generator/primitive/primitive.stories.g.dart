// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'primitive.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<PrimitiveWidget, PrimitiveWidgetArgs>;
typedef _Scenario = PrimitiveWidgetScenario;
typedef _Defaults = PrimitiveWidgetDefaults;
typedef _Story = PrimitiveWidgetStory;
typedef _Args = PrimitiveWidgetArgs;
final PrimitiveWidgetComponent =
    Component<PrimitiveWidget, PrimitiveWidgetArgs>(
      name: meta.name ?? 'PrimitiveWidget',
      path: meta.path ?? '',
      docsBuilder: meta.docsBuilder,
      docComment: null,
      stories: [$Default..$generatedName = 'Default'],
    );
typedef PrimitiveWidgetScenario =
    Scenario<PrimitiveWidget, PrimitiveWidgetArgs>;
typedef PrimitiveWidgetDefaults =
    Defaults<PrimitiveWidget, PrimitiveWidgetArgs>;

class PrimitiveWidgetStory extends Story<PrimitiveWidget, PrimitiveWidgetArgs> {
  PrimitiveWidgetStory({
    super.name,
    super.setup,
    super.modes,
    PrimitiveWidgetArgs? args,
    StoryWidgetBuilder<PrimitiveWidget, PrimitiveWidgetArgs>? builder,
    super.scenarios,
  }) : super(
         args: args ?? PrimitiveWidgetArgs(),
         builder:
             builder ??
             (context, args) => PrimitiveWidget(
               key: args.key,
               label: args.label,
               count: args.count,
               isActive: args.isActive,
             ),
       );
}

class PrimitiveWidgetArgs extends StoryArgs<PrimitiveWidget> {
  PrimitiveWidgetArgs({
    Arg<Key?>? key,
    Arg<String>? label,
    Arg<int>? count,
    Arg<bool>? isActive,
  }) : this.keyArg = $initArg('key', key, null),
       this.labelArg = $initArg('label', label, StringArg(''))!,
       this.countArg = $initArg('count', count, IntArg(0))!,
       this.isActiveArg = $initArg('isActive', isActive, BoolArg(false))!;

  PrimitiveWidgetArgs.fixed({
    Key? key,
    String label = '',
    int count = 0,
    bool isActive = false,
  }) : this.keyArg = key == null ? null : Arg.fixed(key),
       this.labelArg = Arg.fixed(label),
       this.countArg = Arg.fixed(count),
       this.isActiveArg = Arg.fixed(isActive);

  final Arg<Key?>? keyArg;

  final Arg<String> labelArg;

  final Arg<int> countArg;

  final Arg<bool> isActiveArg;

  Key? get key => keyArg?.value;

  String get label => labelArg.value;

  int get count => countArg.value;

  bool get isActive => isActiveArg.value;

  @override
  List<Arg?> get list => [keyArg, labelArg, countArg, isActiveArg];
}
