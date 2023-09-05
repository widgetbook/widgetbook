import 'package:meta/meta.dart';

import '../fields/fields.dart';
import '../state/state.dart';
import 'knob.dart';

@internal
class BooleanKnob extends Knob<bool?> {
  BooleanKnob({
    required super.label,
    required super.value,
    super.description,
  });

  BooleanKnob.nullable({
    required super.label,
    required super.value,
    super.description,
  }) : super(isNullable: true);

  @override
  List<Field> get fields {
    return [
      BooleanField(
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
  bool? valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group);
  }
}
