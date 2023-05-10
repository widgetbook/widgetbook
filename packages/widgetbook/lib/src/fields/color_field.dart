import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

class ColorField extends Field<Color> {
  ColorField({
    required super.group,
    required super.name,
    super.initialValue = Colors.white,
    required super.onChanged,
  }) : super(
          type: FieldType.color,
          codec: FieldCodec(
            toParam: (color) => color.value.toRadixString(16),
            toValue: (param) => Color(
              int.parse(
                param ?? '0',
                radix: 16,
              ),
            ),
          ),
        );

  @override
  Widget toWidget(BuildContext context, Color? value) {
    return TextFormField(
      initialValue: codec.toParam(value ?? initialValue),
      onChanged: (value) => updateField(
        context,
        codec.toValue(value) ?? initialValue,
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'value': codec.toParam(initialValue),
    };
  }
}
