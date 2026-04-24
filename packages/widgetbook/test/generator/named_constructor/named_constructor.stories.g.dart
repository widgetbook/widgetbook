// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'named_constructor.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component =
    Component<NamedConstructorWidget, NamedConstructorWidgetArgs>;
typedef _Scenario = NamedConstructorWidgetScenario;
typedef _Defaults = NamedConstructorWidgetDefaults;
typedef _Story = NamedConstructorWidgetStory;
typedef _Args = NamedConstructorWidgetArgs;
final NamedConstructorWidgetOtherComponent =
    Component<NamedConstructorWidget, NamedConstructorWidgetArgs>(
      name: meta.name ?? 'NamedConstructorWidget.other',
      path: meta.path ?? '',
      docsBuilder: meta.docsBuilder,
      docComment: null,
      stories: [$Default..$generatedName = 'Default'],
    );
typedef NamedConstructorWidgetScenario =
    Scenario<NamedConstructorWidget, NamedConstructorWidgetArgs>;
typedef NamedConstructorWidgetDefaults =
    Defaults<NamedConstructorWidget, NamedConstructorWidgetArgs>;

class NamedConstructorWidgetStory
    extends Story<NamedConstructorWidget, NamedConstructorWidgetArgs> {
  NamedConstructorWidgetStory({
    super.name,
    super.setup,
    super.modes,
    NamedConstructorWidgetArgs? args,
    StoryWidgetBuilder<NamedConstructorWidget, NamedConstructorWidgetArgs>?
    builder,
    super.scenarios,
  }) : super(
         args: args ?? NamedConstructorWidgetArgs(),
         builder:
             builder ??
             (context, args) =>
                 NamedConstructorWidget.other(key: args.key, label: args.label),
       );
}

class NamedConstructorWidgetArgs extends StoryArgs<NamedConstructorWidget> {
  NamedConstructorWidgetArgs({Arg<Key?>? key, Arg<String>? label})
    : this.keyArg = $initArg('key', key, null),
      this.labelArg = $initArg('label', label, StringArg(''))!;

  NamedConstructorWidgetArgs.fixed({Key? key, String label = ''})
    : this.keyArg = key == null ? null : Arg.fixed(key),
      this.labelArg = Arg.fixed(label);

  final Arg<Key?>? keyArg;

  final Arg<String> labelArg;

  Key? get key => keyArg?.value;

  String get label => labelArg.value;

  @override
  List<Arg?> get list => [keyArg, labelArg];
}
