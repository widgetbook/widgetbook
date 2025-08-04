import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for overlaying alignment grids on use cases.
///
/// The grid addon provides visual alignment assistance by overlaying
/// a customizable grid pattern over use cases. This helps developers
/// ensure proper spacing, alignment, and layout consistency during
/// component development and testing.
///
/// Learn more: https://docs.widgetbook.io/addons/grid-addon
class GridAddon extends WidgetbookAddon<int> {
  /// Creates a new instance of [GridAddon].
  GridAddon([
    this.dimension = 50,
  ]) : assert(dimension > 0),
       super(
         name: 'Grid',
       );

  /// The spacing between grid lines in pixels.
  final int dimension;

  @override
  List<Field> get fields => [];

  @override
  int valueFromQueryGroup(Map<String, String> group) => dimension;

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    int setting,
  ) {
    return Stack(
      children: [
        GridPaper(
          color: Colors.grey.withAlpha(255 ~/ 2),
          interval: setting.toDouble(),
          subdivisions: 2,
          child: Container(),
        ),
        child,
      ],
    );
  }
}
