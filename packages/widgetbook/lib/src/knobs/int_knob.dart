import 'package:meta/meta.dart';

import '../fields/fields.dart';
import '../state/widgetbook_state.dart';
import 'knob.dart';

@internal
class IntKnob extends Knob<int?> {
  IntKnob({
    required super.label,
    required super.value,
    super.description,
  });

  IntKnob.nullable({
    required super.label,
    required super.value,
    super.description,
  }) : super(isNullable: true);

  @override
  List<Field> get fields {
    return [
      IntField(
        name: label,
        initialValue: value,
        onChanged: (context, value) {
          if (value == null) return;
          WidgetbookState.of(context).knobs.updateValue(label, value);
        },
      ),
    ];
  }

  @override
  int? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group);
  }
}
