import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'generic_bound_nullable.stories.g.dart';

/// Tests that nullable type arguments within generic bounds
/// (e.g. <D, T extends Wrapper<D?>>) are preserved in generated code.
const description = 'preserves nullable type arguments on generic bounds';

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

const meta = Meta(NullableBoundWidget.new);

final $Default = _Story<String, BaseItem<String?>>(
  args: _Args(item: Arg.fixed(const BaseItem<String?>(value: null))),
);
