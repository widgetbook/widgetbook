import 'package:meta/meta.dart';

import '../fields/fields.dart';
import 'knob.dart';

@internal
class IntInputKnob extends Knob<int?> {
  IntInputKnob({
    required super.label,
    required super.initialValue,
    super.description,
  });

  IntInputKnob.nullable({
    required super.label,
    required super.initialValue,
    super.description,
  }) : super(isNullable: true);

  @override
  List<Field> get fields {
    return [
      IntInputField(
        name: label,
        initialValue: initialValue,
      ),
    ];
  }

  @override
  int? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group);
  }
}
