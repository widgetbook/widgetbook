import '../core/arg.dart';
import '../fields/fields.dart';

class IntArg extends Arg<int> with SingleFieldOnly {
  const IntArg(
    super.value, {
    super.name,
  });

  @override
  Field<int> get field {
    return IntInputField(
      name: 'value',
      initialValue: value,
    );
  }

  @override
  IntArg init({
    required String name,
  }) {
    return IntArg(
      value,
      name: $name ?? name,
    );
  }
}
