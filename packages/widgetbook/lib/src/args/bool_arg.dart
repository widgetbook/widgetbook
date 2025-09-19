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
      name: name,
      initialValue: value,
    ),
  ];

  @override
  bool valueFromQueryGroup(Map<String, String> group) {
    return valueOf(name, group)!;
  }

  @override
  Map<String, String> valueToQueryGroup(bool value) {
    return {name: paramOf(name, value)};
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
