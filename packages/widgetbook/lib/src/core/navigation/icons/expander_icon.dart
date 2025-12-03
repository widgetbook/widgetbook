import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
class ExpanderIcon extends StatelessWidget {
  const ExpanderIcon({
    super.key,
    this.isExpanded = false,
    this.size = 24,
  });

  final bool isExpanded;
  final double size;

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      duration: const Duration(milliseconds: 100),
      turns: isExpanded ? 0.25 : 0,
      child: Icon(
        Icons.arrow_right_rounded,
        size: size,
      ),
    );
  }
}
