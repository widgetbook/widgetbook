import 'package:flutter/material.dart';

import 'builder_addon.dart';

class GridAddon extends BuilderAddon {
  GridAddon([int dimension = 50])
    : assert(dimension > 0),
      super(
        name: 'Grid',
        builder: (context, child) {
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
        },
      );
}

class GridPainter extends CustomPainter {
  GridPainter(
    this.dimension,
  ) : assert(dimension > 0);

  final int dimension;

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.grey.withAlpha(125)
          ..strokeWidth = 0.5;

    for (var i = 0; i < size.width; i += dimension) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), size.height),
        paint,
      );
    }

    for (var i = 0; i < size.height; i += dimension) {
      canvas.drawLine(
        Offset(0, i.toDouble()),
        Offset(size.width, i.toDouble()),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) => true;
}
