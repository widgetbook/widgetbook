import 'package:flutter/material.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(
  name: 'Default',
  type: ExpanderIcon,
  cloudKnobsConfigs: {
    'Large Expanded': [
      KnobConfig('is-expanded', true),
      KnobConfig('size', 84.0),
    ],
    'Small Collapsed': [
      KnobConfig('is-expanded', false),
      KnobConfig('size', 12.0),
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
