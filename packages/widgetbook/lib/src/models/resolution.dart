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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Resolution &&
        other.nativeSize == nativeSize &&
        other.scaleFactor == scaleFactor;
  }

  @override
  int get hashCode => nativeSize.hashCode ^ scaleFactor.hashCode;
}
