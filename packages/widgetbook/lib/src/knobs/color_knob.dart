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
    this.initialColorSpace = ColorSpace.hex,
  });

  ColorSpace initialColorSpace;

  @override
  List<Field> get fields {
    return [
      ColorField(
        name: label,
        initialValue: value,
        initialColorSpace: initialColorSpace,
        onChanged: (context, value) {
          if (value == null) return;
          WidgetbookState.of(context).knobs.updateValue(label, value);
        },
      ),
      // ColorSpaceField(
      //   name: '$label-color-space', 
      //   initialValue: initialColorSpace,
      //   onChanged: (context, value) {
      //     initialColorSpace = value ?? initialColorSpace;
      //     print(value);
      //     if(initialColorSpace != value && value != null){
      //       WidgetbookState.of(context).knobs.updateValue(label, WidgetbookState.of(context).knobs[label]?.value);
      //     }
      //   },
      // ),
    ];
  }

  @override
  Color valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group)!;
  }
}
