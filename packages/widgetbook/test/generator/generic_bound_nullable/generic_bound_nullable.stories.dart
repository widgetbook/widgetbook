import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'generic_bound_nullable.stories.g.dart';

class BaseItem<T> {
  const BaseItem({required this.value});
  final T value;
}

class NullableBoundWidget<D, T extends BaseItem<D?>> extends StatelessWidget {
  const NullableBoundWidget({super.key, required this.item});

  final T item;

  @override
  Widget build(BuildContext context) => Text('${item.value}');
}

// ignore: strict_raw_type
const meta = Meta<NullableBoundWidget>();

final $Default = Object();
