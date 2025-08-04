/// A custom knob example for Widgetbook
///
/// [Ref link]: https://docs.widgetbook.io/knobs/custom-knob
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'CustomRangeSlider', type: RangeSlider)
Widget rangeSlider(BuildContext context) {
  return RangeSlider(
    values: context.knobs.range(label: 'Range'),
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
      name: 'min-$label',
      initialValue: initialValue.start,
    ),
    DoubleInputField(
      name: 'max-$label',
      initialValue: initialValue.end,
    ),
  ];

  @override
  RangeValues valueFromQueryGroup(Map<String, String> group) {
    return RangeValues(
      valueOf('min-$label', group)!,
      valueOf('max-$label', group)!,
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
