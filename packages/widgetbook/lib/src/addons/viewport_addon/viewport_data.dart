/// @docImport 'package:flutter_test/flutter_test.dart';
library;

import 'dart:ui';

import 'package:flutter/widgets.dart';

/// Data class representing a viewport configuration.
class ViewportData {
  /// Creates a [ViewportData] instance.
  const ViewportData({
    required this.name,
    required double width,
    required double height,
    required this.pixelRatio,
    required this.platform,
    this.safeAreas = EdgeInsets.zero,
  }) : minWidth = width,
       maxWidth = width,
       minHeight = height,
       maxHeight = height;

  const ViewportData.constrained({
    required this.name,
    this.minWidth = 0,
    this.maxWidth = double.infinity,
    this.minHeight = 0,
    this.maxHeight = double.infinity,
    required this.pixelRatio,
    required this.platform,
    this.safeAreas = EdgeInsets.zero,
  }) : assert(
         minWidth <= maxWidth,
         'minWidth must be less than or equal to maxWidth',
       ),
       assert(
         minHeight <= maxHeight,
         'minHeight must be less than or equal to maxHeight',
       );

  /// The name of the viewport.
  final String name;

  /// The minimum width of the viewport.
  final double minWidth;

  /// The maximum width of the viewport.
  final double maxWidth;

  /// The minimum height of the viewport.
  final double minHeight;

  /// The maximum height of the viewport.
  final double maxHeight;

  /// The pixel ratio of the viewport.
  final double pixelRatio;

  /// The target platform for the viewport.
  final TargetPlatform platform;

  /// The safe areas for the viewport.
  final EdgeInsets safeAreas;

  Size get minSize => Size(minWidth, minHeight);
  Size get maxSize => Size(maxWidth, maxHeight);

  /// Used with [ConstrainedBox] to set the constraints of the viewport.
  BoxConstraints get boxConstraints => BoxConstraints(
    minWidth: minWidth,
    maxWidth: maxWidth,
    minHeight: minHeight,
    maxHeight: maxHeight,
  );

  /// Used with [TestFlutterView.physicalConstraints] It needs to be scaled up
  /// by the pixel ratio to get the correct physical size.
  ViewConstraints get viewConstraints => ViewConstraints(
    minWidth: minWidth * pixelRatio,
    maxWidth: maxWidth * pixelRatio,
    minHeight: minHeight * pixelRatio,
    maxHeight: maxHeight * pixelRatio,
  );
}
