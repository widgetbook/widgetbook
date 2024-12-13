import 'package:flutter/material.dart';

import '../field.dart';
import '../field_codec.dart';
import '../field_type.dart';
import 'color_picker.dart';
import 'color_space.dart';

export 'color_space.dart';

/// [Field] that builds [ColorPicker] for [Color] values using the [ColorSpace]
/// to determine which format the [Color] is.
class ColorField extends Field<Color> {
  ColorField({
    required super.name,
    super.initialValue = defaultColor,
    this.initialColorSpace = ColorSpace.hex,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
          type: FieldType.color,
          codec: FieldCodec(
            // Color.value was deprecated in Flutter 3.27.0, the alternative
            // apis (.r, .g, .b, .a) are not available in Color for our minimum
            // Flutter version (3.16.0), as they were also introduced in 3.27.0.
            // ignore: deprecated_member_use
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

  final ColorSpace initialColorSpace;

  static const defaultColor = Colors.white;

  @override
  Widget toWidget(BuildContext context, String group, Color? value) {
    return ColorPicker(
      colorSpace: initialColorSpace,
      value: value ?? defaultColor,
      onChanged: (value) {
        updateField(
          context,
          group,
          value,
        );
      },
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'space': initialColorSpace.name,
    };
  }
}
