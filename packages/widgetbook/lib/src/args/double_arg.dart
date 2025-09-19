import '../core/arg.dart';
import '../fields/fields.dart';

class DoubleArg extends Arg<double> {
  const DoubleArg(
    super.value, {
    super.name,
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
  Map<String, String> valueToQueryGroup(double value) {
    return {name: paramOf(name, value)};
  }

  @override
  DoubleArg init({
    required String name,
  }) {
    return DoubleArg(
      value,
      name: $name ?? name,
    );
  }
}
