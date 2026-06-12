import 'package:flutter/widgets.dart';

import '../fields/fields.dart';
import '../framework/framework.dart';

class ZoomMode extends Mode<double> {
  ZoomMode(double value) : super(value, ZoomAddon(value));

  @override
  String get formattedValue => 'x$value';
}

/// An [Addon] for zoom/scaling.
class ZoomAddon extends Addon<double> with SingleFieldOnly {
  ZoomAddon([double ratio = 1])
    : super(
        name: 'Zoom',
        initialValue: ratio,
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
