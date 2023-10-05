import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

class DurationField extends Field<Duration> {
  DurationField({
    required super.name,
    super.initialValue = defaultDuration,
    super.onChanged,
  }) : super(
          type: FieldType.duration,
          codec: FieldCodec(
            toParam: (value) => value.inMilliseconds.toString(),
            toValue: (param) {
              return param == null
                  ? null
                  : Duration(
                      milliseconds: int.tryParse(param) ?? 0,
                    );
            },
          ),
        );

  static const defaultDuration = Duration.zero;

  @override
  Widget toWidget(BuildContext context, String label, Duration? currentValue) {
    return TextFormField(
      initialValue:
          codec.toParam(currentValue ?? initialValue ?? defaultDuration),
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        suffix: Text('ms'),
      ),
      onChanged: (value) => updateField(
        context,
        label,
        codec.toValue(value) ?? initialValue ?? defaultDuration,
      ),
    );
  }
}
