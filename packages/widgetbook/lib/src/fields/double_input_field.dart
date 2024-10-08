import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'field.dart';
import 'field_type.dart';
import 'num_input_field.dart';

/// [Field] that builds [TextFormField] for [double] values.
class DoubleInputField extends NumInputField<double> {
  DoubleInputField({
    required super.name,
    super.initialValue = 0,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
          type: FieldType.doubleInput,
          formatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^-?\d*\.?\d*'),
            ),
          ],
        );
}
