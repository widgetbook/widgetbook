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
    min: 0,
    onChanged: (_) {},
  );
}

class RangeKnob extends Knob<RangeValues> {
  RangeKnob({
    required super.label,
    required super.value,
  });

  @override
  List<Field> get fields => [
        DoubleInputField(
          group: 'knobs',
          name: 'min-$label',
          initialValue: value.start,
          onChanged: (context, value) {
            if (value == null) return;

            final state = WidgetbookState.of(context);
            final endValue = (state.knobs[label]!.value as RangeValues).end;

            state.updateKnobValue<RangeValues>(
              label,
              RangeValues(value, endValue),
            );
          },
        ),
        DoubleInputField(
          group: 'knobs',
          name: 'max-$label',
          initialValue: value.end,
          onChanged: (context, value) {
            if (value == null) return;

            final state = WidgetbookState.of(context);
            final startValue = (state.knobs[label]!.value as RangeValues).start;

            state.updateKnobValue<RangeValues>(
              label,
              RangeValues(startValue, value),
            );
          },
        ),
      ];

  @override
  RangeValues valueFromQueryGroup(Map<String, String> group) {
    return RangeValues(
      double.parse(group['min-$label'] ?? '${value.start}'),
      double.parse(group['max-$label'] ?? '${value.end}'),
    );
  }
}

extension RangeKnobBuilder on KnobsBuilder {
  RangeValues range({
    required String label,
    RangeValues initialValue = const RangeValues(0, 10),
  }) =>
      onKnobAdded(
        RangeKnob(
          label: label,
          value: initialValue,
        ),
      )!;
}
