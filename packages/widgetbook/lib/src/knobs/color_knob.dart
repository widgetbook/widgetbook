import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook_core/widgetbook_core.dart' as core;

import '../fields/fields.dart';

class ColorKnob extends Knob<Color> {
  ColorKnob({
    required super.label,
    required super.value,
    super.description,
  });

  @override
  List<Field> get fields => [];

  Widget build(BuildContext context) => core.ColorKnob(
        name: label,
        description: description,
        value: value,
        onChanged: (color) {
          context.read<KnobsNotifier>().update(label, color);
        },
      );
}
