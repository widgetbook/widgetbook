import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

class DurationField extends Field<Duration> {
  DurationField({
    required super.name,
    required Duration super.initialValue,
    super.onChanged,
  }) : super(
          type: FieldType.doubleInput,
          codec: durationCodec,
        );

  @override
  Widget toWidget(BuildContext context, String label, Duration? currentValue) {
    return TextFormField(
      initialValue:
          codec.toParam(currentValue ?? initialValue ?? Duration.zero),
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      onChanged: (value) => updateField(
        context,
        label,
        codec.toValue(value) ?? initialValue ?? Duration.zero,
      ),
    );
  }
}

final FieldCodec<Duration> durationCodec = FieldCodec<Duration>(
  toParam: (duration) => duration.inMilliseconds.toString(),
  toValue: (param) {
    if (param == null) return null;
    return Duration(milliseconds: int.tryParse(param) ?? 0);
  },
);
