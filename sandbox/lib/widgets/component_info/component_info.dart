import 'package:flutter/material.dart';

import '../dart_code_viewer/dart_code_viewer.dart';

class ComponentInfo extends StatelessWidget {
  const ComponentInfo({
    super.key,
    required this.componentName,
    required this.description,
    required this.component,
    required this.codeSnippet,
  });

  final String componentName;
  final String description;
  final Widget component;
  final String codeSnippet;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(componentName, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(description, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 8),
          const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: 'Preview'),
              Tab(text: 'Code'),
            ],
          ),
          SizedBox(
            height: 300,
            child: TabBarView(
              children: [
                Center(child: CheckerboardBackground(child: component)),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DartCodeViewer(codeSnippet),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CheckerboardBackground extends StatelessWidget {
  const CheckerboardBackground({
    super.key,
    this.squareSize = 16,
    this.color1 = const Color(0xFF232323),
    this.color2 = const Color(0xFF292929),
    this.child,
  });
  final double squareSize;
  final Color color1;
  final Color color2;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CheckerboardPainter(squareSize, color1, color2),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(child: child),
      ),
    );
  }
}

class _CheckerboardPainter extends CustomPainter {
  _CheckerboardPainter(this.squareSize, this.color1, this.color2);

  final double squareSize;
  final Color color1;
  final Color color2;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = false;
    final cols = (size.width / squareSize).ceil();
    final rows = (size.height / squareSize).ceil();

    for (var y = 0; y < rows; y++) {
      for (var x = 0; x < cols; x++) {
        paint.color = (x + y) % 2 == 0 ? color1 : color2;
        final left = x * squareSize;
        final top = y * squareSize;
        final right = (left + squareSize).clamp(0, size.width);
        final bottom = (top + squareSize).clamp(0, size.height);
        canvas.drawRect(
          Rect.fromLTRB(left, top, right.toDouble(), bottom.toDouble()),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
