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
      name: 'value',
      initialValue: value,
    ),
  ];

  @override
  int valueFromQueryGroup(Map<String, String> group) {
    return valueOf('value', group)!;
  }

  @override
  Map<String, String> valueToQueryGroup(int value) {
    return {'value': paramOf('value', value)};
  }

  @override
  IntArg init({
    required String name,
  }) {
    return IntArg(
      value,
      name: $name ?? name,
    );
  }
}
