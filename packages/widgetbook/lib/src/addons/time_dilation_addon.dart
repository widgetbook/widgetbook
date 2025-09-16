import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../core/addon.dart';
import '../core/mode.dart';
import '../core/mode_addon.dart';
import '../fields/fields.dart';

/// An [Addon] for changing [timeDilation].
class TimeDilationMode extends Mode<double> {
  TimeDilationMode(super.value);

  @override
  Widget build(BuildContext context, Widget child) {
    timeDilation = value;
    return child;
  }
}

class TimeDilationAddon extends ModeAddon<double> {
  TimeDilationAddon()
    : super(
        name: 'Time Dilation',
        modeBuilder: TimeDilationMode.new,
      );

  /// Predefined time dilation values for animation speed control.
  static const values = <double>[0.25, 0.5, 1, 2, 4, 8, 16];

  @override
  List<Field> get fields {
    return [
      ObjectDropdownField<double>(
        name: 'value',
        values: values,
        initialValue: 1,
        labelBuilder: (scale) => scale.toStringAsFixed(2),
      ),
    ];
  }

  @override
  double valueFromQueryGroup(Map<String, String> group) {
    return valueOf('value', group)!;
  }
}
