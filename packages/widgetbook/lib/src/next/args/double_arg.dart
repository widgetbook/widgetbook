// next version of Widgetbook doesn't have api docs yet
// ignore_for_file: public_member_api_docs

import '../../fields/fields.dart';
import 'arg.dart';

class DoubleArg extends Arg<double> {
  const DoubleArg(
    super.value, {
    super.name,
  });

  @override
  List<Field> get fields => [
    DoubleInputField(
      name: name,
      initialValue: value,
    ),
  ];

  @override
  double valueFromQueryGroup(Map<String, String> group) {
    return valueOf(name, group)!;
  }

  @override
  DoubleArg init({
    required String name,
  }) {
    return DoubleArg(
      value,
      name: $name == null ? name : $name,
    );
  }
}
