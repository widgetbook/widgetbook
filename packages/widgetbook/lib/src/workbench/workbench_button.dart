import 'package:flutter/material.dart';
import 'package:widgetbook/src/constants/radii.dart';

class WorkbenchButton extends StatelessWidget {
  const WorkbenchButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.color = Colors.transparent,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        customBorder: const RoundedRectangleBorder(
          borderRadius: Radii.defaultRadius,
        ),
        hoverColor: Theme.of(context).cardColor,
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            borderRadius: Radii.defaultRadius,
            color: color,
          ),
          child: child,
        ),
      ),
    );
  }
}
