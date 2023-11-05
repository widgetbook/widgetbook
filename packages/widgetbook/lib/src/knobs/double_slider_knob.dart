import 'package:meta/meta.dart';

import '../fields/fields.dart';
import 'knob.dart';

@internal
class DoubleSliderKnob extends Knob<double?> {
  DoubleSliderKnob({
    required super.label,
    required super.initialValue,
    super.description,
    this.max = 1,
    this.min = 0,
    this.divisions,
  });

  DoubleSliderKnob.nullable({
    required super.label,
    required super.initialValue,
    super.description,
    this.max = 1,
    this.min = 0,
    this.divisions,
  }) : super(isNullable: true);

  final double max;
  final double min;
  final int? divisions;

  @override
  List<Field> get fields {
    return [
      DoubleSliderField(
        name: label,
        initialValue: initialValue,
        min: min,
        max: max,
        divisions: divisions,
      ),
    ];
  }

  @override
  double? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group);
  }
}
