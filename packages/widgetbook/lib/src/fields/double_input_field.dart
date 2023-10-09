import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';
import 'num_input_field.dart';

/// [Field] that builds [TextFormField] for [double] values.
class DoubleInputField extends NumInputField<double> {
  DoubleInputField({
    required super.name,
    super.initialValue = 0,
    super.onChanged,
  }) : super(
          type: FieldType.doubleInput,
          codec: FieldCodec(
            toParam: (value) => value.toString(),
            toValue: (param) => double.tryParse(param ?? ''),
          ),
        );
}
