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
  IntArg init({
    required String name,
  }) {
    return IntArg(
      value,
      name: $name ?? name,
    );
  }
}
