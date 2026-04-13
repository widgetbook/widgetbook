// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_bound_dynamic.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<DynamicBoundWidget, DynamicBoundWidgetArgs>;
typedef _Scenario<D, T extends Map<dynamic, D>> =
    DynamicBoundWidgetScenario<D, T>;
typedef _Defaults = DynamicBoundWidgetDefaults;
typedef _Story<D, T extends Map<dynamic, D>> = DynamicBoundWidgetStory<D, T>;
typedef _Args<D, T extends Map<dynamic, D>> = DynamicBoundWidgetArgs<D, T>;
final DynamicBoundWidgetComponent =
    Component<DynamicBoundWidget, DynamicBoundWidgetArgs>(
      name: meta.name ?? 'DynamicBoundWidget',
      path: meta.path ?? '',
      docsBuilder: meta.docsBuilder,
      docComment: null,
      stories: [$Default..$generatedName = 'Default'],
    );
typedef DynamicBoundWidgetScenario<D, T extends Map<dynamic, D>> =
    Scenario<DynamicBoundWidget<D, T>, DynamicBoundWidgetArgs<D, T>>;
typedef DynamicBoundWidgetDefaults =
    Defaults<DynamicBoundWidget, DynamicBoundWidgetArgs>;

class DynamicBoundWidgetStory<D, T extends Map<dynamic, D>>
    extends Story<DynamicBoundWidget<D, T>, DynamicBoundWidgetArgs<D, T>> {
  DynamicBoundWidgetStory({
    super.name,
    super.setup,
    super.modes,
    required super.args,
    StoryWidgetBuilder<DynamicBoundWidget<D, T>, DynamicBoundWidgetArgs<D, T>>?
    builder,
    super.scenarios,
  }) : super(
         builder:
             builder ??
             (context, args) =>
                 DynamicBoundWidget<D, T>(key: args.key, mapping: args.mapping),
       );
}

class DynamicBoundWidgetArgs<D, T extends Map<dynamic, D>>
    extends StoryArgs<DynamicBoundWidget<D, T>> {
  DynamicBoundWidgetArgs({Arg<Key?>? key, required Arg<T> mapping})
    : this.keyArg = $initArg('key', key, null),
      this.mappingArg = $initArg('mapping', mapping, null)!;

  DynamicBoundWidgetArgs.fixed({Key? key, required T mapping})
    : this.keyArg = key == null ? null : Arg.fixed(key),
      this.mappingArg = Arg.fixed(mapping);

  final Arg<Key?>? keyArg;

  final Arg<T> mappingArg;

  Key? get key => keyArg?.value;

  T get mapping => mappingArg.value;

  @override
  List<Arg?> get list => [keyArg, mappingArg];
}
