// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_values.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<DefaultsWidget, DefaultsWidgetArgs>;
typedef _Scenario = DefaultsWidgetScenario;
typedef _Defaults = DefaultsWidgetDefaults;
typedef _Story = DefaultsWidgetStory;
typedef _Args = DefaultsWidgetArgs;
final DefaultsWidgetComponent = Component<DefaultsWidget, DefaultsWidgetArgs>(
  name: meta.name ?? 'DefaultsWidget',
  path: meta.path ?? '',
  docsBuilder: meta.docsBuilder,
  docComment: null,
  stories: [$Default..$generatedName = 'Default'],
);
typedef DefaultsWidgetScenario = Scenario<DefaultsWidget, DefaultsWidgetArgs>;
typedef DefaultsWidgetDefaults = Defaults<DefaultsWidget, DefaultsWidgetArgs>;

class DefaultsWidgetStory extends Story<DefaultsWidget, DefaultsWidgetArgs> {
  DefaultsWidgetStory({
    super.name,
    super.setup,
    super.modes,
    DefaultsWidgetArgs? args,
    StoryWidgetBuilder<DefaultsWidget, DefaultsWidgetArgs>? builder,
    super.scenarios,
  }) : super(
         args: args ?? DefaultsWidgetArgs(),
         builder:
             builder ??
             (context, args) => DefaultsWidget(
               key: args.key,
               label: args.label,
               count: args.count,
               ratio: args.ratio,
               isEnabled: args.isEnabled,
             ),
       );
}

class DefaultsWidgetArgs extends StoryArgs<DefaultsWidget> {
  DefaultsWidgetArgs({
    Arg<Key?>? key,
    Arg<String>? label,
    Arg<int>? count,
    Arg<double>? ratio,
    Arg<bool>? isEnabled,
  }) : this.keyArg = $initArg('key', key, null),
       this.labelArg = $initArg('label', label, StringArg('hello'))!,
       this.countArg = $initArg('count', count, IntArg(42))!,
       this.ratioArg = $initArg('ratio', ratio, DoubleArg(3.14))!,
       this.isEnabledArg = $initArg('isEnabled', isEnabled, BoolArg(true))!;

  DefaultsWidgetArgs.fixed({
    Key? key,
    String label = 'hello',
    int count = 42,
    double ratio = 3.14,
    bool isEnabled = true,
  }) : this.keyArg = key == null ? null : Arg.fixed(key),
       this.labelArg = Arg.fixed(label),
       this.countArg = Arg.fixed(count),
       this.ratioArg = Arg.fixed(ratio),
       this.isEnabledArg = Arg.fixed(isEnabled);

  final Arg<Key?>? keyArg;

  final Arg<String> labelArg;

  final Arg<int> countArg;

  final Arg<double> ratioArg;

  final Arg<bool> isEnabledArg;

  Key? get key => keyArg?.value;

  String get label => labelArg.value;

  int get count => countArg.value;

  double get ratio => ratioArg.value;

  bool get isEnabled => isEnabledArg.value;

  @override
  List<Arg?> get list => [keyArg, labelArg, countArg, ratioArg, isEnabledArg];
}
