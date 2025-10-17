part of 'field.dart';

/// A [Field] that builds a [TextFormField] for [DateTime] values,
/// allowing users to select a date and time using a date and time picker.
final class DateTimeField extends Field<DateTime> {
  /// Creates a new instance of [DateTimeField].
  DateTimeField({
    required super.name,
    required super.initialValue,
    @Deprecated('Fields should not be aware of their context') super.onChanged,
    required this.start,
    required this.end,
  }) : super(
         toParam: (value) => value.toSimpleFormat(),
         toValue: DateTime.tryParse,
       );

  /// The starting [DateTime] value used for the date and time pickers.
  final DateTime start;

  /// The ending [DateTime] value used for the date and time pickers.
  final DateTime end;

  @override
  Widget toWidget(BuildContext context, String groupName, DateTime value) {
    return TextFormField(
      // The "value" used in the key ensures that the TextFormField is rebuilt
      // when the value is changed via the DateTime picker. Without this
      // unique key, the TextFormField will only react to value changes
      // triggered by the user typing in the field.
      key: ValueKey('$groupName-$name-$value'),
      initialValue: value.toSimpleFormat(),
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        hintText: 'Enter a DateTime',
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today_rounded),
          onPressed: () async {
            final dateTime = await showDateTimePicker(context, value);
            if (dateTime == null) return;

            updateField(context, groupName, dateTime);
          },
        ),
      ),
      onChanged: (value) {
        final dateTime = toValue(value);
        if (dateTime == null) return;

        updateField(context, groupName, dateTime);
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
}
