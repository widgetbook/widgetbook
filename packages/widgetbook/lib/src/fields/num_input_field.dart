import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'field.dart';
import 'field_codec.dart';

class NumInputField<T extends num> extends Field<T> {
  NumInputField({
    required super.name,
    super.initialValue,
    @deprecated super.onChanged,
    required super.type,
    required this.formatters,
  }) : super(
          codec: FieldCodec<T>(
            toParam: (value) => value.toString(),
            toValue: (param) => num.tryParse(param ?? '') as T?,
          ),
        );

  final List<TextInputFormatter> formatters;

  @override
  Widget toWidget(BuildContext context, String group, T? value) {
    final defaultValue = (T == int ? 0 : 0.0) as T;

    return TextFormField(
      initialValue: codec.toParam(value ?? initialValue ?? defaultValue),
      keyboardType: TextInputType.number,
      inputFormatters: formatters,
      onChanged: (value) => updateField(
        context,
        group,
        codec.toValue(value) ?? initialValue!,
      ),
    );
  }
}
