import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'primitive.stories.g.dart';

class PrimitiveWidget extends StatelessWidget {
  const PrimitiveWidget({
    super.key,
    required this.label,
    required this.count,
    required this.isActive,
  });

  final String label;
  final int count;
  final bool isActive;

  @override
  Widget build(BuildContext context) => Text(label);
}

final meta = Meta<PrimitiveWidget>();

final $Default = Object();
