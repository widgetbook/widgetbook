import 'package:meta/meta.dart';

import '../fields/fields.dart';
import 'knob.dart';

@internal
class DurationKnob extends Knob<Duration?> {
  DurationKnob({
    required super.label,
    required super.initialValue,
    super.description,
  });

  DurationKnob.nullable({
    required super.label,
    required super.initialValue,
    super.description,
  }) : super(isNullable: true);

  @override
  List<Field> get fields {
    return [
      DurationField(
        name: label,
        initialValue: initialValue,
      ),
    ];
  }

  @override
  Duration? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group);
  }
}
