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
      child: Icon(
        isExpanded ? Icons.arrow_downward_rounded : Icons.arrow_right_rounded,
        size: size,
      ),
    );
  }
}
