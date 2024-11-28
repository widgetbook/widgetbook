import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@experimental
class ViewportData {
  const ViewportData({
    required this.id,
    this.name,
    required this.width,
    required this.height,
    required this.pixelRatio,
  });

  final String id;
  final String? name;
  final double width;
  final double height;
  final double pixelRatio;

  Size get size => Size(width, height);
}
