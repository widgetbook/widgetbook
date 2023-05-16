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
  Widget toWidget(BuildContext context, num? value) {
    return TextFormField(
      initialValue: codec.toParam(value ?? initialValue ?? 0),
      keyboardType: TextInputType.number,
      onChanged: (value) => updateField(
        context,
        codec.toValue(value) ?? initialValue ?? 0,
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
