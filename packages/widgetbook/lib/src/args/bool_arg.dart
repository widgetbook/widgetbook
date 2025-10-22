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

  @override
  BoolArg init({
    required String name,
  }) {
    return BoolArg(
      value,
      name: $name ?? name,
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

  @override
  NullableBoolArg init({
    required String name,
  }) {
    return NullableBoolArg(
      value,
      name: $name ?? name,
    );
  }
}
