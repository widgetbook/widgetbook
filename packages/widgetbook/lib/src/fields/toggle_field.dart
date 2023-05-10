import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

class ToggleField extends Field<bool> {
  ToggleField({
    required super.group,
    required super.name,
    super.initialValue = true,
    required super.onChanged,
  }) : super(
          type: FieldType.toggle,
          codec: FieldCodec(
            toParam: (value) => value.toString(),
            toValue: (param) => param == 'true',
          ),
        );

  @override
  Widget buildField(BuildContext context, bool? value) {
    return Switch(
      value: value ?? initialValue,
      onChanged: (value) => updateField(context, value),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'value': initialValue,
    };
  }
}
