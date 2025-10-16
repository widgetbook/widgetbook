import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';

/// [Field] that builds [Switch] for [bool] values.
class BooleanField extends Field<bool> {
  /// Creates a new instance of [BooleanField].
  BooleanField({
    required super.name,
    super.initialValue = true,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         codec: FieldCodec(
           toParam: (value) => value.toString(),
           toValue: (param) => param == 'true',
         ),
       );

  @override
  Widget toWidget(BuildContext context, String groupName, bool value) {
    return Switch(
      value: value,
      onChanged: (value) => updateField(context, groupName, value),
    );
  }
}
