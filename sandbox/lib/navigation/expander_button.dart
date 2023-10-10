import 'package:flutter/material.dart';
import 'package:widgetbook/src/navigation/navigation.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'ExpanderIcon', type: ExpanderIcon)
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
