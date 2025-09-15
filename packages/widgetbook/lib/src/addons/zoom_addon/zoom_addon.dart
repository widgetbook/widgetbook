import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for zoom/scaling the widget tree.
///
/// The zoom addon allows developers to scale the entire widget tree
/// to test how components behave at different zoom levels.
///
/// Learn more: https://docs.widgetbook.io/addons/zoom-addon
class ZoomAddon extends WidgetbookAddon<double> {
  /// Creates a new instance of [ZoomAddon].
  ZoomAddon({
    this.initialZoom = 1.0,
  }) : super(
         name: 'Zoom',
       );

  /// Initial zoom level to display when the addon loads.
  final double initialZoom;

  @override
  List<Field> get fields => [
    DoubleSliderField(
      name: 'zoom',
      initialValue: initialZoom,
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
