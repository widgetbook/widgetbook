import '../core/arg.dart';
import '../fields/fields.dart';
import '../routing/routing.dart';

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
  int valueFromQueryGroup(QueryGroup group) {
    return valueOf('value', group)!;
  }

  @override
  QueryGroup valueToQueryGroup(int value) {
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
