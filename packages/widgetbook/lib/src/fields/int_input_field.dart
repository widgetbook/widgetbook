import 'package:flutter/services.dart';

import 'field_type.dart';
import 'num_input_field.dart';

/// [Field] that builds [TextFormField] for [int] values.
class IntInputField extends NumInputField<int> {
  IntInputField({
    required super.name,
    super.initialValue = 0,
    @deprecated super.onChanged,
  }) : super(
          type: FieldType.intInput,
          formatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^-?\d*'),
            ),
          ],
        );
}
