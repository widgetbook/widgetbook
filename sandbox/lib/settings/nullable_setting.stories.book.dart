// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

part of 'nullable_setting.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

// ignore: strict_raw_type
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
    ArgsBuilder<NullableSetting, NullableSettingArgs>? argsBuilder,
    super.scenarios,
  }) : super(
         argsBuilder:
             argsBuilder ??
             (context, args) => NullableSetting(
               key: args.key?.resolve(context),
               name: args.name.resolve(context),
               description: args.description?.resolve(context),
               child: args.child.resolve(context),
               isNullified: args.isNullified.resolve(context),
               onNullified: args.onNullified?.resolve(context),
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
  }) : this.key = $initArg('key', key, null),
       this.name = $initArg('name', name, StringArg(''))!,
       this.description = $initArg(
         'description',
         description,
         NullableStringArg(null),
       )!,
       this.child = $initArg('child', child, null)!,
       this.isNullified = $initArg('isNullified', isNullified, BoolArg(false))!,
       this.onNullified = $initArg('onNullified', onNullified, null);

  NullableSettingArgs.fixed({
    Key? key,
    String name = '',
    String? description = null,
    required Widget child,
    bool isNullified = false,
    void Function(bool)? onNullified,
  }) : this.key = key == null ? null : Arg.fixed(key),
       this.name = Arg.fixed(name),
       this.description = description == null ? null : Arg.fixed(description),
       this.child = Arg.fixed(child),
       this.isNullified = Arg.fixed(isNullified),
       this.onNullified = onNullified == null ? null : Arg.fixed(onNullified);

  final Arg<Key?>? key;

  final Arg<String> name;

  final Arg<String?>? description;

  final Arg<Widget> child;

  final Arg<bool> isNullified;

  final Arg<void Function(bool)?>? onNullified;

  @override
  List<Arg?> get list => [
    key,
    name,
    description,
    child,
    isNullified,
    onNullified,
  ];
}
