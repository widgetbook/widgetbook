// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variants.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<VariantButton, StoryArgs<VariantButton>>;
typedef _Scenario = VariantButtonScenario;
typedef _Defaults = VariantButtonDefaults;
typedef _Story = VariantButtonStory;
typedef _Args = VariantButtonArgs;
typedef _IconScenario = VariantButtonIconScenario;
typedef _IconDefaults = VariantButtonIconDefaults;
typedef _IconStory = VariantButtonIconStory;
typedef _IconArgs = VariantButtonIconArgs;
typedef _OutlinedScenario = VariantButtonOutlinedScenario;
typedef _OutlinedDefaults = VariantButtonOutlinedDefaults;
typedef _OutlinedStory = VariantButtonOutlinedStory;
typedef _OutlinedArgs = VariantButtonOutlinedArgs;
final VariantButtonComponent =
    Component<VariantButton, StoryArgs<VariantButton>>(
      name: component.name ?? 'VariantButton',
      path: component.path ?? '',
      docsBuilder: component.docsBuilder,
      docComment: null,
      stories: [
        $Default..$generatedName = 'Default',
        $Icon..$generatedName = 'Icon',
        $IconLarge..$generatedName = 'IconLarge',
        $Outlined..$generatedName = 'Outlined',
      ],
    );
typedef VariantButtonScenario = Scenario<VariantButton, VariantButtonArgs>;
typedef VariantButtonDefaults = Defaults<VariantButton, VariantButtonArgs>;

class VariantButtonStory extends Story<VariantButton, VariantButtonArgs> {
  VariantButtonStory({
    super.name,
    super.setup,
    super.modes,
    VariantButtonArgs? args,
    StoryWidgetBuilder<VariantButton, VariantButtonArgs>? builder,
    super.scenarios,
  }) : super(
         args: args ?? VariantButtonArgs(),
         builder: builder ?? defaults.builder!,
       );
}

class VariantButtonArgs extends StoryArgs<VariantButton> {
  VariantButtonArgs({Arg<Key?>? key, Arg<String>? label})
    : this.keyArg = $initArg('key', key, null),
      this.labelArg = $initArg('label', label, StringArg(''))!;

  VariantButtonArgs.fixed({Key? key, String label = ''})
    : this.keyArg = key == null ? null : Arg.fixed(key),
      this.labelArg = Arg.fixed(label);

  final Arg<Key?>? keyArg;

  final Arg<String> labelArg;

  Key? get key => keyArg?.value;

  String get label => labelArg.value;

  @override
  List<Arg?> get list => [keyArg, labelArg];
}

typedef VariantButtonIconScenario =
    Scenario<VariantButton, VariantButtonIconArgs>;
typedef VariantButtonIconDefaults =
    Defaults<VariantButton, VariantButtonIconArgs>;

class VariantButtonIconStory
    extends Story<VariantButton, VariantButtonIconArgs> {
  VariantButtonIconStory({
    super.name,
    SetupBuilder<VariantButton, VariantButtonIconArgs>? setup,
    super.modes,
    VariantButtonIconArgs? args,
    StoryWidgetBuilder<VariantButton, VariantButtonIconArgs>? builder,
    super.scenarios,
  }) : super(
         args: args ?? VariantButtonIconArgs(),
         builder:
             builder ??
             (context, args) => VariantButton.icon(
               key: args.key,
               icon: args.icon,
               size: args.size,
             ),
         setup: setup ?? customIconDefaults.setup!,
       );
}

class VariantButtonIconArgs extends StoryArgs<VariantButton> {
  VariantButtonIconArgs({
    Arg<Key?>? key,
    Arg<IconData?>? icon,
    Arg<double>? size,
  }) : this.keyArg = $initArg('key', key, null),
       this.iconArg = $initArg('icon', icon, null),
       this.sizeArg = $initArg('size', size, DoubleArg(24))!;

  VariantButtonIconArgs.fixed({Key? key, IconData? icon, double size = 24})
    : this.keyArg = key == null ? null : Arg.fixed(key),
      this.iconArg = icon == null ? null : Arg.fixed(icon),
      this.sizeArg = Arg.fixed(size);

  final Arg<Key?>? keyArg;

  final Arg<IconData?>? iconArg;

  final Arg<double> sizeArg;

  Key? get key => keyArg?.value;

  IconData? get icon => iconArg?.value;

  double get size => sizeArg.value;

  @override
  List<Arg?> get list => [keyArg, iconArg, sizeArg];
}

typedef VariantButtonOutlinedScenario =
    Scenario<VariantButton, VariantButtonOutlinedArgs>;
typedef VariantButtonOutlinedDefaults =
    Defaults<VariantButton, VariantButtonOutlinedArgs>;

class VariantButtonOutlinedStory
    extends Story<VariantButton, VariantButtonOutlinedArgs> {
  VariantButtonOutlinedStory({
    super.name,
    super.setup,
    super.modes,
    VariantButtonOutlinedArgs? args,
    StoryWidgetBuilder<VariantButton, VariantButtonOutlinedArgs>? builder,
    super.scenarios,
  }) : super(
         args: args ?? VariantButtonOutlinedArgs(),
         builder: builder ?? outlinedDefaults.builder!,
       );
}

class VariantButtonOutlinedArgs extends StoryArgs<VariantButton> {
  VariantButtonOutlinedArgs({Arg<Key?>? key, Arg<String>? label})
    : this.keyArg = $initArg('key', key, null),
      this.labelArg = $initArg('label', label, StringArg(''))!;

  VariantButtonOutlinedArgs.fixed({Key? key, String label = ''})
    : this.keyArg = key == null ? null : Arg.fixed(key),
      this.labelArg = Arg.fixed(label);

  final Arg<Key?>? keyArg;

  final Arg<String> labelArg;

  Key? get key => keyArg?.value;

  String get label => labelArg.value;

  @override
  List<Arg?> get list => [keyArg, labelArg];
}
