import '../core/arg.dart';
import '../fields/fields.dart';

class IntArg extends Arg<int> {
  const IntArg(
    super.value, {
    super.name,
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
      value,
      name: $name == null ? name : $name,
    );
  }
}
