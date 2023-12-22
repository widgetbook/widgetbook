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
          name: 'min-$name',
          initialValue: value.start,
        ),
        DoubleInputField(
          name: 'max-$name',
          initialValue: value.end,
        ),
      ];

  @override
  RangeValues valueFromQueryGroup(Map<String, String> group) {
    return RangeValues(
      valueOf('min-$name', group)!,
      valueOf('max-$name', group)!,
    );
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
