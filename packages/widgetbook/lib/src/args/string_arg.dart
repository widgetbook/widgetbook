import '../core/arg.dart';
import '../fields/fields.dart';
import '../routing/routing.dart';

class StringArg extends Arg<String> {
  const StringArg(
    super.value, {
    super.name,
  });

  @override
  List<Field> get fields => [
    StringField(
      name: 'value',
      initialValue: value,
    ),
  ];

  @override
  String valueFromQueryGroup(QueryGroup group) {
    return valueOf('value', group)!;
  }

  @override
  QueryGroup valueToQueryGroup(String value) {
    return {'value': paramOf('value', value)};
  }

  @override
  StringArg init({
    required String name,
  }) {
    return StringArg(
      value,
      name: $name ?? name,
    );
  }
}
