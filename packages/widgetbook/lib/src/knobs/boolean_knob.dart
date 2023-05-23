import '../fields/fields.dart';
import '../state/state.dart';
import 'knob.dart';

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

class NullableBooleanKnob extends Knob<bool?> {
  NullableBooleanKnob({
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
