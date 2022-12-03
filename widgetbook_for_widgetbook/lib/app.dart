import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart' show Knobs;
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

@WidgetbookApp.material(name: 'Widgetbook')
const int notUsed = 0;

@WidgetbookTheme(name: 'Dark')
ThemeData theme() => ThemeData.dark();

@WidgetbookUseCase(name: 'Default', type: ExpanderButton)
Widget expanderButton(BuildContext context) {
  return ExpanderButton(
    isExpanded: context.knobs.boolean(label: 'Is expanded'),
    onPressed: () {},
    size: context.knobs.slider(
      label: 'Size',
      min: 12,
      initialValue: 24,
      max: 84,
      divisions: 4,
    ),
  );
}
