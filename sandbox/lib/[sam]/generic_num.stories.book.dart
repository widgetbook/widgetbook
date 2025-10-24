// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

part of 'generic_num.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

// ignore: strict_raw_type
final GenericNumComponent = Component<GenericNum, GenericNumInputArgs>(
  name: meta.name ?? 'GenericNum',
  path: meta.path ?? '[sam]',
  docs: meta.docs,
  stories: [
    $Integer..$generatedName = 'Integer',
    $Double..$generatedName = 'Double',
  ],
);
typedef GenericNumScenario<T extends num, R> =
    Scenario<GenericNum<T>, GenericNumInputArgs<T, R>>;

class GenericNumStory<T extends num, R>
    extends Story<GenericNum<T>, GenericNumInputArgs<T, R>> {
  GenericNumStory({
    super.name,
    SetupBuilder<GenericNum<T>, GenericNumInputArgs<T, R>>? setup,
    super.modes,
    required super.args,
    ArgsBuilder<GenericNum<T>, GenericNumInputArgs<T, R>>? argsBuilder,
    super.scenarios,
  }) : super(argsBuilder: argsBuilder ?? $argsBuilder, setup: setup ?? $setup);
}

class GenericNumInputArgs<T extends num, R> extends StoryArgs<GenericNum<T>> {
  GenericNumInputArgs({required Arg<T> number, required Arg<R> other})
    : this.number = $initArg('number', number, null)!,
      this.other = $initArg('other', other, null)!;

  GenericNumInputArgs.fixed({required T number, required R other})
    : this.number = Arg.fixed(number),
      this.other = Arg.fixed(other);

  final Arg<T> number;

  final Arg<R> other;

  @override
  List<Arg?> get list => [number, other];
}
