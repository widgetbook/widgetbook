import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'named_constructor.stories.g.dart';

class NamedConstructorWidget extends StatelessWidget {
  const NamedConstructorWidget({
    super.key,
    required this.count,
  }) : label = '';

  const NamedConstructorWidget.other({
    super.key,
    required this.label,
  }) : count = 0;

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) => Text(label);
}

const meta = Meta<NamedConstructorWidget>(
  constructor: NamedConstructorWidget.other,
);

final $Default = Object();
