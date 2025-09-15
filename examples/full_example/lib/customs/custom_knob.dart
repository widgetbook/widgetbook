/// A custom knob example for Widgetbook
///
/// [Ref link]: https://docs.widgetbook.io/knobs/custom-knob
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@widgetbook.UseCase(
  name: 'CustomRangeSlider',
  type: RangeSlider,
  cloudKnobsConfigs: {
    'same range': [
      MultiFieldKnobConfig({
        'range.min': 5,
        'range.max': 5,
      }),
    ],
    'small range': [
      MultiFieldKnobConfig({
        'range.min': 4,
        'range.max': 6,
      }),
    ],
  },
)
Widget rangeSlider(BuildContext context) {
  return RangeSlider(
    values: context.knobs.range(label: 'range'),
    max: 10,
    min: 1,
    onChanged: (_) {},
  );
}

class RangeKnob extends Knob<RangeValues> {
  RangeKnob({
    required super.label,
    required super.initialValue,
  });

  @override
  List<Field> get fields => [
    DoubleInputField(
      name: '$label.min',
      initialValue: initialValue.start,
    ),
    DoubleInputField(
      name: '$label.max',
      initialValue: initialValue.end,
    ),
  ];

  @override
  RangeValues valueFromQueryGroup(Map<String, String> group) {
    return RangeValues(
      valueOf('$label.min', group)!,
      valueOf('$label.max', group)!,
    );
  }
}

extension RangeKnobBuilder on KnobsBuilder {
  RangeValues range({
    required String label,
    RangeValues initialValue = const RangeValues(1, 10),
  }) => onKnobAdded(
    RangeKnob(
      label: label,
      initialValue: initialValue,
    ),
  )!;
}
