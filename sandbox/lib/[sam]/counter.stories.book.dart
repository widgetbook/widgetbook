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
               key: args.key?.resolve(context),
               initialValue: args.initialValue.resolve(context),
             ),
       );
}

class CounterArgs extends StoryArgs<Counter> {
  CounterArgs({Arg<Key?>? key, Arg<int>? initialValue})
    : this.key = $initArg('key', key, null),
      this.initialValue = $initArg('initialValue', initialValue, IntArg(0))!;

  CounterArgs.fixed({Key? key, int initialValue = 0})
    : this.key = key == null ? null : Arg.fixed(key),
      this.initialValue = Arg.fixed(initialValue);

  final Arg<Key?>? key;

  final Arg<int> initialValue;

  @override
  List<Arg?> get list => [key, initialValue];
}
