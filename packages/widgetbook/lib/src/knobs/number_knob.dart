import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook_core/widgetbook_core.dart' as core;

class NumberKnob extends Knob<num> {
  NumberKnob({
    required super.label,
    super.description,
    required super.value,
  });

  @override
  Widget build(BuildContext context) => core.NumberKnob(
        name: label,
        description: description,
        value: value,
        onChanged: (value) {
          context.read<KnobsNotifier>().update(label, value);
        },
      );
}

class NullableNumberKnob extends Knob<num?> {
  NullableNumberKnob({
    required super.label,
    super.description,
    required super.value,
  });

  @override
  Widget build(BuildContext context) => core.NullableNumberKnob(
        name: label,
        description: description,
        value: value,
        onChanged: (value) {
          context.read<KnobsNotifier>().update(label, value);
        },
      );
}
