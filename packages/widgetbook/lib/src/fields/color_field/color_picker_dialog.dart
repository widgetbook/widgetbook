import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({
    super.key,
    required this.initialColor,
    this.onChanged,
  });

  final Color initialColor;
  final void Function(Color)? onChanged;

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  double hue = 0.0;
  double saturation = 1.0;
  double value = 1.0;
  double alpha = 1.0;

  @override
  void initState() {
    super.initState();
    final hsv = HSVColor.fromColor(widget.initialColor);
    hue = hsv.hue;
    saturation = hsv.saturation;
    value = hsv.value;
    alpha = widget.initialColor.a;
  }

  Color get currentColor {
    return HSVColor.fromAHSV(alpha, hue, saturation, value).toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox.square(
                  dimension: constraints.minWidth,
                  child: Builder(
                    builder: (context) {
                      return GestureDetector(
                        onPanDown:
                            (e) => _handleSVGesture(
                              e.localPosition,
                              context,
                            ),
                        onPanUpdate:
                            (e) => _handleSVGesture(
                              e.localPosition,
                              context,
                            ),
                        child: CustomPaint(
                          painter: _SVPainter(hue, saturation, value),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: constraints.minWidth,
                  child: SizedBox(
                    height: 16,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return GestureDetector(
                          onPanDown:
                              (e) => _handleHueGesture(
                                e.localPosition,
                                constraints.minWidth,
                              ),
                          onPanUpdate:
                              (e) => _handleHueGesture(
                                e.localPosition,
                                constraints.minWidth,
                              ),
                          child: CustomPaint(painter: _HuePainter(hue: hue)),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: constraints.minWidth,
                  child: SizedBox(
                    height: 16,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return GestureDetector(
                          onPanDown:
                              (e) => _handleAlphaGesture(
                                e.localPosition,
                                constraints.minWidth,
                              ),
                          onPanUpdate:
                              (e) => _handleAlphaGesture(
                                e.localPosition,
                                constraints.minWidth,
                              ),
                          child: CustomPaint(
                            painter: _OpacityPainter(
                              opacity: alpha,
                              color: currentColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '#${currentColor.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleHueGesture(Offset localPos, double width) {
    final x = localPos.dx.clamp(0.0, width);
    final newHue = (360 * (x / width)).clamp(0.0, 360.0);
    setState(() => hue = newHue);
    widget.onChanged?.call(currentColor);
  }

  void _handleAlphaGesture(Offset localPos, double width) {
    final x = localPos.dx.clamp(0.0, width);
    final newOpacity = (x / width).clamp(0.0, 1.0);
    setState(() => alpha = newOpacity);
    widget.onChanged?.call(currentColor);
  }

  void _handleSVGesture(Offset localPos, BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final size = renderBox.size;

    final dx = localPos.dx.clamp(0.0, size.width);
    final dy = localPos.dy.clamp(0.0, size.height);

    final newS = (dx / size.width).clamp(0.0, 1.0);
    final newV = (1 - (dy / size.height)).clamp(0.0, 1.0);

    setState(() {
      saturation = newS;
      value = newV;
    });
    widget.onChanged?.call(currentColor);
  }
}

class _SVPainter extends CustomPainter {
  _SVPainter(this.hue, this.saturation, this.value);

  final double hue;
  final double saturation;
  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    const radius = Radius.circular(8);
    final rrect = RRect.fromRectAndRadius(rect, radius);

    final color = HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor();
    final paint =
        Paint()
          ..shader = ui.Gradient.linear(rect.topLeft, rect.topRight, [
            Colors.white,
            color,
          ]);
    canvas.drawRRect(rrect, paint);

    final paint2 =
        Paint()
          ..shader = ui.Gradient.linear(rect.topLeft, rect.bottomLeft, [
            Colors.transparent,
            Colors.black,
          ]);
    canvas.drawRRect(rrect, paint2);

    final selX = saturation * size.width;
    final selY = (1 - value) * size.height;
    final selectedColor =
        HSVColor.fromAHSV(1.0, hue, saturation, value).toColor();

    canvas.drawCircle(Offset(selX, selY), 8, Paint()..color = selectedColor);

    canvas.drawCircle(
      Offset(selX, selY),
      6,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant _SVPainter old) =>
      old.hue != hue || old.saturation != saturation || old.value != value;
}

class _HuePainter extends CustomPainter {
  _HuePainter({required this.hue});

  final double hue;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    const radius = Radius.circular(8);
    final rrect = RRect.fromRectAndRadius(rect, radius);

    final colors = List<Color>.generate(
      361,
      (i) => HSVColor.fromAHSV(1.0, i.toDouble(), 1.0, 1.0).toColor(),
    );
    final paint =
        Paint()
          ..shader = ui.Gradient.linear(
            rect.centerLeft,
            rect.centerRight,
            colors,
            List.generate(colors.length, (i) => i / (colors.length - 1)),
          );
    canvas.drawRRect(rrect, paint);

    final selX = (hue / 360) * size.width;
    final selY = size.height / 2;
    final selectedColor = HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor();

    canvas.drawCircle(Offset(selX, selY), 6, Paint()..color = selectedColor);
    canvas.drawCircle(
      Offset(selX, selY),
      6,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant _HuePainter old) => old.hue != hue;
}

class _OpacityPainter extends CustomPainter {
  _OpacityPainter({required this.color, required this.opacity});

  final Color color;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    const radius = Radius.circular(8);
    final rrect = RRect.fromRectAndRadius(rect, radius);

    // Clip only for background
    canvas.save();
    canvas.clipRRect(rrect);

    const checkerSize = 8.0;
    final paintChecker = Paint()..color = Colors.grey.shade300;
    final paintCheckerDark = Paint()..color = Colors.grey.shade400;

    for (double y = 0; y < size.height; y += checkerSize) {
      for (double x = 0; x < size.width; x += checkerSize) {
        final isDark =
            ((x / checkerSize).floor() + (y / checkerSize).floor()) % 2 == 0;
        final cellRect = Rect.fromLTWH(x, y, checkerSize, checkerSize);
        final cellRRect = RRect.fromRectAndRadius(
          cellRect,
          const Radius.circular(2),
        );
        canvas.drawRRect(cellRRect, isDark ? paintCheckerDark : paintChecker);
      }
    }

    final gradient = LinearGradient(
      colors: [color.withAlpha(0), color.withAlpha(255)],
    );
    final paintGradient = Paint()..shader = gradient.createShader(rect);
    canvas.drawRRect(rrect, paintGradient);

    canvas.restore(); // Remove the clip

    // Draw selector on top without clipping
    final selX = opacity * size.width;
    final selY = size.height / 2;
    final selectedColor = color.withValues(alpha: opacity);

    canvas.drawCircle(Offset(selX, selY), 6, Paint()..color = selectedColor);
    canvas.drawCircle(
      Offset(selX, selY),
      6,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant _OpacityPainter old) =>
      old.opacity != opacity || old.color != color;
}
