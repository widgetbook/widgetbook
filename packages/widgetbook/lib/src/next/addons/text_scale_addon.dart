// [MediaQuery.textScaleFactor] is deprecated in Flutter 3.16.0,
// Since our minimum Flutter version is 3.7.0, we cannot use [TextScaler] yet.
// More info: https://docs.flutter.dev/release/breaking-changes/deprecate-textscalefactor
// ignore_for_file: deprecated_member_use

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
        textScaleFactor: value,
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
