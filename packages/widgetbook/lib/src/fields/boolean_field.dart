import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

/// [Field] that builds [Switch] for [bool] values.
class BooleanField extends Field<bool> {
  /// Creates a new instance of [BooleanField].
  BooleanField({
    required super.name,
    super.initialValue = true,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         defaultValue: true,
         type: FieldType.boolean,
         codec: FieldCodec(
           toParam: (value) => value.toString(),
           toValue: (param) => param == null ? null : param == 'true',
         ),
       );

  @override
  Widget toWidget(BuildContext context, String group, bool? value) {
    return Switch(
      value: value ?? initialValue ?? true,
      onChanged: (value) => updateField(context, group, value),
    );
  }
}
