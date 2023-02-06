import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

@WidgetbookUseCase(name: 'Default', type: ColorKnob)
Widget colorKnob(BuildContext context) {
  return const ColorKnob(
    name: 'Color',
    description: 'This is a description.',
    value: Colors.green,
  );
}
