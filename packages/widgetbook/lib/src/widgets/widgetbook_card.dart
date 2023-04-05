import 'package:flutter/material.dart';
import 'package:widgetbook/src/constants/radii.dart';

class WidgetbookCard extends StatelessWidget {
  const WidgetbookCard({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        borderRadius: Radii.defaultRadius,
        color: Colors.black,
      ),
      child: child,
    );
  }
}
