import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for changing [timeDilation].
@experimental
class TimeDilationAddon extends WidgetbookAddon<double> {
  TimeDilationAddon()
      : super(
          name: 'Time Dilation',
        );

  static const values = <double>[0.25, 0.5, 1, 2, 4, 8, 16];

  @override
  List<Field> get fields {
    return [
      ListField<double>(
        name: 'value',
        values: values,
        initialValue: 1,
        labelBuilder: (scale) => scale.toStringAsFixed(2),
      ),
    ];
  }

  @override
  double valueFromQueryGroup(Map<String, String> group) {
    return valueOf('value', group)!;
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    double setting,
  ) {
    timeDilation = setting;

    return child;
  }
}
