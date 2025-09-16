import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

/// A [Field] that builds [TextFormField] for [String] values.
class StringField extends Field<String> {
  /// Creates a new instance of [StringField].
  StringField({
    required super.name,
    super.initialValue = '',
    this.maxLines,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         defaultValue: '',
         type: FieldType.string,
         codec: FieldCodec(
           toParam: (value) => value,
           toValue: (param) => param,
         ),
       );

  /// The maximum number of lines for the text field.
  final int? maxLines;

  @override
  Widget toWidget(BuildContext context, String group, String? value) {
    return TextFormField(
      maxLines: maxLines,
      initialValue: value ?? initialValue,
      decoration: const InputDecoration(
        hintText: 'Enter a value',
      ),
      onChanged: (value) => updateField(context, group, value),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'maxLines': maxLines,
    };
  }
}
