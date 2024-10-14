import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for changing the active [MediaQueryData.textScaler]
/// via [MediaQuery].
class TextScaleAddon extends WidgetbookAddon<double> {
  TextScaleAddon({
    @Deprecated('Use TextScaleAddon.min and TextScaleAddon.max instead')
    this.scales,
    this.initialScale,
    this.min = 0.5,
    this.max = 2.0,
    this.divisions = 6,
  })  : assert(
          scales == null || scales.isNotEmpty,
          'scales must not be empty, if set',
        ),
        assert(
          scales == null ||
              initialScale == null ||
              scales.contains(initialScale),
          'initialScale must be in scales',
        ),
        super(
          name: 'Text scale',
        );

  @Deprecated('Use TextScaleAddon.min and TextScaleAddon.max instead')
  final List<double>? scales;

  final double? initialScale;
  final double min;
  final double max;
  final int divisions;

  @override
  List<Field> get fields {
    // Fallback to old implementation if scales are provided
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
