// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

part of 'types_table.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

// ignore: strict_raw_type
final TypesTableComponent = Component<TypesTable, TypesTableArgs>(
  name: meta.name ?? 'TypesTable',
  path: meta.path ?? '[sam]',
  docs: meta.docs,
  stories: [$Default..$generatedName = 'Default'],
);
typedef TypesTableScenario = Scenario<TypesTable, TypesTableArgs>;

class TypesTableStory extends Story<TypesTable, TypesTableArgs> {
  TypesTableStory({
    super.name,
    super.setup,
    super.modes,
    required super.args,
    ArgsBuilder<TypesTable, TypesTableArgs>? argsBuilder,
    super.scenarios,
  }) : super(
         argsBuilder:
             argsBuilder ??
             (context, args) => TypesTable(
               key: args.key?.resolve(context),
               boolean: args.boolean?.resolve(context),
               integer: args.integer?.resolve(context),
               decimal: args.decimal?.resolve(context),
               string: args.string.resolve(context),
               color: args.color.resolve(context),
               duration: args.duration.resolve(context),
               status: args.status.resolve(context),
               person: args.person?.resolve(context),
               margin: args.margin?.resolve(context),
               padding: args.padding?.resolve(context),
               child: args.child.resolve(context),
               decoration: args.decoration.resolve(context),
               future: args.future?.resolve(context),
               onChanged: args.onChanged?.resolve(context),
             ),
       );
}

class TypesTableArgs extends StoryArgs<TypesTable> {
  TypesTableArgs({
    Arg<Key?>? key,
    Arg<bool?>? boolean,
    Arg<int?>? integer,
    Arg<double?>? decimal,
    Arg<String>? string,
    Arg<Color>? color,
    Arg<Duration>? duration,
    Arg<Status>? status,
    Arg<Person?>? person,
    Arg<EdgeInsets?>? margin,
    Arg<EdgeInsets?>? padding,
    required Arg<Widget> child,
    Arg<Decoration>? decoration,
    Arg<Future<bool?>?>? future,
    Arg<void Function(bool?)?>? onChanged,
  }) : this.key = $initArg('key', key, null),
       this.boolean = $initArg('boolean', boolean, NullableBoolArg(null))!,
       this.integer = $initArg('integer', integer, NullableIntArg(1))!,
       this.decimal = $initArg('decimal', decimal, NullableDoubleArg(null))!,
       this.string = $initArg('string', string, StringArg(''))!,
       this.color = $initArg('color', color, ColorArg(Colors.red))!,
       this.duration = $initArg(
         'duration',
         duration,
         DurationArg(Duration.zero),
       )!,
       this.status = $initArg(
         'status',
         status,
         EnumArg<Status>(Status.none, values: Status.values),
       )!,
       this.person = $initArg('person', person, null),
       this.margin = $initArg(
         'margin',
         margin,
         ConstArg(const EdgeInsets.all(16)),
       )!,
       this.padding = $initArg('padding', padding, null),
       this.child = $initArg('child', child, null)!,
       this.decoration = $initArg(
         'decoration',
         decoration,
         ConstArg(const BoxDecoration()),
       )!,
       this.future = $initArg('future', future, null),
       this.onChanged = $initArg('onChanged', onChanged, null);

  TypesTableArgs.fixed({
    Key? key,
    bool? boolean = null,
    int? integer = 1,
    double? decimal = null,
    String string = '',
    Color color = Colors.red,
    Duration duration = Duration.zero,
    Status status = Status.none,
    Person? person,
    EdgeInsets? margin = const EdgeInsets.all(16),
    EdgeInsets? padding,
    required Widget child,
    Decoration decoration = const BoxDecoration(),
    Future<bool?>? future,
    void Function(bool?)? onChanged,
  }) : this.key = key == null ? null : Arg.fixed(key),
       this.boolean = boolean == null ? null : Arg.fixed(boolean),
       this.integer = integer == null ? null : Arg.fixed(integer),
       this.decimal = decimal == null ? null : Arg.fixed(decimal),
       this.string = Arg.fixed(string),
       this.color = Arg.fixed(color),
       this.duration = Arg.fixed(duration),
       this.status = Arg.fixed(status),
       this.person = person == null ? null : Arg.fixed(person),
       this.margin = margin == null ? null : Arg.fixed(margin),
       this.padding = padding == null ? null : Arg.fixed(padding),
       this.child = Arg.fixed(child),
       this.decoration = Arg.fixed(decoration),
       this.future = future == null ? null : Arg.fixed(future),
       this.onChanged = onChanged == null ? null : Arg.fixed(onChanged);

  final Arg<Key?>? key;

  final Arg<bool?>? boolean;

  final Arg<int?>? integer;

  final Arg<double?>? decimal;

  final Arg<String> string;

  final Arg<Color> color;

  final Arg<Duration> duration;

  final Arg<Status> status;

  final Arg<Person?>? person;

  final Arg<EdgeInsets?>? margin;

  final Arg<EdgeInsets?>? padding;

  final Arg<Widget> child;

  final Arg<Decoration> decoration;

  final Arg<Future<bool?>?>? future;

  final Arg<void Function(bool?)?>? onChanged;

  @override
  List<Arg?> get list => [
    key,
    boolean,
    integer,
    decimal,
    string,
    color,
    duration,
    status,
    person,
    margin,
    padding,
    child,
    decoration,
    future,
    onChanged,
  ];
}
