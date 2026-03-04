import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'enums.stories.g.dart';

enum Priority { low, medium, high }

class EnumWidget extends StatelessWidget {
  const EnumWidget({
    super.key,
    this.priority = Priority.low,
  });

  final Priority priority;

  @override
  Widget build(BuildContext context) => Text(priority.name);
}

const meta = Meta<EnumWidget>();

final $Default = Object();
