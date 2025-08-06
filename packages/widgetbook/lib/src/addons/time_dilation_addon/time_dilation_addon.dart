import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for controlling Flutter animation timing and speed.
///
/// The time dilation addon allows developers to slow down or speed up
/// Flutter animations globally by modifying the [timeDilation] value.
/// This is invaluable for debugging animations, testing transition timing,
/// and creating detailed animation recordings.
///
/// Learn more: https://docs.widgetbook.io/addons/time-dilation-addon
@experimental
class TimeDilationAddon extends WidgetbookAddon<double> {
  /// Creates a new instance of [TimeDilationAddon].
  TimeDilationAddon()
    : super(
        name: 'Time Dilation',
      );

  /// Predefined time dilation values for animation speed control.
  static const values = <double>[0.25, 0.5, 1, 2, 4, 8, 16];

  @override
  List<Field> get fields {
    return [
      ObjectDropdownField<double>(
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
