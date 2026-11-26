import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'generic_bound.stories.g.dart';

/// Tests that generic type parameter bounds with type arguments
/// (e.g. <D, T extends BaseItem<D>>) are preserved in generated code.
const description = 'preserves type arguments on generic bounds';

class BaseItem<T> {
  const BaseItem({required this.value});
  final T value;
}

class BoundWidget<D, T extends BaseItem<D>> extends StatelessWidget {
  const BoundWidget({super.key, required this.item});

  final T item;

  @override
  Widget build(BuildContext context) => Text(item.value.toString());
}

const meta = Meta(BoundWidget.new);

final $Default = _Story<String, BaseItem<String>>(
  args: _Args(item: Arg.fixed(const BaseItem(value: 'item'))),
);
