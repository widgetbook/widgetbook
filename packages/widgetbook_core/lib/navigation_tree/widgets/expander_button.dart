import 'dart:math' as math;

import 'package:flutter/material.dart';

class ExpanderButton extends StatelessWidget {
  const ExpanderButton({
    super.key,
    this.isExpanded = false,
    this.onPressed,
    this.size = 24,
  });

  final bool isExpanded;
  final VoidCallback? onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed?.call(),
      borderRadius: BorderRadius.circular(size),
      child: Transform.rotate(
        angle: isExpanded ? math.pi / 2 : 0,
        child: Icon(
          Icons.arrow_right_rounded,
          size: size,
        ),
      ),
    );
  }
}
