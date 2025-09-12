import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'field.dart';
import 'field_type.dart';
import 'num_input_field.dart';

/// A [Field] that builds [TextFormField] for [int] values.
class IntInputField extends NumInputField<int> {
  /// Creates a new instance of [IntInputField].
  IntInputField({
    required super.name,
    super.initialValue = 0,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         type: FieldType.intInput,
         formatters: [
           FilteringTextInputFormatter.allow(
             RegExp(r'^-?\d*'),
           ),
         ],
       );
}
