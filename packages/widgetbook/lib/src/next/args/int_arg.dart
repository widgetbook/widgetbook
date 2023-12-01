import '../../fields/fields.dart';
import 'arg.dart';

class IntArg extends Arg<int> {
  const IntArg({
    super.name,
    super.value = 0,
  });

  @override
  List<Field> get fields => [
        IntInputField(
          name: name,
          initialValue: value,
        ),
      ];

  @override
  int valueFromQueryGroup(Map<String, String> group) {
    return valueOf(name, group)!;
  }

  @override
  IntArg init({
    required String name,
  }) {
    return IntArg(
      name: name,
      value: value,
    );
  }
}
