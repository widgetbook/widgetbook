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
  RangeValues valueFromQueryGroup(QueryGroup? group) {
    if (group == null || group.isNullified) return value;

    return RangeValues(
      valueOf('min', group)!,
      valueOf('max', group)!,
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
