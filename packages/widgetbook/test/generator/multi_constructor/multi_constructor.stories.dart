import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'multi_constructor.stories.g.dart';

class MultiConstructorWidget extends StatelessWidget {
  const MultiConstructorWidget.other({
    super.key,
    required this.label,
  }) : count = 0;

  const MultiConstructorWidget({
    super.key,
    required this.count,
  }) : label = '';

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) => Text('$count');
}

const meta = Meta<MultiConstructorWidget>();

final $Default = Object();
