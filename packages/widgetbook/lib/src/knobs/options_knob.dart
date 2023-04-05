import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs.dart';
import 'package:widgetbook_core/widgetbook_core.dart' as core;

class OptionsKnob<T> extends Knob<T> {
  OptionsKnob({
    required super.label,
    required super.value,
    required this.options,
    super.description,
    this.labelBuilder,
  });

  final List<T> options;
  final String Function(T)? labelBuilder;

  @override
  Widget build(BuildContext context) => core.OptionKnob(
        name: label,
        description: description,
        value: value,
        values: options,
        labelBuilder: labelBuilder,
        onChanged: (T value) {
          context.read<KnobsNotifier>().update<T>(label, value);
        },
      );
}
