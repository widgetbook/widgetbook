import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'multi_meta.stories.g.dart';

class MultiMetaWidget extends StatelessWidget {
  const MultiMetaWidget({
    super.key,
    required this.label,
  }) : count = 0;

  const MultiMetaWidget.counter({
    super.key,
    required this.count,
  }) : label = '';

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) => Text(label);
}

const meta = Meta<MultiMetaWidget>();
const counterMeta = Meta<MultiMetaWidget>(
  constructor: MultiMetaWidget.counter,
);

final $Default = Object();
final $FiveCounts = Object();
