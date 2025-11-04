// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

part of 'generic_text.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

// ignore: strict_raw_type
final GenericTextComponent = Component<GenericText, GenericTextArgs>(
  name: meta.name ?? 'GenericText',
  path: meta.path ?? '[sam]',
  docs: meta.docs,
  stories: [
    $IntStory..$generatedName = 'IntStory',
    $BoolStory..$generatedName = 'BoolStory',
  ],
);
typedef GenericTextScenario<T> = Scenario<GenericText<T>, GenericTextArgs<T>>;

class GenericTextStory<T> extends Story<GenericText<T>, GenericTextArgs<T>> {
  GenericTextStory({
    super.name,
    super.setup,
    super.modes,
    required super.args,
    StoryWidgetBuilder<GenericText<T>, GenericTextArgs<T>>? builder,
    super.scenarios,
  }) : super(
         builder:
             builder ??
             (context, args) =>
                 GenericText<T>(key: args.key, value: args.value),
       );
}

class GenericTextArgs<T> extends StoryArgs<GenericText<T>> {
  GenericTextArgs({Arg<Key?>? key, required Arg<T> value})
    : this.keyArg = $initArg('key', key, null),
      this.valueArg = $initArg('value', value, null)!;

  GenericTextArgs.fixed({Key? key, required T value})
    : this.keyArg = key == null ? null : Arg.fixed(key),
      this.valueArg = Arg.fixed(value);

  final Arg<Key?>? keyArg;

  final Arg<T> valueArg;

  Key? get key => keyArg?.value;

  T get value => valueArg.value;

  @override
  List<Arg?> get list => [keyArg, valueArg];
}
