import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
class UseCaseIcon extends StatelessWidget {
  const UseCaseIcon({
    super.key,
    this.size = 14,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 45 * pi / 180,
      child: Icon(
        Icons.square_rounded,
        size: size,
      ),
    );
  }
}
