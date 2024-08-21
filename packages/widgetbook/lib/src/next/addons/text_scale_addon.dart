import 'package:flutter/widgets.dart';

import '../../fields/fields.dart';
import 'base/mode.dart';
import 'base/mode_addon.dart';

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
