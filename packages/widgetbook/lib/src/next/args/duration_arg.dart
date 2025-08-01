// next version of Widgetbook doesn't have api docs yet
// ignore_for_file: public_member_api_docs

import '../../fields/fields.dart';
import 'arg.dart';

class DurationArg extends Arg<Duration> {
  const DurationArg(
    super.value, {
    super.name,
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
      value,
      name: $name == null ? name : $name,
    );
  }
}
