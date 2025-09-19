import 'package:flutter/widgets.dart';

import '../core/core.dart';
import '../fields/fields.dart';

/// An [Addon] for changing the active [MediaQueryData.textScaler]
/// via [MediaQuery].
class TextScaleMode extends Mode<double> {
  TextScaleMode(double value) : super(value, TextScaleAddon());
}

class TextScaleAddon extends Addon<double> {
  TextScaleAddon() : super(name: 'Text Scale');

  @override
  List<Field> get fields {
    return [
      DoubleSliderField(
        name: 'factor',
        initialValue: 1,
        min: 0.25,
        max: 3,
        divisions: 3 * 4 - 1,
      ),
    ];
  }

  @override
  double valueFromQueryGroup(Map<String, String> group) {
    return valueOf('factor', group)!;
  }

  @override
  Map<String, String> valueToQueryGroup(double value) {
    return {'factor': paramOf('factor', value)};
  }

  @override
  Widget buildUseCase(BuildContext context, Widget child, double setting) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(setting),
      ),
      child: child,
    );
  }
}
