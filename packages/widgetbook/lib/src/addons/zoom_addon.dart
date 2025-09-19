import 'package:flutter/widgets.dart';

import '../core/core.dart';
import '../fields/fields.dart';

class ZoomMode extends Mode<double> {
  ZoomMode(double value) : super(value, ZoomAddon());
}

/// An [Addon] for zoom/scaling.
class ZoomAddon extends Addon<double> {
  ZoomAddon() : super(name: 'Zoom');

  @override
  List<Field> get fields {
    return [
      DoubleSliderField(
        name: 'ratio',
        initialValue: 1,
        min: 0.25,
        max: 4,
        divisions: 4 * 4 - 1,
      ),
    ];
  }

  @override
  double valueFromQueryGroup(Map<String, String> group) {
    return valueOf('ratio', group)!;
  }

  @override
  Map<String, String> valueToQueryGroup(double value) {
    return {'ratio': paramOf('ratio', value)};
  }

  @override
  Widget buildUseCase(BuildContext context, Widget child, double setting) {
    return Transform.scale(
      scale: setting,
      child: child,
    );
  }
}
