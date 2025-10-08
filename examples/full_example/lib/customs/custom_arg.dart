import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class RangeArg extends Arg<RangeValues> {
  RangeArg(
    super.value, {
    super.name,
  });

  @override
  List<Field> get fields => [
    DoubleInputField(
      name: 'min',
      initialValue: value.start,
    ),
    DoubleInputField(
      name: 'max',
      initialValue: value.end,
    ),
  ];

  @override
  RangeValues valueFromQueryGroup(Map<String, String> group) {
    return RangeValues(
      valueOf('min', group)!,
      valueOf('max', group)!,
    );
  }

  @override
  Map<String, String> valueToQueryGroup(RangeValues value) {
    return {
      'min': paramOf('min', value),
      'max': paramOf('max', value),
    };
  }

  @override
  RangeArg init({
    required String name,
  }) {
    return RangeArg(
      value,
      name: $name ?? name,
    );
  }
}
