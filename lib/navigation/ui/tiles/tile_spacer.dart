import 'package:flutter/material.dart';

class TileSpacer extends StatelessWidget {
  final int level;
  const TileSpacer({
    Key? key,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: level * 24,
    );
  }
}
