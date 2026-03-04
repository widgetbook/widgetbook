import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'generic.stories.g.dart';

class GenericWidget<T extends num> extends StatelessWidget {
  const GenericWidget({super.key, required this.value});

  final T value;

  @override
  Widget build(BuildContext context) => Text(value.toString());
}

// ignore: strict_raw_type
const meta = Meta<GenericWidget>();

final $Default = Object();
