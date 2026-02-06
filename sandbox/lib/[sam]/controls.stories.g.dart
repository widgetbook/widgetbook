// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering, unused_element, strict_raw_type

part of 'controls.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<Controls, ControlsArgs>;
typedef _Scenario = ControlsScenario;
typedef _Defaults = ControlsDefaults;
typedef _Story = ControlsStory;
typedef _Args = ControlsArgs;
final ControlsComponent = Component<Controls, ControlsArgs>(
  name: meta.name ?? 'Controls',
  path: meta.path ?? '[sam]',
  docsBuilder: meta.docsBuilder,
  docComment: null,
  stories: [$Default..$generatedName = 'Default'],
);
typedef ControlsScenario = Scenario<Controls, ControlsArgs>;
typedef ControlsDefaults = Defaults<Controls, ControlsArgs>;

class ControlsStory extends Story<Controls, ControlsArgs> {
  ControlsStory({
    super.name,
    super.setup,
    super.modes,
    required super.args,
    StoryWidgetBuilder<Controls, ControlsArgs>? builder,
    super.scenarios,
  }) : super(
         builder:
             builder ??
             (context, args) => Controls(
               key: args.key,
               control1Label: args.control1Label,
               onControl1Pressed: args.onControl1Pressed,
               control2Label: args.control2Label,
               onControl2Pressed: args.onControl2Pressed,
             ),
       );
}

class ControlsArgs extends StoryArgs<Controls> {
  ControlsArgs({
    Arg<Key?>? key,
    Arg<String>? control1Label,
    required Arg<void Function()> onControl1Pressed,
    Arg<String>? control2Label,
    required Arg<void Function()> onControl2Pressed,
  }) : this.keyArg = $initArg('key', key, null),
       this.control1LabelArg = $initArg(
         'control1Label',
         control1Label,
         StringArg(''),
       )!,
       this.onControl1PressedArg = $initArg(
         'onControl1Pressed',
         onControl1Pressed,
         null,
       )!,
       this.control2LabelArg = $initArg(
         'control2Label',
         control2Label,
         StringArg(''),
       )!,
       this.onControl2PressedArg = $initArg(
         'onControl2Pressed',
         onControl2Pressed,
         null,
       )!;

  ControlsArgs.fixed({
    Key? key,
    String control1Label = '',
    required void Function() onControl1Pressed,
    String control2Label = '',
    required void Function() onControl2Pressed,
  }) : this.keyArg = key == null ? null : Arg.fixed(key),
       this.control1LabelArg = Arg.fixed(control1Label),
       this.onControl1PressedArg = Arg.fixed(onControl1Pressed),
       this.control2LabelArg = Arg.fixed(control2Label),
       this.onControl2PressedArg = Arg.fixed(onControl2Pressed);

  final Arg<Key?>? keyArg;

  final Arg<String> control1LabelArg;

  final Arg<void Function()> onControl1PressedArg;

  final Arg<String> control2LabelArg;

  final Arg<void Function()> onControl2PressedArg;

  Key? get key => keyArg?.value;

  String get control1Label => control1LabelArg.value;

  void Function() get onControl1Pressed => onControl1PressedArg.value;

  String get control2Label => control2LabelArg.value;

  void Function() get onControl2Pressed => onControl2PressedArg.value;

  @override
  List<Arg?> get list => [
    keyArg,
    control1LabelArg,
    onControl1PressedArg,
    control2LabelArg,
    onControl2PressedArg,
  ];
}
