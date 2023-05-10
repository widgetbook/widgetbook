import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../fields/fields.dart';

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
          context.read<KnobsNotifier>().update(label, value);
        },
      ),
    ];
  }
}
