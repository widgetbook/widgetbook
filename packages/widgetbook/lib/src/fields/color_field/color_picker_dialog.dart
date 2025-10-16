import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({
    super.key,
    this.initialColor = const Color(0xFF2196F3),
  });

  final Color initialColor;

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

  Color get currentColor =>
      HSVColor.fromAHSV(alpha, hue, saturation, value).toColor();

  void _onConfirm() => Navigator.of(context).pop(currentColor);

  void _onCancel() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IntrinsicWidth(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: currentColor,
                      border: Border.all(
                        color: Colors.black.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Center(
                      child: SelectableText(
                        '#${currentColor.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
                        style: TextStyle(
                          color:
                              currentColor.computeLuminance() > 0.5
                                  ? Colors.black
                                  : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox.square(
                  dimension: constraints.minWidth,
                  child: Builder(
                    builder: (context) {
                      return GestureDetector(
                        onPanDown:
                            (e) => _handleSVGesture(e.localPosition, context),
                        onPanUpdate:
                            (e) => _handleSVGesture(e.localPosition, context),
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
                  child: Row(
                    children: [
                      const Text('Color'),
                      const SizedBox(width: 16),
                      Expanded(
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
                                child: CustomPaint(
                                  painter: _HuePainter(hue: hue),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: constraints.minWidth,
                  child: Row(
                    children: [
                      const Text('Alpha'),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Slider(
                          value: alpha,
                          onChanged: (v) => setState(() => alpha = v),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text('${(alpha * 100).round()}%'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Boutons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _onCancel,
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _onConfirm,
                      child: const Text('Ok'),
                    ),
                  ],
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

    final color = HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor();
    final paint =
        Paint()
          ..shader = ui.Gradient.linear(
            rect.topLeft,
            rect.topRight,
            [
              Colors.white,
              color,
            ],
          );
    canvas.drawRect(rect, paint);

    final paint2 =
        Paint()
          ..shader = ui.Gradient.linear(
            rect.topLeft,
            rect.bottomLeft,
            [
              Colors.transparent,
              Colors.black,
            ],
          );
    canvas.drawRect(rect, paint2);

    final selX = saturation * size.width;
    final selY = (1 - value) * size.height;
    final selectorPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color =
              (HSVColor.fromAHSV(
                        1.0,
                        hue,
                        saturation,
                        value,
                      ).toColor().computeLuminance() >
                      0.5)
                  ? Colors.black
                  : Colors.white;
    canvas.drawCircle(Offset(selX, selY), 8, selectorPaint);
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
    canvas.drawRect(rect, paint);

    final selX = (hue / 360) * size.width;
    final selY = size.height / 2;
    final selectorPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = Colors.white;
    canvas.drawCircle(Offset(selX, selY), 8, selectorPaint);
  }

  @override
  bool shouldRepaint(covariant _HuePainter old) => old.hue != hue;
}
