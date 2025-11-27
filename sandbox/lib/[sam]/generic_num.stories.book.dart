// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering, unused_element, strict_raw_type

part of 'generic_num.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<GenericNum, GenericNumInputArgs>;
typedef _Scenario<T extends num, R> = GenericNumScenario<T, R>;
typedef _Defaults = GenericNumDefaults;
typedef _Story<T extends num, R> = GenericNumStory<T, R>;
typedef _Args<T extends num, R> = GenericNumInputArgs<T, R>;
final GenericNumComponent = Component<GenericNum, GenericNumInputArgs>(
  name: meta.name ?? 'GenericNum',
  path: meta.path ?? '[sam]',
  docs: meta.docs ?? null,
  stories: [
    $Integer..$generatedName = 'Integer',
    $Double..$generatedName = 'Double',
  ],
);
typedef GenericNumScenario<T extends num, R> =
    Scenario<GenericNum<T>, GenericNumInputArgs<T, R>>;
typedef GenericNumDefaults = Defaults<GenericNum, GenericNumInputArgs>;

class GenericNumStory<T extends num, R>
    extends Story<GenericNum<T>, GenericNumInputArgs<T, R>> {
  GenericNumStory({
    super.name,
    SetupBuilder<GenericNum<T>, GenericNumInputArgs<T, R>>? setup,
    super.modes,
    required super.args,
    StoryWidgetBuilder<GenericNum<T>, GenericNumInputArgs<T, R>>? builder,
    super.scenarios,
  }) : super(
         builder:
             builder ??
             (context, args) {
               return GenericNum(value: args.number);
             },
         setup:
             setup ??
             (context, child, args) {
               return switch (args) {
                 GenericNumInputArgs<num, Color> x => Container(
                   color: x.other,
                   child: child,
                 ),
                 _ => child,
               };
             },
       );
}

class GenericNumInputArgs<T extends num, R> extends StoryArgs<GenericNum<T>> {
  GenericNumInputArgs({required Arg<T> number, required Arg<R> other})
    : this.numberArg = $initArg('number', number, null)!,
      this.otherArg = $initArg('other', other, null)!;

  GenericNumInputArgs.fixed({required T number, required R other})
    : this.numberArg = Arg.fixed(number),
      this.otherArg = Arg.fixed(other);

  final Arg<T> numberArg;

  final Arg<R> otherArg;

  T get number => numberArg.value;

  R get other => otherArg.value;

  @override
  List<Arg?> get list => [numberArg, otherArg];
}
