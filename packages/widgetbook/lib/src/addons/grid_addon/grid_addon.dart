import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';
import 'grid_setting.dart';

class GridAddon extends WidgetbookAddon<GridSetting> {
  GridAddon({
    int? initialHorizontalDistance,
    int? initialVerticalDistance,
  }) : super(
          name: 'Grid',
          initialSetting: GridSetting(
            horizontalDistance: initialHorizontalDistance ?? 10,
            verticalDistance: initialVerticalDistance ?? 10,
          ),
        );

  @override
  List<Field> get fields {
    return [
      IntField(
        name: 'horizontalDistance',
        initialValue: initialSetting.horizontalDistance,
      ),
      IntField(
        name: 'verticalDistance',
        initialValue: initialSetting.verticalDistance,
      ),
    ];
  }

  @override
  GridSetting valueFromQueryGroup(Map<String, String> group) {
    return GridSetting(
      horizontalDistance: valueOf('horizontalDistance', group)!,
      verticalDistance: valueOf('verticalDistance', group)!,
    );
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    GridSetting setting,
  ) {
    return Stack(
      alignment: Alignment.center,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: GridPainter(
                horizontalDistance: setting.horizontalDistance,
                verticalDistance: setting.verticalDistance,
              ),
            );
          },
        ),
        child,
      ],
    );
  }
}

class GridPainter extends CustomPainter {
  GridPainter({
    required this.horizontalDistance,
    required this.verticalDistance,
  });

  final int horizontalDistance;
  final int verticalDistance;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..strokeWidth = 0.5;

    for (var i = 0; i < size.width; i += horizontalDistance) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), size.height),
        paint,
      );
    }

    for (var i = 0; i < size.height; i += verticalDistance) {
      canvas.drawLine(
        Offset(0, i.toDouble()),
        Offset(size.width, i.toDouble()),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
