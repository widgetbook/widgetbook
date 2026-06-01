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
    this.enableDays = false,
    this.enableHours = true,
    this.enableMinutes = true,
    this.enableSeconds = true,
    this.enableMilliseconds = false,
    this.enableMicroseconds = false,
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

  /// Whether to enable input for days in the duration.
  final bool enableDays;

  /// Whether to enable input for hours in the duration.
  final bool enableHours;

  /// Whether to enable input for minutes in the duration.
  final bool enableMinutes;

  /// Whether to enable input for seconds in the duration.
  final bool enableSeconds;

  /// Whether to enable input for milliseconds in the duration.
  final bool enableMilliseconds;

  /// Whether to enable input for microseconds in the duration.
  final bool enableMicroseconds;

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
      enableDays: enableDays,
      enableHours: enableHours,
      enableMinutes: enableMinutes,
      enableSeconds: enableSeconds,
      enableMilliseconds: enableMilliseconds,
      enableMicroseconds: enableMicroseconds,
      onChanged: (duration) => updateField(context, group, duration),
    );
  }
}
