import 'package:flutter/material.dart';

import '../field.dart';
import '../field_codec.dart';
import '../field_type.dart';
import 'duration_input.dart';
import 'duration_unit.dart';

/// A [Field] that represents a [Duration] value.
class DurationField extends Field<Duration> {
  /// Creates a new instance of [DurationField].
  DurationField({
    required super.name,
    super.initialValue = defaultDuration,
    this.units = DurationUnit.defaults,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : assert(units.isNotEmpty, 'At least one DurationUnit must be enabled.'),
       super(
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

  /// The time units displayed as separate inputs, rendered from largest to
  /// smallest. Defaults to [DurationUnit.defaults] (hours, minutes, seconds).
  final Set<DurationUnit> units;

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
      units: units,
      onChanged: (duration) => updateField(context, group, duration),
    );
  }
}
