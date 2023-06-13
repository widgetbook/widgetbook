import 'dart:ui';

import 'package:meta/meta.dart';

import '../fields/fields.dart';
import '../state/state.dart';
import 'knob.dart';

@internal
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
        onChanged: (context, value) {
          if (value == null) return;
          WidgetbookState.of(context).updateKnobValue(label, value);
        },
      ),
    ];
  }

  @override
  Color valueFromQueryGroup(Map<String, String> group) {
    return group.containsKey(label)
        ? Color(
            int.parse(
              group[label]!,
              radix: 16,
            ),
          )
        : value;
  }
}
