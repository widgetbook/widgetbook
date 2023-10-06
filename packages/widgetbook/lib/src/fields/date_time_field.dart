import 'package:flutter/material.dart';

import 'field.dart';
import 'field_codec.dart';
import 'field_type.dart';

class DateTimeField extends Field<DateTime> {
  DateTimeField({
    required super.name,
    super.initialValue,
    super.onChanged,
    required this.readOnly,
  }) : super(
          type: FieldType.dateTime,
          codec: FieldCodec<DateTime>(
            toParam: (value) {
              final string = asString(value);
              // replace all instances of ':' with '~' to avoid
              // issues with retrieving the value from the param
              // in the query group because it is saved in a map
              return string.replaceAll(':', timeSeparator);
            },
            toValue: (param) {
              if (param == null) return null;
              final string = param.replaceAll(timeSeparator, ':');
              return DateTime.tryParse(string);
            },
          ),
        );

  /// The separator used to replace ':' in the [DateTime] string.
  static const timeSeparator = '~';

  /// The staring [DateTime] value used for the date and time pickers.
  static final startDateTime = DateTime(0);

  /// The default [DateTime] value used for the date and time pickers
  /// and the field.
  static DateTime get defaultDateTime => DateTime.now();

  /// The ending [DateTime] value used for the date and time pickers.
  static final endDateTime = DateTime.utc(275760, 09, 13);

  /// Whether the field is read only or not.
  final bool readOnly;

  @override
  Widget toWidget(BuildContext context, String group, DateTime? value) {
    final initial = value ?? initialValue;

    final controller = TextEditingController(
      text: initial == null ? null : _revertSeparator(codec.toParam(initial)),
    );

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today_rounded),
          onPressed: () async {
            final initialDate = initial ?? defaultDateTime;

            final date = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: startDateTime,
              lastDate: endDateTime,
            );
            if (date == null) return;

            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(initialDate),
            );
            if (time == null) return;

            final dateTime = DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            );

            updateField(
              context,
              group,
              dateTime,
            );

            controller.text = _revertSeparator(codec.toParam(dateTime));
          },
        ),
      ),
      onChanged: (value) => updateField(
        context,
        group,
        codec.toValue(value) ?? initialValue ?? defaultDateTime,
      ),
      readOnly: readOnly,
    );
  }

  /// Reverts the separator back to ':'.
  String _revertSeparator(String param) {
    return param.replaceAll(timeSeparator, ':');
  }

  /// Converts the [DateTime] to a string object supported by the field
  static String asString(DateTime dateTime) {
    return dateTime.toIso8601String();
  }
}
