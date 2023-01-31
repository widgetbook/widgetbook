import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook_core/widgetbook_core.dart' as core;

class TextKnob extends Knob<String> {
  TextKnob({
    required super.label,
    super.description,
    required super.value,
    this.maxLines = 1,
  });
  final int? maxLines;
  @override
  Widget build(BuildContext context) => core.TextKnob(
        name: label,
        maxLines: maxLines,
        description: description,
        value: value,
        onChanged: (value) {
          context.read<KnobsNotifier>().update(label, value);
        },
      );
}

class NullableTextKnob extends Knob<String?> {
  NullableTextKnob({
    required super.label,
    super.description,
    required super.value,
    this.maxLines = 1,
  });
  final int? maxLines;
  @override
  Widget build(BuildContext context) => core.NullableTextKnob(
        name: label,
        maxLines: maxLines,
        description: description,
        value: value,
        onChanged: (value) {
          context.read<KnobsNotifier>().update(label, value);
        },
      );
}
