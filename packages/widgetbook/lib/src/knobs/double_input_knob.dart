import '../fields/fields.dart';
import '../state/widgetbook_state.dart';
import 'knob.dart';

class DoubleInputKnob extends Knob<double> {
  DoubleInputKnob({
    required super.label,
    required super.value,
    super.description,
  });

  @override
  List<Field> get fields {
    return [
      DoubleInputField(
        group: 'knobs',
        name: label,
        initialValue: value,
        onChanged: (context, num? value) {
          if (value == null) return;
          WidgetbookState.of(context).updateKnobValue(label, value);
        },
      ),
    ];
  }
}

class NullableDoubleInputKnob extends Knob<double?> {
  NullableDoubleInputKnob({
    required super.label,
    required super.value,
    super.description,
  });

  @override
  List<Field> get fields {
    return [
      DoubleInputField(
        group: 'knobs',
        name: label,
        initialValue: value,
        onChanged: (context, num? value) {
          if (value == null) return;
          WidgetbookState.of(context).updateKnobValue(label, value);
        },
      ),
    ];
  }
}
