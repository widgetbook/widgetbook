import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

/// [Field] that builds [TextFormField] for [Color] values.
class ColorField extends Field<Color> {
  ColorField({
    required super.group,
    required super.name,
    super.initialValue = defaultColor,
    super.onChanged,
  }) : super(
          type: FieldType.color,
          codec: FieldCodec(
            toParam: (color) => color.value.toRadixString(16),
            toValue: (param) => param == null
                ? null
                : Color(
                    int.parse(
                      param,
                      radix: 16,
                    ),
                  ),
          ),
        );

  static const defaultColor = Colors.white;

  @override
  Widget toWidget(BuildContext context, Color? value) {
    return TextFormField(
      initialValue: codec.toParam(value ?? initialValue ?? defaultColor),
      onChanged: (value) => updateField(
        context,
        codec.toValue(value) ?? initialValue ?? defaultColor,
      ),
    );
  }
}
