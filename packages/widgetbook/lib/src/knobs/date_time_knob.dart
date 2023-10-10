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
    required this.start,
    required this.end,
  });

  DateTimeKnob.nullable({
    required super.label,
    required super.value,
    super.description,
    required this.start,
    required this.end,
  }) : super(isNullable: true);

  /// The starting [DateTime] value used for the date and time pickers.
  final DateTime start;

  /// The ending [DateTime] value used for the date and time pickers.
  final DateTime end;

  @override
  List<Field> get fields {
    return [
      DateTimeField(
        name: label,
        initialValue: value,
        start: start,
        end: end,
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
