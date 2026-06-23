import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'generic_bound.stories.g.dart';

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
