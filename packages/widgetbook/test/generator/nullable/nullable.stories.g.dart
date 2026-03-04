// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nullable.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<NullableWidget, NullableWidgetArgs>;
typedef _Scenario = NullableWidgetScenario;
typedef _Defaults = NullableWidgetDefaults;
typedef _Story = NullableWidgetStory;
typedef _Args = NullableWidgetArgs;
final NullableWidgetComponent = Component<NullableWidget, NullableWidgetArgs>(
  name: meta.name ?? 'NullableWidget',
  path: meta.path ?? '',
  docsBuilder: meta.docsBuilder,
  docComment: null,
  stories: [$Default..$generatedName = 'Default'],
);
typedef NullableWidgetScenario = Scenario<NullableWidget, NullableWidgetArgs>;
typedef NullableWidgetDefaults = Defaults<NullableWidget, NullableWidgetArgs>;

class NullableWidgetStory extends Story<NullableWidget, NullableWidgetArgs> {
  NullableWidgetStory({
    super.name,
    super.setup,
    super.modes,
    NullableWidgetArgs? args,
    StoryWidgetBuilder<NullableWidget, NullableWidgetArgs>? builder,
    super.scenarios,
  }) : super(
         args: args ?? NullableWidgetArgs(),
         builder:
             builder ??
             (context, args) => NullableWidget(
               key: args.key,
               label: args.label,
               count: args.count,
             ),
       );
}

class NullableWidgetArgs extends StoryArgs<NullableWidget> {
  NullableWidgetArgs({Arg<Key?>? key, Arg<String?>? label, Arg<int?>? count})
    : this.keyArg = $initArg('key', key, null),
      this.labelArg = $initArg('label', label, NullableStringArg(null))!,
      this.countArg = $initArg('count', count, NullableIntArg(null))!;

  NullableWidgetArgs.fixed({Key? key, String? label = null, int? count = null})
    : this.keyArg = key == null ? null : Arg.fixed(key),
      this.labelArg = label == null ? null : Arg.fixed(label),
      this.countArg = count == null ? null : Arg.fixed(count);

  final Arg<Key?>? keyArg;

  final Arg<String?>? labelArg;

  final Arg<int?>? countArg;

  Key? get key => keyArg?.value;

  String? get label => labelArg?.value;

  int? get count => countArg?.value;

  @override
  List<Arg?> get list => [keyArg, labelArg, countArg];
}
