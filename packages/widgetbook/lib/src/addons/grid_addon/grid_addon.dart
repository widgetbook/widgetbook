import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';
import 'grid_painter.dart';
import 'grid_setting.dart';

class GridAddon extends WidgetbookAddon<GridSetting> {
  GridAddon([int? size])
      : super(
          name: 'Grid',
          initialSetting: GridSetting(size: size ?? 5),
        );

  @override
  List<Field> get fields => [];

  @override
  GridSetting valueFromQueryGroup(Map<String, String> group) {
    return GridSetting(size: initialSetting.size);
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    GridSetting setting, {
    Key? key,
  }) {
    return Stack(
      key: key,
      alignment: Alignment.center,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: GridPainter(
                horizontalDistance: setting.size,
                verticalDistance: setting.size,
              ),
            );
          },
        ),
        child,
      ],
    );
  }
}
