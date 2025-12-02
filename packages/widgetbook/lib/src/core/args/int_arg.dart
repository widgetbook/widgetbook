import '../fields/fields.dart';
import '../framework/arg.dart';

class IntArg extends Arg<int> with SingleFieldOnly {
  IntArg(
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
}

class NullableIntArg extends Arg<int?> with SingleFieldOnly {
  NullableIntArg(
    super.value, {
    super.name,
  });

  @override
  Field<int> get field {
    return IntInputField(
      name: 'value',
      initialValue: value ?? 0,
    );
  }
}
