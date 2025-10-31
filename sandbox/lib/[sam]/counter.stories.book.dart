// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

part of 'counter.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

// ignore: strict_raw_type
final CounterComponent = Component<Counter, CounterArgs>(
  name: meta.name ?? 'Counter',
  path: meta.path ?? '[sam]',
  docs: meta.docs,
  stories: [$Default..$generatedName = 'Default'],
);
typedef CounterScenario = Scenario<Counter, CounterArgs>;

class CounterStory extends Story<Counter, CounterArgs> {
  CounterStory({
    super.name,
    super.setup,
    super.modes,
    CounterArgs? args,
    ArgsBuilder<Counter, CounterArgs>? argsBuilder,
    super.scenarios,
  }) : super(
         args: args ?? CounterArgs(),
         argsBuilder:
             argsBuilder ??
             (context, args) => Counter(
               key: args.key,
               initialValue: args.initialValue,
               onChanged: args.onChanged,
             ),
       );
}

class CounterArgs extends StoryArgs<Counter> {
  CounterArgs({
    Arg<Key?>? key,
    Arg<int>? initialValue,
    Arg<void Function(int)?>? onChanged,
  }) : this.keyArg = $initArg('key', key, null),
       this.initialValueArg = $initArg(
         'initialValue',
         initialValue,
         IntArg(0),
       )!,
       this.onChangedArg = $initArg('onChanged', onChanged, null);

  CounterArgs.fixed({
    Key? key,
    int initialValue = 0,
    void Function(int)? onChanged,
  }) : this.keyArg = key == null ? null : Arg.fixed(key),
       this.initialValueArg = Arg.fixed(initialValue),
       this.onChangedArg = onChanged == null ? null : Arg.fixed(onChanged);

  final Arg<Key?>? keyArg;

  final Arg<int> initialValueArg;

  final Arg<void Function(int)?>? onChangedArg;

  Key? get key => keyArg?.value;

  int get initialValue => initialValueArg.value;

  void Function(int)? get onChanged => onChangedArg?.value;

  @override
  List<Arg?> get list => [keyArg, initialValueArg, onChangedArg];
}
