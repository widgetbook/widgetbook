import 'package:flutter/widgets.dart';

import '../core/addon.dart';
import '../core/mode.dart';
import '../core/mode_addon.dart';
import '../fields/fields.dart';

/// An [Addon] for changing the active [MediaQueryData.textScaler]
/// via [MediaQuery].
class TextScaleMode extends Mode<double> {
  TextScaleMode(super.value);

  @override
  Widget build(BuildContext context, Widget child) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(value),
      ),
      child: child,
    );
  }
}

class TextScaleAddon extends ModeAddon<double> {
  TextScaleAddon()
    : super(
        name: 'Text Scale',
        modeBuilder: TextScaleMode.new,
      );

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
}
