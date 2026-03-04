// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<EnumWidget, EnumWidgetArgs>;
typedef _Scenario = EnumWidgetScenario;
typedef _Defaults = EnumWidgetDefaults;
typedef _Story = EnumWidgetStory;
typedef _Args = EnumWidgetArgs;
final EnumWidgetComponent = Component<EnumWidget, EnumWidgetArgs>(
  name: meta.name ?? 'EnumWidget',
  path: meta.path ?? '',
  docsBuilder: meta.docsBuilder,
  docComment: null,
  stories: [$Default..$generatedName = 'Default'],
);
typedef EnumWidgetScenario = Scenario<EnumWidget, EnumWidgetArgs>;
typedef EnumWidgetDefaults = Defaults<EnumWidget, EnumWidgetArgs>;

class EnumWidgetStory extends Story<EnumWidget, EnumWidgetArgs> {
  EnumWidgetStory({
    super.name,
    super.setup,
    super.modes,
    EnumWidgetArgs? args,
    StoryWidgetBuilder<EnumWidget, EnumWidgetArgs>? builder,
    super.scenarios,
  }) : super(
         args: args ?? EnumWidgetArgs(),
         builder:
             builder ??
             (context, args) =>
                 EnumWidget(key: args.key, priority: args.priority),
       );
}

class EnumWidgetArgs extends StoryArgs<EnumWidget> {
  EnumWidgetArgs({Arg<Key?>? key, Arg<Priority>? priority})
    : this.keyArg = $initArg('key', key, null),
      this.priorityArg = $initArg(
        'priority',
        priority,
        EnumArg<Priority>(Priority.low, values: Priority.values),
      )!;

  EnumWidgetArgs.fixed({Key? key, Priority priority = Priority.low})
    : this.keyArg = key == null ? null : Arg.fixed(key),
      this.priorityArg = Arg.fixed(priority);

  final Arg<Key?>? keyArg;

  final Arg<Priority> priorityArg;

  Key? get key => keyArg?.value;

  Priority get priority => priorityArg.value;

  @override
  List<Arg?> get list => [keyArg, priorityArg];
}
