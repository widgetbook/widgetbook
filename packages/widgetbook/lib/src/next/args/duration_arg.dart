import '../../fields/fields.dart';
import 'arg.dart';

class DurationArg extends Arg<Duration> {
  const DurationArg({
    super.name,
    super.value = Duration.zero,
  });

  @override
  List<Field> get fields => [
        DurationField(
          name: name,
          initialValue: value,
        ),
      ];

  @override
  Duration valueFromQueryGroup(Map<String, String> group) {
    return valueOf(name, group)!;
  }

  @override
  DurationArg init({
    required String name,
  }) {
    return DurationArg(
      name: name,
      value: value,
    );
  }
}
