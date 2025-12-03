import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../fields/fields.dart';
import '../framework/framework.dart';

/// An [Addon] for changing [timeDilation].
class TimeDilationMode extends Mode<double> {
  TimeDilationMode(double value) : super(value, TimeDilationAddon());
}

class TimeDilationAddon extends Addon<double> with SingleFieldOnly {
  TimeDilationAddon()
    : super(
        name: 'Time Dilation',
        initialValue: 1,
      );

  /// Predefined time dilation values for animation speed control.
  static const values = <double>[0.25, 0.5, 1, 2, 4, 8, 16];

  @override
  Field<double> get field {
    return ObjectDropdownField<double>(
      name: 'value',
      values: values,
      initialValue: initialValue,
      labelBuilder: (scale) => scale.toStringAsFixed(2),
    );
  }

  @override
  Widget apply(BuildContext context, Widget child, double setting) {
    timeDilation = setting;
    return child;
  }
}
