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

  @override
  List<Field> get fields {
    return [
      DoubleSliderField(
        name: 'factor',
        initialValue: 1,
        min: 0.25,
        max: 16,
        divisions: 16 * 4 - 1,
      ),
    ];
  }

  @override
  double valueFromQueryGroup(Map<String, String> group) {
    return valueOf('factor', group)!;
  }
}
