import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook_core/widgetbook_core.dart' as core;

import '../fields/fields.dart';

class SliderKnob extends Knob<double> {
  SliderKnob({
    required super.label,
    required super.value,
    super.description,
    this.max = 1,
    this.min = 0,
    this.divisions,
  });

  final double max;
  final double min;
  final int? divisions;

  @override
  List<Field> get fields => [];

  Widget build(BuildContext context) => core.SliderKnob(
        name: label,
        description: description,
        min: min,
        max: max,
        divisions: divisions,
        value: value,
        onChanged: (value) {
          context.read<KnobsNotifier>().update(label, value);
        },
      );
}

class NullableSliderKnob extends Knob<double?> {
  NullableSliderKnob({
    required super.label,
    required double super.value,
    super.description,
    this.max = 1,
    this.min = 0,
    this.divisions,
  });

  final double max;
  final double min;
  final int? divisions;

  @override
  List<Field> get fields => [];

  Widget build(BuildContext context) => core.NullableSliderKnob(
        name: label,
        description: description,
        min: min,
        max: max,
        divisions: divisions,
        value: value,
        onChanged: (value) {
          context.read<KnobsNotifier>().update(label, value);
        },
      );
}
