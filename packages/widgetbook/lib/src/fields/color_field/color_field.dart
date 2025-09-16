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
  /// Creates a new instance of [ColorField].
  ColorField({
    required super.name,
    super.initialValue = defaultColor,
    this.initialColorSpace = ColorSpace.hex,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         defaultValue: defaultColor,
         type: FieldType.color,
         codec: FieldCodec(
           toParam: (color) => color.toARGB32().toRadixString(16),
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

  /// The initial color space to use for the color picker.
  final ColorSpace initialColorSpace;

  /// The default color used when no value is provided.
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
