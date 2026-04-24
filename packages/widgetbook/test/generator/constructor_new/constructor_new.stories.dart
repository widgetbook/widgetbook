import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'constructor_new.stories.g.dart';

class ConstructorNewWidget extends StatelessWidget {
  const ConstructorNewWidget({
    super.key,
    required this.count,
  }) : label = '';

  const ConstructorNewWidget.other({
    super.key,
    required this.label,
  }) : count = 0;

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) => Text('$count');
}

const meta = Meta<ConstructorNewWidget>(
  constructor: ConstructorNewWidget.new,
);

final $Default = Object();
