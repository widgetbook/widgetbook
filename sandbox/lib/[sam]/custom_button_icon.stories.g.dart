// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering, unused_element, strict_raw_type

part of 'custom_button_icon.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<CustomButton, CustomButtonArgs>;
typedef _Scenario = CustomButtonScenario;
typedef _Defaults = CustomButtonDefaults;
typedef _Story = CustomButtonStory;
typedef _Args = CustomButtonArgs;
final CustomButtonIconComponent = Component<CustomButton, CustomButtonArgs>(
  name: meta.name ?? 'CustomButton.icon',
  path: meta.path ?? '[sam]',
  docsBuilder: meta.docsBuilder,
  docComment: null,
  stories: [
    $Default..$generatedName = 'Default',
    $Search..$generatedName = 'Search',
  ],
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
             (context, args) => CustomButton.icon(
               key: args.key,
               icon: args.icon,
               label: args.label,
               onPressed: args.onPressed,
             ),
       );
}

class CustomButtonArgs extends StoryArgs<CustomButton> {
  CustomButtonArgs({
    Arg<Key?>? key,
    Arg<IconData?>? icon,
    Arg<String>? label,
    Arg<void Function()?>? onPressed,
  }) : this.keyArg = $initArg('key', key, null),
       this.iconArg = $initArg('icon', icon, null),
       this.labelArg = $initArg('label', label, StringArg(''))!,
       this.onPressedArg = $initArg('onPressed', onPressed, null);

  CustomButtonArgs.fixed({
    Key? key,
    IconData? icon,
    String label = '',
    void Function()? onPressed,
  }) : this.keyArg = key == null ? null : Arg.fixed(key),
       this.iconArg = icon == null ? null : Arg.fixed(icon),
       this.labelArg = Arg.fixed(label),
       this.onPressedArg = onPressed == null ? null : Arg.fixed(onPressed);

  final Arg<Key?>? keyArg;

  final Arg<IconData?>? iconArg;

  final Arg<String> labelArg;

  final Arg<void Function()?>? onPressedArg;

  Key? get key => keyArg?.value;

  IconData? get icon => iconArg?.value;

  String get label => labelArg.value;

  void Function()? get onPressed => onPressedArg?.value;

  @override
  List<Arg?> get list => [keyArg, iconArg, labelArg, onPressedArg];
}
