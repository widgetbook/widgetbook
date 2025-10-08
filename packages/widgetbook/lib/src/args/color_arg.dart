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
  Color valueFromQueryGroup(Map<String, String> group) {
    return valueOf('value', group)!;
  }

  @override
  Map<String, String> valueToQueryGroup(Color value) {
    return {'value': paramOf('value', value)};
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
