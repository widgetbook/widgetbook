import 'package:meta/meta.dart';

import '../fields/fields.dart';
import '../state/state.dart';
import 'knob.dart';

@internal
class BooleanKnob extends Knob<bool> {
  BooleanKnob({
    required super.label,
    required super.value,
    super.description,
  });

  @override
  List<Field> get fields {
    return [
      BooleanField(
        group: 'knobs',
        name: label,
        initialValue: value,
        onChanged: (context, bool? value) {
          if (value == null) return;
          WidgetbookState.of(context).updateKnobValue(label, value);
        },
      ),
    ];
  }
}

@internal
class BooleanOrNullKnob extends Knob<bool?> {
  BooleanOrNullKnob({
    required super.label,
    required super.value,
    super.description,
  });

  @override
  List<Field> get fields {
    return [
      BooleanField(
        group: 'knobs',
        name: label,
        initialValue: value,
        onChanged: (context, bool? value) {
          if (value == null) return;
          WidgetbookState.of(context).updateKnobValue(label, value);
        },
      ),
    ];
  }
}
