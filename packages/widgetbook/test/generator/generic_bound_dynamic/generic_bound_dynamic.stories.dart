import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'generic_bound_dynamic.stories.g.dart';

class DynamicBoundWidget<D, T extends Map<dynamic, D>> extends StatelessWidget {
  const DynamicBoundWidget({super.key, required this.mapping});

  final T mapping;

  @override
  Widget build(BuildContext context) => Text('$mapping');
}

// ignore: strict_raw_type
const meta = Meta<DynamicBoundWidget>();

final $Default = Object();
