import 'package:flutter/material.dart';

import '../field.dart';
import '../field_codec.dart';
import '../field_type.dart';
import 'duration_input.dart';

/// A [Field] that represents a [Duration] value.
class DurationField extends Field<Duration> {
  /// Creates a new instance of [DurationField].
  DurationField({
    required super.name,
    super.initialValue = defaultDuration,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         defaultValue: defaultDuration,
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

  /// The default duration value used when no initial value is provided.
  static const defaultDuration = Duration.zero;

  @override
  Widget toWidget(
    BuildContext context,
    String group,
    Duration? value,
  ) {
    return DurationInput(
      value: value ?? initialValue ?? defaultDuration,
      onChanged: (duration) => updateField(context, group, duration),
    );
  }
}
