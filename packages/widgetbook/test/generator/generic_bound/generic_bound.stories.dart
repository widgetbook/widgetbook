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

// ignore: strict_raw_type
const meta = Meta<BoundWidget>();

final $Default = Object();
