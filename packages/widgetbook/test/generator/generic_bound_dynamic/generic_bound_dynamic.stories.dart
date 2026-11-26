import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'generic_bound_dynamic.stories.g.dart';

/// Tests that dynamic type arguments within generic bounds
/// (e.g. <D, T extends Map<dynamic, D>>) are preserved in generated code.
const description = 'preserves dynamic type arguments on generic bounds';

class DynamicBoundWidget<D, T extends Map<dynamic, D>> extends StatelessWidget {
  const DynamicBoundWidget({super.key, required this.mapping});

  final T mapping;

  @override
  Widget build(BuildContext context) => Text('$mapping');
}

const meta = Meta(DynamicBoundWidget.new);

final $Default = _Story<int, Map<dynamic, int>>(
  args: _Args(mapping: Arg.fixed(const <dynamic, int>{'value': 1})),
);
