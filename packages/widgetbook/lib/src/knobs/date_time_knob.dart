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
    required this.readOnly,
  });

  DateTimeKnob.nullable({
    required super.label,
    required super.value,
    super.description,
    required this.readOnly,
  }) : super(isNullable: true);

  final bool readOnly;

  @override
  List<Field> get fields {
    return [
      DateTimeField(
        name: label,
        initialValue: value,
        onChanged: (context, value) {
          if (value == null) return;
          WidgetbookState.of(context).knobs.updateValue(label, value);
        },
        readOnly: readOnly,
      ),
    ];
  }

  @override
  DateTime? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group);
  }
}
