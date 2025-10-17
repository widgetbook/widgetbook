import '../core/arg.dart';
import '../fields/fields.dart';

class DurationArg extends Arg<Duration> with SingleFieldOnly {
  const DurationArg(
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
