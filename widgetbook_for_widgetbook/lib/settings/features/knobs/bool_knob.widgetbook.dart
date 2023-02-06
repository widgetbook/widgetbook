import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

@WidgetbookUseCase(name: 'Default', type: BoolKnob)
Widget boolKnob(BuildContext context) {
  return const BoolKnob(
    name: 'Is enabled',
    description: 'This is a description.',
    value: true,
  );
}

@WidgetbookUseCase(name: 'Default', type: NullableBoolKnob)
Widget nullableBoolKnob(BuildContext context) {
  return const NullableBoolKnob(
    name: 'Is enabled',
    description: 'This is a description.',
    value: true,
  );
}
