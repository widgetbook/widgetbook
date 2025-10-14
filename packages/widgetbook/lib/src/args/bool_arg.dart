import '../core/arg.dart';
import '../fields/fields.dart';
import '../routing/routing.dart';

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
  bool valueFromQueryGroup(QueryGroup group) {
    return valueOf('value', group)!;
  }

  @override
  QueryGroup valueToQueryGroup(bool value) {
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
