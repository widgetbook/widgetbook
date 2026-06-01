import 'package:meta/meta.dart';

import '../fields/fields.dart';
import 'knob.dart';

@internal
class DurationKnob extends Knob<Duration?> {
  DurationKnob({
    required super.label,
    required super.initialValue,
    this.enableDays = false,
    this.enableHours = true,
    this.enableMinutes = true,
    this.enableSeconds = true,
    this.enableMilliseconds = false,
    this.enableMicroseconds = false,
    super.description,
  });

  DurationKnob.nullable({
    required super.label,
    required super.initialValue,
    super.description,
    super.defaultToNull,
    this.enableDays = false,
    this.enableHours = true,
    this.enableMinutes = true,
    this.enableSeconds = true,
    this.enableMilliseconds = false,
    this.enableMicroseconds = false,
  }) : super(isNullable: true);

  /// Whether to enable input for days in the duration.
  final bool enableDays;

  /// Whether to enable input for hours in the duration.
  final bool enableHours;

  /// Whether to enable input for minutes in the duration.
  final bool enableMinutes;

  /// Whether to enable input for seconds in the duration.
  final bool enableSeconds;

  /// Whether to enable input for milliseconds in the duration.
  final bool enableMilliseconds;

  /// Whether to enable input for microseconds in the duration.
  final bool enableMicroseconds;

  @override
  List<Field> get fields {
    return [
      DurationField(
        name: label,
        initialValue: initialValue,
        enableDays: enableDays,
        enableHours: enableHours,
        enableMinutes: enableMinutes,
        enableSeconds: enableSeconds,
        enableMilliseconds: enableMilliseconds,
        enableMicroseconds: enableMicroseconds,
      ),
    ];
  }

  @override
  Duration? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group);
  }
}
