import '../core/arg.dart';
import '../fields/fields.dart';

class StringArg extends Arg<String> {
  const StringArg(
    super.value, {
    super.name,
  });

  @override
  List<Field> get fields => [
        StringField(
          name: name,
          initialValue: value,
        ),
      ];

  @override
  String valueFromQueryGroup(Map<String, String> group) {
    return valueOf(name, group)!;
  }

  @override
  StringArg init({
    required String name,
  }) {
    return StringArg(
      value,
      name: $name == null ? name : $name,
    );
  }
}
