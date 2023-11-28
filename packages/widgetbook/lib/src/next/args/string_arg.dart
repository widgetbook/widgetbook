import '../../fields/fields.dart';
import 'arg.dart';

class StringArg extends Arg<String> {
  const StringArg({
    super.name,
    super.value = '',
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
      name: name,
      value: value,
    );
  }
}
