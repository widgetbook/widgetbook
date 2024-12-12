import 'dart:ui';

import 'package:flutter/foundation.dart';
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
  });

  final String id;
  final String? name;
  final double width;
  final double height;
  final double pixelRatio;
  final TargetPlatform platform;

  Size get size => Size(width, height);
}
