import '../core/arg.dart';
import '../fields/fields.dart';

class DurationArg extends Arg<Duration> {
  const DurationArg(
    super.value, {
    super.name,
  });

  @override
  List<Field> get fields => [
    DurationField(
      name: 'value',
      initialValue: value,
    ),
  ];

  @override
  Duration valueFromQueryGroup(Map<String, String> group) {
    return valueOf('value', group)!;
  }

  @override
  Map<String, String> valueToQueryGroup(Duration value) {
    return {'value': paramOf('value', value)};
  }

  @override
  DurationArg init({
    required String name,
  }) {
    return DurationArg(
      value,
      name: $name ?? name,
    );
  }
}
