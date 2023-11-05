import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

/// [Field] that builds [TextFormField] for [String] values.
class StringField extends Field<String> {
  StringField({
    required super.name,
    super.initialValue = '',
    this.maxLines,
    @deprecated super.onChanged,
  }) : super(
          type: FieldType.string,
          codec: FieldCodec(
            toParam: (value) => Uri.encodeComponent(value),
            toValue: (param) => param != null
                ? Uri.decodeComponent(param) //
                : null,
          ),
        );

  final int? maxLines;

  @override
  Widget toWidget(BuildContext context, String group, String? value) {
    return TextFormField(
      maxLines: maxLines,
      initialValue: value ?? initialValue,
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
