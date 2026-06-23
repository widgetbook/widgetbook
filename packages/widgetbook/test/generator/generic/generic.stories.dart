import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

part 'generic.stories.g.dart';

class GenericWidget<T extends num> extends StatelessWidget {
  const GenericWidget({super.key, required this.value});

  final T value;

  @override
  Widget build(BuildContext context) => Text(value.toString());
}

const meta = Meta(GenericWidget.new);

final $Default = _Story<int>(args: _Args(value: IntArg(1)));
