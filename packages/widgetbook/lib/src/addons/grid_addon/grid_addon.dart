import 'package:flutter/material.dart';
import '../../fields/fields.dart';
import '../common/common.dart';
import 'grid_painter.dart';

class GridAddon extends WidgetbookAddon<int> {
  GridAddon([this.dimension = 50])
      : assert(dimension > 0),
        super(
          name: 'Grid',
          initialSetting: dimension,
        );
  final int dimension;
  
  @override
  List<Field> get fields => [];

  @override
  int valueFromQueryGroup(Map<String, String> group) => dimension;

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    int dimension, {
    Key? key,
  }) {
    return Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return CustomPaint(
              painter: GridPainter(dimension),
              size: Size(
                constraints.maxWidth,
                constraints.maxHeight,
              ),
            );
          },
        ),
        child,
      ],
    );
  }
}
