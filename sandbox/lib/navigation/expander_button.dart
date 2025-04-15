import 'package:flutter/material.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(
  name: 'Default',
  type: ExpanderIcon,
  cloudKnobsConfigs: {
    'Large Expanded': [
      BooleanKnobConfig('is-expanded', true),
      DoubleKnobConfig('size', 84.0),
    ],
    'Small Collapsed': [
      BooleanKnobConfig('is-expanded', false),
      DoubleKnobConfig('size', 12.0),
    ],
  },
)
Widget expanderButton(BuildContext context) {
  return ExpanderIcon(
    isExpanded: context.knobs.boolean(label: 'Is expanded'),
    size: context.knobs.double.slider(
      label: 'Size',
      min: 12,
      initialValue: 24,
      max: 84,
      divisions: 4,
    ),
  );
}
