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
