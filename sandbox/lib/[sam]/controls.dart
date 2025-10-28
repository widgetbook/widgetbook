import 'package:flutter/material.dart';

class Controls extends StatelessWidget {
  const Controls({
    super.key,
    required this.control1Label,
    required this.onControl1Pressed,
    required this.control2Label,
    required this.onControl2Pressed,
  });

  final String control1Label;
  final VoidCallback onControl1Pressed;

  final String control2Label;
  final VoidCallback onControl2Pressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: [
        ElevatedButton(
          onPressed: onControl1Pressed,
          child: Text(control1Label),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: onControl2Pressed,
          child: Text(control2Label),
        ),
      ],
    );
  }
}
