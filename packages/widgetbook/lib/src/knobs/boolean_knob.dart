import 'package:meta/meta.dart';

import '../fields/fields.dart';
import 'knob.dart';

@internal
class BooleanKnob extends Knob<bool?> {
  BooleanKnob({
    required super.label,
    required super.initialValue,
    super.description,
  });

  BooleanKnob.nullable({
    required super.label,
    required super.initialValue,
    super.description,
  }) : super(isNullable: true);

  @override
  List<Field> get fields {
    return [
      BooleanField(
        name: label,
        initialValue: initialValue,
      ),
    ];
  }

  @override
  bool? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group);
  }
}
