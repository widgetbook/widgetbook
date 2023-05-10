import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

class InputField extends Field<String> {
  InputField({
    required super.group,
    required super.name,
    super.initialValue = '',
    this.maxLines = 1,
    required super.onChanged,
  }) : super(
          type: FieldType.text,
          codec: FieldCodec(
            toParam: (value) => value,
            toValue: (param) => param,
          ),
        );

  final int maxLines;

  @override
  Widget buildField(BuildContext context, String? value) {
    return TextFormField(
      initialValue: value ?? initialValue,
      onChanged: (value) => updateField(context, value),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'value': initialValue,
      'maxLines': maxLines,
    };
  }
}
