import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:widgetbook/src/knobs/knobs.dart';

/// A knob that allows the user to toggle a boolean value.
///
/// See also:
/// * [BooleanKnobWidget], which is the widget that displays the knob.
/// {@endtemplate}
class BoolKnob extends Knob<bool> {
  /// {@macro bool_knob}
  BoolKnob({
    required String label,
    String? description,
    required bool value,
  }) : super(
          label: label,
          description: description,
          value: value,
        );

  @override
  Widget build() => BooleanKnobWidget(
        label: label,
        description: description,
        value: value,
      );
}

/// {@template boolean_knob_widget}
/// A knob widget that allows the user to toggle a boolean value.
///
/// The knob is displayed as a checkbox.
///
/// See also:
/// * [BoolKnob], which is the knob that this widget represents.
/// {@endtemplate}
class BooleanKnobWidget extends StatelessWidget {
  /// {@macro boolean_knob_widget}
  const BooleanKnobWidget({
    Key? key,
    required this.label,
    required this.description,
    required this.value,
  }) : super(key: key);

  final String label;
  final String? description;
  final bool value;

  @override
  Widget build(BuildContext context) => CheckboxListTile(
        title: Text(label),
        subtitle: description == null ? null : Text(description!),
        value: value,
        onChanged: (v) => context.read<KnobsNotifier>().update(label, v),
      );
}
