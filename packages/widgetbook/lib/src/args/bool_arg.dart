import '../core/arg.dart';
import '../fields/fields.dart';

class BoolArg extends Arg<bool> {
  const BoolArg(
    super.value, {
    super.name,
  });

  @override
  List<Field> get fields => [
    BooleanField(
      name: 'value',
      initialValue: value,
    ),
  ];

  @override
  bool valueFromQueryGroup(Map<String, String> group) {
    return valueOf('value', group)!;
  }

  @override
  Map<String, String> valueToQueryGroup(bool value) {
    return {'value': paramOf('value', value)};
  }

  @override
  BoolArg init({
    required String name,
  }) {
    return BoolArg(
      value,
      name: $name ?? name,
    );
  }
}
