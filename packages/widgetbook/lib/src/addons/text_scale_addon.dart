import 'package:flutter/widgets.dart';

import '../core/core.dart';
import '../fields/fields.dart';

/// An [Addon] for changing the active [MediaQueryData.textScaler]
/// via [MediaQuery].
class TextScaleMode extends Mode<double> {
  TextScaleMode(double value) : super(value, TextScaleAddon());
}

class TextScaleAddon extends Addon<double> with SingleFieldOnly {
  TextScaleAddon()
    : super(
        name: 'Text Scale',
        initialValue: 1,
      );

  @override
  Field<double> get field {
    return DoubleSliderField(
      name: 'factor',
      initialValue: initialValue,
      min: 0.25,
      max: 3,
      divisions: 3 * 4 - 1,
      precision: 2,
    );
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
