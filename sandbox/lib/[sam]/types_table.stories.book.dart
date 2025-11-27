// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering, unused_element, strict_raw_type

part of 'types_table.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<TypesTable, TypesTableArgs>;
typedef _Scenario = TypesTableScenario;
typedef _Defaults = TypesTableDefaults;
typedef _Story = TypesTableStory;
typedef _Args = TypesTableArgs;
final TypesTableComponent = Component<TypesTable, TypesTableArgs>(
  name: meta.name ?? 'TypesTable',
  path: meta.path ?? '[sam]',
  docs: meta.docs ?? null,
  stories: [$Default..$generatedName = 'Default'],
);
typedef TypesTableScenario = Scenario<TypesTable, TypesTableArgs>;
typedef TypesTableDefaults = Defaults<TypesTable, TypesTableArgs>;

class TypesTableStory extends Story<TypesTable, TypesTableArgs> {
  TypesTableStory({
    super.name,
    super.setup,
    super.modes,
    required super.args,
    StoryWidgetBuilder<TypesTable, TypesTableArgs>? builder,
    super.scenarios,
  }) : super(
         builder:
             builder ??
             (context, args) => TypesTable(
               key: args.key,
               boolean: args.boolean,
               integer: args.integer,
               decimal: args.decimal,
               string: args.string,
               color: args.color,
               duration: args.duration,
               status: args.status,
               dateTime: args.dateTime,
               iterable: args.iterable,
               person: args.person,
               margin: args.margin,
               padding: args.padding,
               child: args.child,
               decoration: args.decoration,
               future: args.future,
               onChanged: args.onChanged,
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
    Arg<DateTime>? dateTime,
    required Arg<Iterable<int>> iterable,
    Arg<Person?>? person,
    Arg<EdgeInsets?>? margin,
    Arg<EdgeInsets?>? padding,
    required Arg<Widget> child,
    Arg<Decoration>? decoration,
    Arg<Future<bool?>?>? future,
    Arg<void Function(bool?)?>? onChanged,
  }) : this.keyArg = $initArg('key', key, null),
       this.booleanArg = $initArg('boolean', boolean, NullableBoolArg(null))!,
       this.integerArg = $initArg('integer', integer, NullableIntArg(1))!,
       this.decimalArg = $initArg('decimal', decimal, NullableDoubleArg(null))!,
       this.stringArg = $initArg('string', string, StringArg(''))!,
       this.colorArg = $initArg('color', color, ColorArg(Colors.red))!,
       this.durationArg = $initArg(
         'duration',
         duration,
         DurationArg(Duration.zero),
       )!,
       this.statusArg = $initArg(
         'status',
         status,
         EnumArg<Status>(Status.none, values: Status.values),
       )!,
       this.dateTimeArg = $initArg(
         'dateTime',
         dateTime,
         DateTimeArg(DateTime.now()),
       )!,
       this.iterableArg = $initArg('iterable', iterable, null)!,
       this.personArg = $initArg('person', person, null),
       this.marginArg = $initArg(
         'margin',
         margin,
         ConstArg(const EdgeInsets.all(16)),
       )!,
       this.paddingArg = $initArg('padding', padding, null),
       this.childArg = $initArg('child', child, null)!,
       this.decorationArg = $initArg(
         'decoration',
         decoration,
         ConstArg(const BoxDecoration()),
       )!,
       this.futureArg = $initArg('future', future, null),
       this.onChangedArg = $initArg('onChanged', onChanged, null);

  TypesTableArgs.fixed({
    Key? key,
    bool? boolean = null,
    int? integer = 1,
    double? decimal = null,
    String string = '',
    Color color = Colors.red,
    Duration duration = Duration.zero,
    Status status = Status.none,
    DateTime? dateTime,
    required Iterable<int> iterable,
    Person? person,
    EdgeInsets? margin = const EdgeInsets.all(16),
    EdgeInsets? padding,
    required Widget child,
    Decoration decoration = const BoxDecoration(),
    Future<bool?>? future,
    void Function(bool?)? onChanged,
  }) : this.keyArg = key == null ? null : Arg.fixed(key),
       this.booleanArg = boolean == null ? null : Arg.fixed(boolean),
       this.integerArg = integer == null ? null : Arg.fixed(integer),
       this.decimalArg = decimal == null ? null : Arg.fixed(decimal),
       this.stringArg = Arg.fixed(string),
       this.colorArg = Arg.fixed(color),
       this.durationArg = Arg.fixed(duration),
       this.statusArg = Arg.fixed(status),
       this.dateTimeArg = Arg.fixed(dateTime ?? DateTime.now()),
       this.iterableArg = Arg.fixed(iterable),
       this.personArg = person == null ? null : Arg.fixed(person),
       this.marginArg = margin == null ? null : Arg.fixed(margin),
       this.paddingArg = padding == null ? null : Arg.fixed(padding),
       this.childArg = Arg.fixed(child),
       this.decorationArg = Arg.fixed(decoration),
       this.futureArg = future == null ? null : Arg.fixed(future),
       this.onChangedArg = onChanged == null ? null : Arg.fixed(onChanged);

  final Arg<Key?>? keyArg;

  final Arg<bool?>? booleanArg;

  final Arg<int?>? integerArg;

  final Arg<double?>? decimalArg;

  final Arg<String> stringArg;

  final Arg<Color> colorArg;

  final Arg<Duration> durationArg;

  final Arg<Status> statusArg;

  final Arg<DateTime> dateTimeArg;

  final Arg<Iterable<int>> iterableArg;

  final Arg<Person?>? personArg;

  final Arg<EdgeInsets?>? marginArg;

  final Arg<EdgeInsets?>? paddingArg;

  final Arg<Widget> childArg;

  final Arg<Decoration> decorationArg;

  final Arg<Future<bool?>?>? futureArg;

  final Arg<void Function(bool?)?>? onChangedArg;

  Key? get key => keyArg?.value;

  bool? get boolean => booleanArg?.value;

  int? get integer => integerArg?.value;

  double? get decimal => decimalArg?.value;

  String get string => stringArg.value;

  Color get color => colorArg.value;

  Duration get duration => durationArg.value;

  Status get status => statusArg.value;

  DateTime get dateTime => dateTimeArg.value;

  Iterable<int> get iterable => iterableArg.value;

  Person? get person => personArg?.value;

  EdgeInsets? get margin => marginArg?.value;

  EdgeInsets? get padding => paddingArg?.value;

  Widget get child => childArg.value;

  Decoration get decoration => decorationArg.value;

  Future<bool?>? get future => futureArg?.value;

  void Function(bool?)? get onChanged => onChangedArg?.value;

  @override
  List<Arg?> get list => [
    keyArg,
    booleanArg,
    integerArg,
    decimalArg,
    stringArg,
    colorArg,
    durationArg,
    statusArg,
    dateTimeArg,
    iterableArg,
    personArg,
    marginArg,
    paddingArg,
    childArg,
    decorationArg,
    futureArg,
    onChangedArg,
  ];
}
