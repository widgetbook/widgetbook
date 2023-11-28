import '../../fields/fields.dart';
import 'arg.dart';

class DoubleArg extends Arg<double> {
  const DoubleArg({
    super.name,
    super.value = 0,
  });

  @override
  List<Field> get fields => [
        DoubleInputField(
          name: name,
          initialValue: value,
        ),
      ];

  @override
  double valueFromQueryGroup(Map<String, String> group) {
    return valueOf(name, group)!;
  }

  @override
  DoubleArg init({
    required String name,
  }) {
    return DoubleArg(
      name: name,
      value: value,
    );
  }
}
