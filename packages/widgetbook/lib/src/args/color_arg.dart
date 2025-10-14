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
      name: 'value',
      initialValue: value,
    ),
  ];

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
