import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
class ScenarioIcon extends StatelessWidget {
  const ScenarioIcon({
    super.key,
    this.size = 12,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.circle,
      size: size,
    );
  }
}
