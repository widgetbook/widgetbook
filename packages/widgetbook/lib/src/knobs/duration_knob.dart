import 'package:meta/meta.dart';

import '../fields/fields.dart';
import 'knob.dart';

@internal
class DurationKnob extends Knob<Duration?> {
  DurationKnob({
    required super.label,
    required super.initialValue,
    this.units = DurationUnit.defaults,
    super.description,
  });

  DurationKnob.nullable({
    required super.label,
    required super.initialValue,
    super.description,
    super.defaultToNull,
    this.units = DurationUnit.defaults,
  }) : super(isNullable: true);

  /// The time units displayed as separate inputs, rendered from largest to
  /// smallest. Defaults to [DurationUnit.defaults] (hours, minutes, seconds).
  final Set<DurationUnit> units;

  @override
  List<Field> get fields {
    return [
      DurationField(
        name: label,
        initialValue: initialValue,
        units: units,
      ),
    ];
  }

  @override
  Duration? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group);
  }
}
