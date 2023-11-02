import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for zoom/scaling.
class ZoomAddon extends WidgetbookAddon<double> {
  ZoomAddon({double initialZoom = 1.0})
      : super(
          name: 'Zoom',
          initialSetting: initialZoom,
        );

  @override
  List<Field> get fields => [
        DoubleSliderField(
          name: 'zoom',
          initialValue: initialSetting,
          min: 0.5,
          max: 3.0,
          divisions: 25,
        ),
      ];

  @override
  double valueFromQueryGroup(Map<String, String> group) {
    return valueOf('zoom', group)!;
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    double setting,
  ) {
    return Transform.scale(
      scale: setting,
      child: child,
    );
  }
}
