import 'package:meta/meta.dart';

import '../fields/fields.dart';
import '../state/widgetbook_state.dart';
import 'knob.dart';

@internal
class IntInputKnob extends Knob<int?> {
  IntInputKnob({
    required super.label,
    required super.value,
    super.description,
  });

  IntInputKnob.nullable({
    required super.label,
    required super.value,
    super.description,
  }) : super(isNullable: true);

  @override
  List<Field> get fields {
    return [
      IntInputField(
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
