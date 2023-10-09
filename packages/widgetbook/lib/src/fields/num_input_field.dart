import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'field.dart';

class NumInputField<T extends num> extends Field<T> {
  NumInputField({
    required super.name,
    super.initialValue,
    super.onChanged,
    required super.codec,
    required super.type,
    this.inputFormatters,
  });

  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget toWidget(BuildContext context, String label, T? currentValue) {
    return TextFormField(
      initialValue: codec.toParam(currentValue ?? initialValue ?? (0 as T)),
      keyboardType: TextInputType.number,
      inputFormatters: inputFormatters,
      onChanged: (value) => updateField(
        context,
        label,
        codec.toValue(value) ?? initialValue!,
      ),
    );
  }
}
