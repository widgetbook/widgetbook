import 'package:meta/meta.dart';

import '../fields/fields.dart';
import '../state/state.dart';
import 'knob.dart';

@internal
class DateTimeKnob extends Knob<DateTime?> {
  DateTimeKnob({
    required super.label,
    required super.value,
    super.description,
    required this.startDateTime,
    required this.endDateTime,
  });

  DateTimeKnob.nullable({
    required super.label,
    required super.value,
    super.description,
    required this.startDateTime,
    required this.endDateTime,
  }) : super(isNullable: true);

  /// The starting [DateTime] value used for the date and time pickers.
  final DateTime startDateTime;

  /// The ending [DateTime] value used for the date and time pickers.
  final DateTime endDateTime;

  @override
  List<Field> get fields {
    return [
      DateTimeField(
        name: label,
        initialValue: value,
        startDateTime: startDateTime,
        endDateTime: endDateTime,
        onChanged: (context, value) {
          if (value == null) return;
          WidgetbookState.of(context).knobs.updateValue(label, value);
        },
      ),
    ];
  }

  @override
  DateTime? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group);
  }
}
