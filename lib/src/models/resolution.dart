import 'package:flutter/material.dart';

class Resolution {
  Size get logicalSize => nativeSize / scaleFactor;
  final Size nativeSize;

  final double scaleFactor;

  const Resolution({
    required this.nativeSize,
    required this.scaleFactor,
  });
}
