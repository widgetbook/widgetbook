import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
class ComponentIcon extends StatelessWidget {
  const ComponentIcon({
    super.key,
    this.size = 12,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1,
      child: SizedBox(
        width: size,
        height: size,
        child: Transform.rotate(
          angle: 45 * pi / 180,
          child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.zero,
            children: List.generate(
              4,
              (index) => Icon(
                Icons.square_rounded,
                size: size / 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
