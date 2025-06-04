import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'field.dart';
import 'field_codec.dart';

class NumInputField<T extends num> extends Field<T> {
  NumInputField({
    required super.name,
    super.initialValue,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
    required super.type,
    required this.formatters,
  }) : super(
          codec: FieldCodec<T>(
            toParam: (value) => value.toString(),
            toValue: (param) => (T == int
                ? int.tryParse(param ?? '')
                : double.tryParse(param ?? '')) as T?,
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
      decoration: const InputDecoration(
        hintText: 'Enter a number',
      ),
      onChanged: (value) {
        final number = codec.toValue(value);
        if (number == null) return;

        updateField(context, group, number);
      },
    );
  }
}
