import 'package:meta/meta.dart';

import '../fields/fields.dart';
import 'knob.dart';

@internal
class DateTimeKnob extends Knob<DateTime?> {
  DateTimeKnob({
    required super.label,
    required super.initialValue,
    super.description,
    required this.start,
    required this.end,
  });

  DateTimeKnob.nullable({
    required super.label,
    required super.initialValue,
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
        initialValue: initialValue,
        start: start,
        end: end,
      ),
    ];
  }

  @override
  DateTime? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group);
  }
}
