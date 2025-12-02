import 'dart:ui';

import '../fields/fields.dart';
import '../framework/arg.dart';

class ColorArg extends Arg<Color> with SingleFieldOnly {
  ColorArg(
    super.value, {
    super.name,
  });

  @override
  Field<Color> get field {
    return ColorField(
      name: 'value',
      initialValue: value,
    );
  }
}

class NullableColorArg extends Arg<Color?> with SingleFieldOnly {
  NullableColorArg(
    super.value, {
    super.name,
  });

  @override
  Field<Color> get field {
    return ColorField(
      name: 'value',
      initialValue: value ?? ColorField.defaultColor,
    );
  }
}
