// next version of Widgetbook doesn't have api docs yet
// ignore_for_file: public_member_api_docs

import 'dart:ui';

import '../../fields/fields.dart';
import 'arg.dart';

class ColorArg extends Arg<Color> {
  const ColorArg(
    super.value, {
    super.name,
  });

  @override
  List<Field> get fields => [
        ColorField(
          name: name,
          initialValue: value,
        ),
      ];

  @override
  Color valueFromQueryGroup(Map<String, String> group) {
    return valueOf(name, group)!;
  }

  @override
  ColorArg init({
    required String name,
  }) {
    return ColorArg(
      value,
      name: $name == null ? name : $name,
    );
  }
}
