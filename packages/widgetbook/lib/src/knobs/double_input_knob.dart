import 'package:meta/meta.dart';

import '../fields/fields.dart';
import 'knob.dart';

@internal
class DoubleInputKnob extends Knob<double?> {
  DoubleInputKnob({
    required super.label,
    required super.initialValue,
    super.description,
  });

  DoubleInputKnob.nullable({
    required super.label,
    required super.initialValue,
    super.description,
  }) : super(isNullable: true);

  @override
  List<Field> get fields {
    return [
      DoubleInputField(
        name: label,
        initialValue: initialValue,
      ),
    ];
  }

  @override
  double? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group);
  }
}
