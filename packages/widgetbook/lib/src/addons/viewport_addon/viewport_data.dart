import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

/// Data class representing a viewport configuration.
class ViewportData {
  /// Creates a [ViewportData] instance.
  const ViewportData({
    required this.name,
    required this.width,
    required this.height,
    required this.pixelRatio,
    required this.platform,
    this.safeAreas = EdgeInsets.zero,
  });

  /// The name of the viewport.
  final String name;

  /// The width of the viewport in logical pixels.
  final double width;

  /// The height of the viewport in logical pixels.
  final double height;

  /// The pixel ratio of the viewport.
  final double pixelRatio;

  /// The target platform for the viewport.
  final TargetPlatform platform;

  /// The safe areas for the viewport.
  final EdgeInsets safeAreas;

  /// Returns a [Size] object representing the size of the viewport.
  Size get size => Size(width, height);
}
