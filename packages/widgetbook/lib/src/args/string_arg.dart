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
}
