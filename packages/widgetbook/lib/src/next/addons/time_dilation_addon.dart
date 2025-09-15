// next version of Widgetbook doesn't have api docs yet
// ignore_for_file: public_member_api_docs

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../../fields/fields.dart';
import 'base/mode.dart';
import 'base/mode_addon.dart';

class TimeDilationMode extends Mode<double> {
  TimeDilationMode(super.value);

  @override
  Widget build(BuildContext context, Widget child) {
    timeDilation = value;
    return child;
  }
}

class TimeDilationAddon extends ModeAddon<double> {
  TimeDilationAddon()
    : super(
        name: 'Time Dilation',
        modeBuilder: TimeDilationMode.new,
      );

  @override
  List<Field> get fields {
    return [
      DoubleSliderField(
        name: 'factor',
        initialValue: 1,
        min: 0.25,
        max: 16,
        divisions: 16 * 4 - 1,
      ),
    ];
  }

  @override
  double valueFromQueryGroup(Map<String, String> group) {
    return valueOf('factor', group)!;
  }
}
