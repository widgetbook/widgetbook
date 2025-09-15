import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

@internal
extension DateTimeExtension on DateTime {
  /// Converts the [DateTime] to a string object supported by the field
  String toSimpleFormat() {
    String pad(int value) {
      return value.toString().padLeft(2, '0');
    }

    return '$year-${pad(month)}-${pad(day)} ${pad(hour)}:${pad(minute)}';
  }
}

/// A [Field] that builds a [TextFormField] for [DateTime] values,
/// allowing users to select a date and time using a date and time picker.
class DateTimeField extends Field<DateTime> {
  /// Creates a new instance of [DateTimeField].
  DateTimeField({
    required super.name,
    required super.initialValue,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
    required this.start,
    required this.end,
  }) : super(
         defaultValue: start,
         type: FieldType.dateTime,
         codec: FieldCodec<DateTime>(
           toParam: (value) => value.toSimpleFormat(),
           toValue: (param) {
             return param == null ? null : DateTime.tryParse(param);
           },
         ),
       );

  /// The starting [DateTime] value used for the date and time pickers.
  final DateTime start;

  /// The ending [DateTime] value used for the date and time pickers.
  final DateTime end;

  @override
  Widget toWidget(BuildContext context, String group, DateTime? value) {
    return TextFormField(
      // The "value" used in the key ensures that the TextFormField is rebuilt
      // when the value is changed via the DateTime picker. Without this
      // unique key, the TextFormField will only react to value changes
      // triggered by the user typing in the field.
      key: ValueKey('$group-$name-$value'),
      initialValue: (value ?? initialValue)?.toSimpleFormat(),
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        hintText: 'Enter a DateTime',
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today_rounded),
          onPressed: () async {
            final dateTime = await showDateTimePicker(
              context,
              value ?? initialValue,
            );

            if (dateTime == null) return;

            updateField(context, group, dateTime);
          },
        ),
      ),
      onChanged: (value) {
        final dateTime = codec.toValue(value);
        if (dateTime == null) return;

        updateField(context, group, dateTime);
      },
    );
  }

  /// Shows a date and time picker dialog and returns the selected date and time
  Future<DateTime?> showDateTimePicker(
    BuildContext context, [
    DateTime? value,
  ]) async {
    final initialDate = value ?? DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: start,
      lastDate: end,
    );
    if (date == null) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );
    if (time == null) return null;

    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'start': codec.toParam(start),
      'end': codec.toParam(end),
    };
  }
}
