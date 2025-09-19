import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../core/core.dart';
import '../fields/fields.dart';

/// An [Addon] for changing [timeDilation].
class TimeDilationMode extends Mode<double> {
  TimeDilationMode(double value) : super(value, TimeDilationAddon());
}

class TimeDilationAddon extends Addon<double> {
  TimeDilationAddon() : super(name: 'Time Dilation');

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

  @override
  Map<String, String> valueToQueryGroup(double value) {
    return {'value': paramOf('value', value)};
  }

  @override
  Widget buildUseCase(BuildContext context, Widget child, double setting) {
    timeDilation = setting;
    return child;
  }
}
