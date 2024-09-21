import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for changing the active [MediaQueryData.textScaler]
/// via [MediaQuery].
class TextScaleAddon extends WidgetbookAddon<double> {
  TextScaleAddon({
    this.scales,

    this.initialScale,
    this.min = 0.8,
    this.max = 2.0,
    this.divisions = 6,
  })  : assert(
          scales == null || initialScale == null || scales.contains(initialScale),
          'initialScale must be in scales',
        ),
        super(
          name: 'Text scale',
        );

  final List<double>? scales;

  final double? initialScale;
  final double min;
  final double max;
  final int divisions;

  @override
  List<Field> get fields {
    if (scales != null) {
      return [
        ListField<double>(
          name: 'factor',
          values: scales!,
          initialValue: initialScale ?? scales!.first,
          labelBuilder: (scale) => scale.toStringAsFixed(2),
        ),
      ];
    }

    return [
      DoubleSliderField(
        name: 'factor',
        initialValue: initialScale ?? 1.0,
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
