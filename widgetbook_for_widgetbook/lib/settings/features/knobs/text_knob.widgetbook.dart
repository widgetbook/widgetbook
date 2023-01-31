import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart' show Knobs;
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

@WidgetbookUseCase(name: 'Default', type: TextKnob)
Widget textKnob(BuildContext context) {
  return TextKnob(
    name: 'Is enabled',
    description: 'This is a description.',
    value: 'This is text',
    maxLines: context.knobs
        .slider(label: 'Max lines', initialValue: 1, max: 10, min: 1)
        .toInt(),
  );
}

@WidgetbookUseCase(name: 'Default', type: NullableTextKnob)
Widget nullableTextKnob(BuildContext context) {
  return NullableTextKnob(
    name: 'Is enabled',
    description: 'This is a description.',
    value: 'This is text',
    maxLines: context.knobs
        .slider(label: 'Max lines', initialValue: 4, max: 10, min: 1)
        .toInt(),
  );
}
