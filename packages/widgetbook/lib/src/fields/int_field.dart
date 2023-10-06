import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

class IntField extends Field<int> {
  IntField({
    required super.name,
    super.initialValue = 0,
    super.onChanged,
  }) : super(
          type: FieldType.int,
          codec: FieldCodec<int>(
            toParam: (value) => value.toString(),
            toValue: (param) => int.tryParse(param ?? ''),
          ),
        );

  @override
  Widget toWidget(BuildContext context, String label, int? currentValue) {
    return TextFormField(
      initialValue: codec.toParam(currentValue ?? initialValue ?? 0),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (value) => updateField(
        context,
        label,
        codec.toValue(value) ?? initialValue ?? 0,
      ),
    );
  }
}
