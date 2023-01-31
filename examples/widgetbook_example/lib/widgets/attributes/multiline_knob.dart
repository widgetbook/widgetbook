import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class MultiLineKnob extends StatelessWidget {
  const MultiLineKnob({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(context.knobs.text(
      label: 'MultiLine',
      maxLines: null,
      initialValue: '''// Headers
for (var level = 1; level <= 6; level++)
  AppHeaderBlot(
    level: level,
    child: defaultText,
  ),''',
    ));
  }
}
