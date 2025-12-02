import '../fields/fields.dart';
import '../framework/arg.dart';

class DurationArg extends Arg<Duration> with SingleFieldOnly {
  DurationArg(
    super.value, {
    super.name,
  });

  @override
  Field<Duration> get field {
    return DurationField(
      name: 'value',
      initialValue: value,
    );
  }
}

class NullableDurationArg extends Arg<Duration?> with SingleFieldOnly {
  NullableDurationArg(
    super.value, {
    super.name,
  });

  @override
  Field<Duration> get field {
    return DurationField(
      name: 'value',
      initialValue: value ?? DurationField.defaultDuration,
    );
  }
}
