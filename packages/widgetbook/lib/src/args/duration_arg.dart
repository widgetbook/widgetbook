import '../core/arg.dart';
import '../fields/fields.dart';

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

  @override
  DurationArg init({
    required String name,
  }) {
    return DurationArg(
      value,
      name: $name ?? name,
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

  @override
  NullableDurationArg init({
    required String name,
  }) {
    return NullableDurationArg(
      value,
      name: $name ?? name,
    );
  }
}
