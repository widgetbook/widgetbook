import '../fields/fields.dart';
import '../framework/arg.dart';

class DurationArg extends Arg<Duration> with SingleFieldOnly {
  DurationArg(
    super.value, {
    super.name,
    this.units = DurationUnit.defaults,
  });

  /// The time units displayed as separate inputs, rendered from largest to
  /// smallest. Defaults to [DurationUnit.defaults].
  final Set<DurationUnit> units;

  @override
  Field<Duration> get field {
    return DurationField(
      name: 'value',
      initialValue: value,
      units: units,
    );
  }
}

class NullableDurationArg extends Arg<Duration?> with SingleFieldOnly {
  NullableDurationArg(
    super.value, {
    super.name,
    this.units = DurationUnit.defaults,
  });

  /// The time units displayed as separate inputs, rendered from largest to
  /// smallest. Defaults to [DurationUnit.defaults].
  final Set<DurationUnit> units;

  @override
  Field<Duration> get field {
    return DurationField(
      name: 'value',
      initialValue: value ?? DurationField.defaultDuration,
      units: units,
    );
  }
}
