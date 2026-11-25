import 'package:material_ui/material_ui.dart';
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
      initialValue: initialValue.start,
    ),
    DoubleInputField(
      name: 'max',
      initialValue: initialValue.end,
    ),
  ];

  @override
  RangeValues valueFromQueryGroup(QueryGroup? group) {
    if (group == null || group.isNullified) return initialValue;

    return RangeValues(
      valueOf('min', group),
      valueOf('max', group),
    );
  }

  @override
  QueryGroup valueToQueryGroup(RangeValues value) {
    return QueryGroup(
      {
        'min': paramOf('min', value),
        'max': paramOf('max', value),
      },
    );
  }
}
