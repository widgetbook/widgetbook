import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../../fields/fields.dart';
import 'base/mode.dart';
import 'base/modes_addon.dart';

class TimeDilationMode extends Mode<double> {
  TimeDilationMode(super.value);

  @override
  Widget build(BuildContext context, Widget child) {
    timeDilation = value;

    return child;
  }
}

class TimeDilationAddon extends ModesAddon<TimeDilationMode> {
  TimeDilationAddon()
      : super(
          name: 'Time Dilation',
          modes: [],
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
  TimeDilationMode valueFromQueryGroup(Map<String, String> group) {
    return TimeDilationMode(
      valueOf<double>('factor', group)!,
    );
  }
}
