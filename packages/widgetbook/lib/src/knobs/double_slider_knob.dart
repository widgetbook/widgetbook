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
    this.precision = 1,
  });

  DoubleSliderKnob.nullable({
    required super.label,
    required super.initialValue,
    super.description,
    this.max = 1,
    this.min = 0,
    this.divisions,
    this.precision = 1,
  }) : super(isNullable: true);

  final double max;
  final double min;
  final int? divisions;
  final int? precision;

  @override
  List<Field> get fields {
    return [
      DoubleSliderField(
        name: label,
        initialValue: initialValue,
        min: min,
        max: max,
        divisions: divisions,
        precision: precision,
      ),
    ];
  }

  @override
  double? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group);
  }
}
