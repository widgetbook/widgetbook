import 'dart:ui';

import '../core/arg.dart';
import '../fields/fields.dart';

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
      name: $name ?? name,
    );
  }
}
