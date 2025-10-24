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
    ArgsBuilder<GenericText<T>, GenericTextArgs<T>>? argsBuilder,
    super.scenarios,
  }) : super(
         argsBuilder:
             argsBuilder ??
             (context, args) => GenericText<T>(
               key: args.key?.resolve(context),
               value: args.value.resolve(context),
             ),
       );
}

class GenericTextArgs<T> extends StoryArgs<GenericText<T>> {
  GenericTextArgs({Arg<Key?>? key, required Arg<T> value})
    : this.key = $initArg('key', key, null),
      this.value = $initArg('value', value, null)!;

  GenericTextArgs.fixed({Key? key, required T value})
    : this.key = key == null ? null : Arg.fixed(key),
      this.value = Arg.fixed(value);

  final Arg<Key?>? key;

  final Arg<T> value;

  @override
  List<Arg?> get list => [key, value];
}
