// next version of Widgetbook doesn't have api docs yet
// ignore_for_file: public_member_api_docs

import '../../fields/fields.dart';
import 'arg.dart';

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
  BoolArg init({
    required String name,
  }) {
    return BoolArg(
      value,
      name: $name == null ? name : $name,
    );
  }
}
