import 'package:flutter/material.dart';

class TileSpacer extends StatelessWidget {
  const TileSpacer({
    Key? key,
    required this.level,
  }) : super(key: key);

  final int level;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: level * 24,
    );
  }
}
