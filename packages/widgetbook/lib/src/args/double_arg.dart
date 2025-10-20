import '../core/arg.dart';
import '../fields/fields.dart';

class DoubleArg extends Arg<double> with SingleFieldOnly {
  const DoubleArg(
    super.value, {
    super.name,
  });

  @override
  Field<double> get field {
    return DoubleInputField(
      name: 'value',
      initialValue: value,
    );
  }

  @override
  DoubleArg init({
    required String name,
  }) {
    return DoubleArg(
      value,
      name: $name ?? name,
    );
  }
}

class NullableDoubleArg extends Arg<double?> with SingleFieldOnly {
  const NullableDoubleArg(
    super.value, {
    super.name,
  });

  @override
  Field<double> get field {
    return DoubleInputField(
      name: 'value',
      initialValue: value ?? 0.0,
    );
  }

  @override
  NullableDoubleArg init({
    required String name,
  }) {
    return NullableDoubleArg(
      value,
      name: $name ?? name,
    );
  }
}
