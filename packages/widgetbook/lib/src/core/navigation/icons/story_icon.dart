import 'dart:math';

import 'package:material_ui/material_ui.dart';
import 'package:meta/meta.dart';

@internal
class StoryIcon extends StatelessWidget {
  const StoryIcon({
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
