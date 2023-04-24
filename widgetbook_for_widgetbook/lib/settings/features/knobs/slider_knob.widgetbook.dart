import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

@UseCase(name: 'Default', type: SliderKnob)
Widget sliderKnob(BuildContext context) {
  return const SliderKnob(
    name: 'Is enabled',
    description: 'This is a description.',
    value: 10,
    max: 10,
    divisions: 10,
  );
}

@UseCase(name: 'Default', type: NullableSliderKnob)
Widget nullableSliderKnob(BuildContext context) {
  return const NullableSliderKnob(
    name: 'Is enabled',
    description: 'This is a description.',
    value: 10,
    max: 10,
    divisions: 10,
  );
}
