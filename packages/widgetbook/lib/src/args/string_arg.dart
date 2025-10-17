import '../core/arg.dart';
import '../fields/fields.dart';

class StringArg extends Arg<String> with SingleFieldOnly {
  const StringArg(
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
