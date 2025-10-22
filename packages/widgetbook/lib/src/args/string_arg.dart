import '../core/arg.dart';
import '../fields/fields.dart';

class StringArg extends Arg<String> with SingleFieldOnly {
  StringArg(
    super.value, {
    super.name,
  });

  @override
  Field<String> get field {
    return StringField(
      name: 'value',
      initialValue: value,
    );
  }

  @override
  StringArg init({
    required String name,
  }) {
    return StringArg(
      value,
      name: $name ?? name,
    );
  }
}

class NullableStringArg extends Arg<String?> with SingleFieldOnly {
  NullableStringArg(
    super.value, {
    super.name,
  });

  @override
  Field<String> get field {
    return StringField(
      name: 'value',
      initialValue: value ?? '',
    );
  }

  @override
  NullableStringArg init({
    required String name,
  }) {
    return NullableStringArg(
      value,
      name: $name ?? name,
    );
  }
}
