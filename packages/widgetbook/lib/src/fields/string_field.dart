import 'package:flutter/material.dart';

import 'field.dart';

/// A [Field] that builds [TextFormField] for [String] values.
class StringField extends Field<String> {
  /// Creates a new instance of [StringField].
  StringField({
    required super.name,
    super.initialValue = '',
    this.maxLines,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         toParam: (value) => value,
         toValue: (param) => param,
       );

  /// The maximum number of lines for the text field.
  final int? maxLines;

  @override
  Widget toWidget(BuildContext context, String groupName, String value) {
    return TextFormField(
      maxLines: maxLines,
      initialValue: value,
      decoration: const InputDecoration(
        hintText: 'Enter a value',
      ),
      onChanged: (value) => updateField(context, groupName, value),
    );
  }
}
