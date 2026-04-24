// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering, unused_element, strict_raw_type

part of 'custom_button.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<CustomButton, CustomButtonArgs>;
typedef _Scenario = CustomButtonScenario;
typedef _Defaults = CustomButtonDefaults;
typedef _Story = CustomButtonStory;
typedef _Args = CustomButtonArgs;
final CustomButtonComponent = Component<CustomButton, CustomButtonArgs>(
  name: meta.name ?? 'CustomButton',
  path: meta.path ?? '[sam]',
  docsBuilder: meta.docsBuilder,
  docComment: null,
  stories: [$Default..$generatedName = 'Default'],
);
typedef CustomButtonScenario = Scenario<CustomButton, CustomButtonArgs>;
typedef CustomButtonDefaults = Defaults<CustomButton, CustomButtonArgs>;

class CustomButtonStory extends Story<CustomButton, CustomButtonArgs> {
  CustomButtonStory({
    super.name,
    super.setup,
    super.modes,
    CustomButtonArgs? args,
    StoryWidgetBuilder<CustomButton, CustomButtonArgs>? builder,
    super.scenarios,
  }) : super(
         args: args ?? CustomButtonArgs(),
         builder:
             builder ??
             (context, args) => CustomButton(
               key: args.key,
               label: args.label,
               onPressed: args.onPressed,
             ),
       );
}

class CustomButtonArgs extends StoryArgs<CustomButton> {
  CustomButtonArgs({
    Arg<Key?>? key,
    Arg<String>? label,
    Arg<void Function()?>? onPressed,
  }) : this.keyArg = $initArg('key', key, null),
       this.labelArg = $initArg('label', label, StringArg(''))!,
       this.onPressedArg = $initArg('onPressed', onPressed, null);

  CustomButtonArgs.fixed({
    Key? key,
    String label = '',
    void Function()? onPressed,
  }) : this.keyArg = key == null ? null : Arg.fixed(key),
       this.labelArg = Arg.fixed(label),
       this.onPressedArg = onPressed == null ? null : Arg.fixed(onPressed);

  final Arg<Key?>? keyArg;

  final Arg<String> labelArg;

  final Arg<void Function()?>? onPressedArg;

  Key? get key => keyArg?.value;

  String get label => labelArg.value;

  void Function()? get onPressed => onPressedArg?.value;

  @override
  List<Arg?> get list => [keyArg, labelArg, onPressedArg];
}
