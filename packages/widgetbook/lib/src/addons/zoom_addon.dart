import 'package:flutter/widgets.dart';

import '../core/core.dart';
import '../fields/fields.dart';

class ZoomMode extends Mode<double> {
  ZoomMode(double value) : super(value, ZoomAddon());
}

/// An [Addon] for zoom/scaling.
class ZoomAddon extends Addon<double> with SingleFieldOnly {
  ZoomAddon()
    : super(
        name: 'Zoom',
        initialValue: 1,
      );

  @override
  Field<double> get field {
    return DoubleSliderField(
      name: 'ratio',
      initialValue: initialValue,
      min: 0.25,
      max: 4,
      divisions: 4 * 4 - 1,
      precision: 2,
    );
  }

  @override
  Widget apply(BuildContext context, Widget child, double setting) {
    return Transform.scale(
      scale: setting,
      child: child,
    );
  }
}
