import 'package:flutter/material.dart';

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

    if (horizontalDistance > 0)
      for (var i = 0; i < size.width; i += horizontalDistance) {
        canvas.drawLine(
          Offset(i.toDouble(), 0),
          Offset(i.toDouble(), size.height),
          paint,
        );
      }

    if (verticalDistance > 0)
      for (var i = 0; i < size.height; i += verticalDistance) {
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
