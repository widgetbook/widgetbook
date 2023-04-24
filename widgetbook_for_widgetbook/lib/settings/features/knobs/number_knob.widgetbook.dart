import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

@UseCase(name: 'Default', type: NumberKnob)
Widget numberKnob(BuildContext context) {
  return const NumberKnob(
    name: 'Is enabled',
    description: 'This is a description.',
    value: 10,
  );
}

@UseCase(name: 'Default', type: NullableNumberKnob)
Widget nullableNumberKniob(BuildContext context) {
  return const NullableNumberKnob(
    name: 'Is enabled',
    description: 'This is a description.',
    value: 10,
  );
}
