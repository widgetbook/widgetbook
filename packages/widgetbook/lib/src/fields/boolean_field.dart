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
    bool? defaultValue,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         defaultValue: defaultValue ?? initialValue ?? true,
         type: FieldType.boolean,
         codec: FieldCodec(
           toParam: (value) => value.toString(),
           toValue: (param) {
             if (param == null) return null;
             if (param.isEmpty) return initialValue ?? defaultValue ?? true;
             return param == 'true';
           },
         ),
       );

  @override
  Widget toWidget(BuildContext context, String group, bool? value) {
    return Switch(
      value: value ?? initialValue ?? defaultValue,
      onChanged: (value) => updateField(context, group, value),
    );
  }
}
