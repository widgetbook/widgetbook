import '../core/arg.dart';
import '../fields/fields.dart';

class DoubleArg extends Arg<double> with SingleFieldOnly {
  DoubleArg(
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
}

class NullableDoubleArg extends Arg<double?> with SingleFieldOnly {
  NullableDoubleArg(
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
}
