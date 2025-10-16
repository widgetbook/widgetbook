import 'package:flutter/material.dart';

import 'field.dart';

/// A [Field] that represents a [Duration] value.
class DurationField extends Field<Duration> {
  /// Creates a new instance of [DurationField].
  DurationField({
    required super.name,
    super.initialValue = defaultDuration,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
  }) : super(
         toParam: (value) => value.inMilliseconds.toString(),
         toValue: (param) {
           final ms = int.tryParse(param);
           if (ms == null) return null;
           return Duration(milliseconds: ms);
         },
       );

  /// The default duration value used when no initial value is provided.
  static const defaultDuration = Duration.zero;

  @override
  Widget toWidget(BuildContext context, String groupName, Duration value) {
    return TextFormField(
      initialValue: toParam(value),
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'Enter a duration',
        suffix: Text('ms'),
      ),
      onChanged: (value) {
        final duration = toValue(value);
        if (duration == null) return;

        updateField(context, groupName, duration);
      },
    );
  }
}
