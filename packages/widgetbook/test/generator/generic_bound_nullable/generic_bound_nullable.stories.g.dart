// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_bound_nullable.stories.dart';

// **************************************************************************
// StoryGenerator
// **************************************************************************

typedef _Component = Component<NullableBoundWidget, NullableBoundWidgetArgs>;
typedef _Scenario<D, T extends Wrapper<D?>> = NullableBoundWidgetScenario<D, T>;
typedef _Defaults = NullableBoundWidgetDefaults;
typedef _Story<D, T extends Wrapper<D?>> = NullableBoundWidgetStory<D, T>;
typedef _Args<D, T extends Wrapper<D?>> = NullableBoundWidgetArgs<D, T>;
final NullableBoundWidgetComponent =
    Component<NullableBoundWidget, NullableBoundWidgetArgs>(
      name: meta.name ?? 'NullableBoundWidget',
      path: meta.path ?? '',
      docsBuilder: meta.docsBuilder,
      docComment: null,
      stories: [$Default..$generatedName = 'Default'],
    );
typedef NullableBoundWidgetScenario<D, T extends Wrapper<D?>> =
    Scenario<NullableBoundWidget<D, T>, NullableBoundWidgetArgs<D, T>>;
typedef NullableBoundWidgetDefaults =
    Defaults<NullableBoundWidget, NullableBoundWidgetArgs>;

class NullableBoundWidgetStory<D, T extends Wrapper<D?>>
    extends Story<NullableBoundWidget<D, T>, NullableBoundWidgetArgs<D, T>> {
  NullableBoundWidgetStory({
    super.name,
    super.setup,
    super.modes,
    required super.args,
    StoryWidgetBuilder<
      NullableBoundWidget<D, T>,
      NullableBoundWidgetArgs<D, T>
    >?
    builder,
    super.scenarios,
  }) : super(
         builder:
             builder ??
             (context, args) =>
                 NullableBoundWidget<D, T>(key: args.key, item: args.item),
       );
}

class NullableBoundWidgetArgs<D, T extends Wrapper<D?>>
    extends StoryArgs<NullableBoundWidget<D, T>> {
  NullableBoundWidgetArgs({Arg<Key?>? key, required Arg<T> item})
    : this.keyArg = $initArg('key', key, null),
      this.itemArg = $initArg('item', item, null)!;

  NullableBoundWidgetArgs.fixed({Key? key, required T item})
    : this.keyArg = key == null ? null : Arg.fixed(key),
      this.itemArg = Arg.fixed(item);

  final Arg<Key?>? keyArg;

  final Arg<T> itemArg;

  Key? get key => keyArg?.value;

  T get item => itemArg.value;

  @override
  List<Arg?> get list => [keyArg, itemArg];
}
