import 'dart:ui';

import '../core/arg.dart';
import '../fields/fields.dart';

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

  @override
  NullableColorArg init({
    required String name,
  }) {
    return NullableColorArg(
      value,
      name: $name ?? name,
    );
  }
}
