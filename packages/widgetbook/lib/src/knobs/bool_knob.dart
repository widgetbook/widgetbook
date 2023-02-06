import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook_core/widgetbook_core.dart' as core;

class BoolKnob extends Knob<bool> {
  BoolKnob({
    required super.label,
    super.description,
    required super.value,
  });

  @override
  Widget build(BuildContext context) => core.BoolKnob(
        name: label,
        description: description,
        value: value,
        onChanged: (value) {
          context.read<KnobsNotifier>().update(label, value);
        },
      );
}

class NullableBoolKnob extends Knob<bool?> {
  NullableBoolKnob({
    required super.label,
    super.description,
    required super.value,
  });

  @override
  Widget build(BuildContext context) => core.NullableBoolKnob(
        name: label,
        description: description,
        value: value,
        onChanged: (value) {
          context.read<KnobsNotifier>().update(label, value);
        },
      );
}
