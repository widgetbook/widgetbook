import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for changing the active [MediaQueryData.textScaleFactor]
/// via [MediaQuery].
/// Equivalent to [TextScaleAddon] but uses a [Slider] widget rather than a [DropdownMenu].
class TextScaleSliderAddon extends WidgetbookAddon<double> {
  TextScaleSliderAddon({
    this.min = 0.8,
    this.max = 2.0,
    this.divisions = 6,
    this.initialScale = 1.0,
  }) : super(
          name: 'Text scale',
        );

  final double min;
  final double max;
  final int divisions;
  final double initialScale;

  @override
  List<Field> get fields {
    return [
      DoubleSliderField(
        name: 'factor',
        initialValue: initialScale,
        min: min,
        max: max,
        divisions: divisions,
      ),
    ];
  }

  @override
  double valueFromQueryGroup(Map<String, String> group) {
    return valueOf('factor', group)!;
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    double setting,
  ) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(setting),
      ),
      child: child,
    );
  }
}
