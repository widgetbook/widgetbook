import 'dart:ui';

import '../fields/fields.dart';
import '../state/state.dart';
import 'knob.dart';

class ColorKnob extends Knob<Color> {
  ColorKnob({
    required super.label,
    required super.value,
    super.description,
  });

  @override
  List<Field> get fields {
    return [
      ColorField(
        group: 'knobs',
        name: label,
        initialValue: value,
        onChanged: (context, Color? value) {
          if (value == null) return;
          WidgetbookState.of(context).updateKnobValue(label, value);
        },
      ),
    ];
  }
}
