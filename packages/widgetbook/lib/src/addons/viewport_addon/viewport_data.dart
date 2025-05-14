import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

@experimental
class ViewportData {
  const ViewportData({
    required this.id,
    this.name,
    required this.width,
    required this.height,
    required this.pixelRatio,
    required this.platform,
    this.safeAreas = EdgeInsets.zero,
  });

  final String id;
  final String? name;
  final double width;
  final double height;
  final double pixelRatio;
  final TargetPlatform platform;
  final EdgeInsets safeAreas;

  Size get size => Size(width, height);
}
