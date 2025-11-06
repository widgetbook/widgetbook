// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering, unused_element, strict_raw_type

part of 'nullable_setting.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<NullableSetting, NullableSettingArgs>;
typedef _Scenario = NullableSettingScenario;
typedef _Story = NullableSettingStory;
typedef _Args = NullableSettingArgs;
final NullableSettingComponent =
    Component<NullableSetting, NullableSettingArgs>(
      name: meta.name ?? 'NullableSetting',
      path: meta.path ?? 'settings',
      docs: meta.docs,
      stories: [$Default..$generatedName = 'Default'],
    );
typedef NullableSettingScenario =
    Scenario<NullableSetting, NullableSettingArgs>;

class NullableSettingStory extends Story<NullableSetting, NullableSettingArgs> {
  NullableSettingStory({
    super.name,
    super.setup,
    super.modes,
    required super.args,
    StoryWidgetBuilder<NullableSetting, NullableSettingArgs>? builder,
    super.scenarios,
  }) : super(
         builder:
             builder ??
             (context, args) => NullableSetting(
               key: args.key,
               name: args.name,
               description: args.description,
               child: args.child,
               isNullified: args.isNullified,
               onNullified: args.onNullified,
             ),
       );
}

class NullableSettingArgs extends StoryArgs<NullableSetting> {
  NullableSettingArgs({
    Arg<Key?>? key,
    Arg<String>? name,
    Arg<String?>? description,
    required Arg<Widget> child,
    Arg<bool>? isNullified,
    Arg<void Function(bool)?>? onNullified,
  }) : this.keyArg = $initArg('key', key, null),
       this.nameArg = $initArg('name', name, StringArg(''))!,
       this.descriptionArg = $initArg(
         'description',
         description,
         NullableStringArg(null),
       )!,
       this.childArg = $initArg('child', child, null)!,
       this.isNullifiedArg = $initArg(
         'isNullified',
         isNullified,
         BoolArg(false),
       )!,
       this.onNullifiedArg = $initArg('onNullified', onNullified, null);

  NullableSettingArgs.fixed({
    Key? key,
    String name = '',
    String? description = null,
    required Widget child,
    bool isNullified = false,
    void Function(bool)? onNullified,
  }) : this.keyArg = key == null ? null : Arg.fixed(key),
       this.nameArg = Arg.fixed(name),
       this.descriptionArg = description == null
           ? null
           : Arg.fixed(description),
       this.childArg = Arg.fixed(child),
       this.isNullifiedArg = Arg.fixed(isNullified),
       this.onNullifiedArg = onNullified == null
           ? null
           : Arg.fixed(onNullified);

  final Arg<Key?>? keyArg;

  final Arg<String> nameArg;

  final Arg<String?>? descriptionArg;

  final Arg<Widget> childArg;

  final Arg<bool> isNullifiedArg;

  final Arg<void Function(bool)?>? onNullifiedArg;

  Key? get key => keyArg?.value;

  String get name => nameArg.value;

  String? get description => descriptionArg?.value;

  Widget get child => childArg.value;

  bool get isNullified => isNullifiedArg.value;

  void Function(bool)? get onNullified => onNullifiedArg?.value;

  @override
  List<Arg?> get list => [
    keyArg,
    nameArg,
    descriptionArg,
    childArg,
    isNullifiedArg,
    onNullifiedArg,
  ];
}
