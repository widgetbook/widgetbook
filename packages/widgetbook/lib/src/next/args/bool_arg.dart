import '../../fields/fields.dart';
import 'arg.dart';

class BoolArg extends Arg<bool> {
  const BoolArg({
    super.name,
    super.value = false,
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
  BoolArg init({
    required String name,
  }) {
    return BoolArg(
      name: name,
      value: value,
    );
  }
}
