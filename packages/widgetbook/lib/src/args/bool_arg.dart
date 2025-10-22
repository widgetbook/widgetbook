import '../core/arg.dart';
import '../fields/fields.dart';

class BoolArg extends Arg<bool> with SingleFieldOnly {
  BoolArg(
    super.value, {
    super.name,
  });

  @override
  Field<bool> get field {
    return BooleanField(
      name: 'value',
      initialValue: value,
    );
  }
}

class NullableBoolArg extends Arg<bool?> with SingleFieldOnly {
  NullableBoolArg(
    super.value, {
    super.name,
  });

  @override
  Field<bool> get field {
    return BooleanField(
      name: 'value',
      initialValue: value ?? false,
    );
  }
}
