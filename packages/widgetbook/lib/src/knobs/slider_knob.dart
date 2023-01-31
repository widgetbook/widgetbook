import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook_core/widgetbook_core.dart' as core;

class SliderKnob extends Knob<double> {
  SliderKnob({
    required super.label,
    super.description,
    required super.value,
    this.max = 1,
    this.min = 0,
    this.divisions,
  });

  final double max;
  final double min;
  final int? divisions;

  @override
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
    super.description,
    required double super.value,
    this.max = 1,
    this.min = 0,
    this.divisions,
  });

  final double max;
  final double min;
  final int? divisions;

  @override
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
