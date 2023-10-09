import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

extension DateTimeExtension on DateTime {
  /// Converts the [DateTime] to a string object supported by the field
  String toSimpleFormat() {
    String pad(int value) {
      return value.toString().padLeft(2, '0');
    }

    return '$year-${pad(month)}-${pad(day)} ${pad(hour)}:${pad(minute)}';
  }
}

extension DateStringExtension on String {
  /// Converts the string gotten from our [DateTimeExtension.toSimpleFormat]
  /// to a [DateTime] object manually since [DateTime.parse] doesn't work
  DateTime fromSimpleFormat() {
    final parts = split(RegExp(r'[- :]+'));
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
      int.parse(parts[3]),
      int.parse(parts[4]),
    );
  }
}

class DateTimeField extends Field<DateTime> {
  DateTimeField({
    required super.name,
    required super.initialValue,
    super.onChanged,
    required this.startDateTime,
    required this.endDateTime,
  }) : super(
          type: FieldType.dateTime,
          codec: FieldCodec<DateTime>(
            toParam: (value) {
              // encode the date time to a string to replace all instances of
              // ':' with '%3A' to avoid issues with retrieving the value
              // from the param in the query group because it is saved in a map
              return Uri.encodeComponent(value.toSimpleFormat());
            },
            toValue: (param) {
              return param == null
                  ? null
                  : Uri.decodeComponent(param).fromSimpleFormat();
            },
          ),
        );

  /// The starting [DateTime] value used for the date and time pickers.
  final DateTime startDateTime;

  /// The ending [DateTime] value used for the date and time pickers.
  final DateTime endDateTime;

  @override
  Widget toWidget(BuildContext context, String group, DateTime? value) {
    final controller = TextEditingController(
      text: (value ?? initialValue)?.toSimpleFormat(),
    );

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today_rounded),
          onPressed: () async {
            final dateTime = await showDateTimePicker(
              context,
              value ?? initialValue,
            );
            if (dateTime != null) {
              updateField(
                context,
                group,
                dateTime,
              );
              controller.text = dateTime.toSimpleFormat();
            }
          },
        ),
      ),
      onChanged: (value) => updateField(
        context,
        group,
        codec.toValue(value) ?? initialValue ?? DateTime.now(),
      ),
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
      firstDate: startDateTime,
      lastDate: endDateTime,
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
      'start': codec.toParam(startDateTime),
      'end': codec.toParam(endDateTime),
    };
  }
}
