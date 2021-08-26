import 'package:flutter/material.dart';

class Resolution {
  Size get logicalSize => nativeSize / scaleFactor;
  final Size nativeSize;

  final double scaleFactor;

  factory Resolution.dimensions({
    required double width,
    required double height,
    required double scaleFactor,
  }) {
    return Resolution(
      nativeSize: Size(width, height),
      scaleFactor: scaleFactor,
    );
  }

  const Resolution({
    required this.nativeSize,
    required this.scaleFactor,
  });
}
