import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart' show Knobs;
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

@WidgetbookUseCase(name: 'Default', type: ExpanderIcon)
Widget expanderButton(BuildContext context) {
  return ExpanderIcon(
    isExpanded: context.knobs.boolean(label: 'Is expanded'),
    size: context.knobs.slider(
      label: 'Size',
      min: 12,
      initialValue: 24,
      max: 84,
      divisions: 4,
    ),
  );
}
