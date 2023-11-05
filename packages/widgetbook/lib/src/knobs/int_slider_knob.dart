import 'package:meta/meta.dart';

import '../fields/fields.dart';
import 'knob.dart';

@internal
class IntSliderKnob extends Knob<int?> {
  IntSliderKnob({
    required super.label,
    required super.initialValue,
    super.description,
    this.max = 1,
    this.min = 0,
    this.divisions,
  });

  IntSliderKnob.nullable({
    required super.label,
    required super.initialValue,
    super.description,
    this.max = 1,
    this.min = 0,
    this.divisions,
  }) : super(isNullable: true);

  final int max;
  final int min;
  final int? divisions;

  @override
  List<Field> get fields {
    return [
      IntSliderField(
        name: label,
        initialValue: initialValue,
        min: min,
        max: max,
        divisions: divisions,
      ),
    ];
  }

  @override
  int? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group);
  }
}
