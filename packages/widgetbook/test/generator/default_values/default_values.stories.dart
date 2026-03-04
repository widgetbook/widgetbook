import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'default_values.stories.g.dart';

class DefaultsWidget extends StatelessWidget {
  const DefaultsWidget({
    super.key,
    this.label = 'hello',
    this.count = 42,
    this.ratio = 3.14,
    this.isEnabled = true,
  });

  final String label;
  final int count;
  final double ratio;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) => Text(label);
}

final meta = Meta<DefaultsWidget>();

final $Default = Object();
