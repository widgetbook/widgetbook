import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'nullable.stories.g.dart';

class NullableWidget extends StatelessWidget {
  const NullableWidget({
    super.key,
    this.label,
    this.count,
  });

  final String? label;
  final int? count;

  @override
  Widget build(BuildContext context) => Text(label ?? '');
}

final meta = Meta<NullableWidget>();

final $Default = Object();
