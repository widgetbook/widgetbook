import 'package:flutter/material.dart';

import '../field.dart';
import '../field_codec.dart';
import '../field_type.dart';
import 'color_picker.dart';
import 'color_space.dart';

export 'color_space.dart';

/// [Field] that builds [ColorsFieldWidget] for [Color] values.
///
/// The [ColorField] uses the [ColorFieldCodec] to convert the [Color] value to a
/// hex string and vice versa.
///
/// The [ColorField] uses the [ColorSpace] to determine which format the color is.
class ColorField extends Field<Color> {
  ColorField({
    required super.name,
    super.initialValue = defaultColor,
    this.initialColorSpace = ColorSpace.hex,
    super.onChanged,
  }) : super(
          type: FieldType.color,
          codec: FieldCodec(
            toParam: (color) => color.value.toRadixString(16),
            toValue: (param) {
              if (param == null) return null;
              if (param == '0') return Colors.transparent;
              return Color(
                int.parse(
                  param.length == 6 ? '00$param' : param,
                  radix: 16,
                ),
              );
            },
          ),
        );

  ColorSpace initialColorSpace;

  static const defaultColor = Colors.white;

  @override
  Widget toWidget(BuildContext context, String group, Color? value) {
    return ColorPicker(
      colorSpace: initialColorSpace,
      value: value,
      defaultColor: defaultColor,
      onChanged: (value) {
        updateField(
          context,
          group,
          value,
        );
      },
    );
  }
}
