// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_bound.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<BoundWidget, BoundWidgetArgs>;
typedef _Scenario<D, T extends BaseItem<D>> = BoundWidgetScenario<D, T>;
typedef _Defaults = BoundWidgetDefaults;
typedef _Story<D, T extends BaseItem<D>> = BoundWidgetStory<D, T>;
typedef _Args<D, T extends BaseItem<D>> = BoundWidgetArgs<D, T>;
final BoundWidgetComponent = Component<BoundWidget, BoundWidgetArgs>(
  name: meta.name ?? 'BoundWidget',
  path: meta.path ?? '',
  docsBuilder: meta.docsBuilder,
  docComment: null,
  stories: [$Default..$generatedName = 'Default'],
);
typedef BoundWidgetScenario<D, T extends BaseItem<D>> =
    Scenario<BoundWidget<D, T>, BoundWidgetArgs<D, T>>;
typedef BoundWidgetDefaults = Defaults<BoundWidget, BoundWidgetArgs>;

class BoundWidgetStory<D, T extends BaseItem<D>>
    extends Story<BoundWidget<D, T>, BoundWidgetArgs<D, T>> {
  BoundWidgetStory({
    super.name,
    super.setup,
    super.modes,
    required super.args,
    StoryWidgetBuilder<BoundWidget<D, T>, BoundWidgetArgs<D, T>>? builder,
    super.scenarios,
  }) : super(
         builder:
             builder ??
             (context, args) =>
                 BoundWidget<D, T>(key: args.key, item: args.item),
       );
}

class BoundWidgetArgs<D, T extends BaseItem<D>>
    extends StoryArgs<BoundWidget<D, T>> {
  BoundWidgetArgs({Arg<Key?>? key, required Arg<T> item})
    : this.keyArg = $initArg('key', key, null),
      this.itemArg = $initArg('item', item, null)!;

  BoundWidgetArgs.fixed({Key? key, required T item})
    : this.keyArg = key == null ? null : Arg.fixed(key),
      this.itemArg = Arg.fixed(item);

  final Arg<Key?>? keyArg;

  final Arg<T> itemArg;

  Key? get key => keyArg?.value;

  T get item => itemArg.value;

  @override
  List<Arg?> get list => [keyArg, itemArg];
}
