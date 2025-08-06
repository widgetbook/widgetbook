import 'package:flutter/material.dart';

class ColoredTextBox extends StatelessWidget {
  const ColoredTextBox({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final defaultColor = color ?? const Color.fromRGBO(224, 224, 224, 1);
    final colorText =
        color?.toARGB32().toRadixString(16).toUpperCase() ??
        'No color selected';
    return Container(
      color: defaultColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(colorText),
      ),
    );
  }
}
