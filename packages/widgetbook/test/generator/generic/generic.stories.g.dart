// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<GenericWidget, GenericWidgetArgs>;
typedef _Scenario<T extends num> = GenericWidgetScenario<T>;
typedef _Defaults = GenericWidgetDefaults;
typedef _Story<T extends num> = GenericWidgetStory<T>;
typedef _Args<T extends num> = GenericWidgetArgs<T>;
final GenericWidgetComponent = Component<GenericWidget, GenericWidgetArgs>(
  name: meta.name ?? 'GenericWidget',
  path: meta.path ?? '',
  docsBuilder: meta.docsBuilder,
  docComment: null,
  stories: [$Default..$generatedName = 'Default'],
);
typedef GenericWidgetScenario<T extends num> =
    Scenario<GenericWidget<T>, GenericWidgetArgs<T>>;
typedef GenericWidgetDefaults = Defaults<GenericWidget, GenericWidgetArgs>;

class GenericWidgetStory<T extends num>
    extends Story<GenericWidget<T>, GenericWidgetArgs<T>> {
  GenericWidgetStory({
    super.name,
    super.setup,
    super.modes,
    required super.args,
    StoryWidgetBuilder<GenericWidget<T>, GenericWidgetArgs<T>>? builder,
    super.scenarios,
  }) : super(
         builder:
             builder ??
             (context, args) =>
                 GenericWidget<T>(key: args.key, value: args.value),
       );
}

class GenericWidgetArgs<T extends num> extends StoryArgs<GenericWidget<T>> {
  GenericWidgetArgs({Arg<Key?>? key, required Arg<T> value})
    : this.keyArg = $initArg('key', key, null),
      this.valueArg = $initArg('value', value, null)!;

  GenericWidgetArgs.fixed({Key? key, required T value})
    : this.keyArg = key == null ? null : Arg.fixed(key),
      this.valueArg = Arg.fixed(value);

  final Arg<Key?>? keyArg;

  final Arg<T> valueArg;

  Key? get key => keyArg?.value;

  T get value => valueArg.value;

  @override
  List<Arg?> get list => [keyArg, valueArg];
}
