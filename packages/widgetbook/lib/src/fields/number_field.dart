import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

class NumberField extends Field<num> {
  NumberField({
    required super.group,
    required super.name,
    super.initialValue = 0,
    required super.onChanged,
  }) : super(
          type: FieldType.number,
          codec: FieldCodec(
            toParam: (value) => value.toString(),
            toValue: (param) => num.tryParse(param ?? ''),
          ),
        );

  @override
  Widget buildField(BuildContext context, num? value) {
    return TextFormField(
      initialValue: codec.toParam(value ?? initialValue),
      keyboardType: TextInputType.number,
      onChanged: (value) => updateField(
        context,
        codec.toValue(value) ?? initialValue,
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'value': initialValue,
    };
  }
}
