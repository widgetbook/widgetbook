import 'dart:ui';

import '../../fields/fields.dart';
import 'arg.dart';

class ColorArg extends Arg<Color> {
  const ColorArg({
    super.name,
    super.value = const Color(0xFF000000),
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
      name: name,
      value: value,
    );
  }
}
