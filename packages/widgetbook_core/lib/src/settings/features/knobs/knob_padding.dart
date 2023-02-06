import 'package:flutter/material.dart';

class KnobPadding extends StatelessWidget {
  const KnobPadding({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: child,
    );
  }
}
