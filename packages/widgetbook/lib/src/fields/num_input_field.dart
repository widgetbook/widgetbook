import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'field.dart';
import 'field_codec.dart';

class NumInputField<T extends num> extends Field<T> {
  NumInputField({
    required super.name,
    super.initialValue,
    super.onChanged,
    required super.type,
    this.formatters,
  }) : super(
          codec: FieldCodec<T>(
            toParam: (value) => value.toString(),
            toValue: (param) => num.tryParse(param ?? '') as T?,
          ),
        );

  final List<TextInputFormatter>? formatters;

  @override
  Widget toWidget(BuildContext context, String label, T? currentValue) {
    final defaultValue = (T == int ? 0 : 0.0) as T;

    return TextFormField(
      initialValue: codec.toParam(currentValue ?? initialValue ?? defaultValue),
      keyboardType: TextInputType.number,
      inputFormatters: formatters,
      onChanged: (value) => updateField(
        context,
        label,
        codec.toValue(value) ?? initialValue!,
      ),
    );
  }
}
