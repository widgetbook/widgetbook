import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for zoom/scaling the widget tree.
///
/// The zoom addon allows developers to scale the entire widget tree
/// to test how components behave at different zoom levels.
///
/// Learn more: https://docs.widgetbook.io/addons/zoom-addon
class ZoomAddon extends WidgetbookAddon<bool> {
  /// Creates a new instance of [ZoomAddon].
  ZoomAddon({
    this.minScale = 1,
    this.maxScale = 10,
  }) : super(
         name: 'Zoom',
       );

  /// The minimum scale factor for zooming.
  final double minScale;

  /// The maximum scale factor for zooming.
  final double maxScale;

  @override
  List<Field> get fields => [
    BooleanField(
      name: 'enabled',
    ),
  ];

  @override
  bool valueFromQueryGroup(Map<String, String> group) {
    return valueOf('enabled', group) as bool;
  }

  @override
  Widget buildUseCase(BuildContext context, Widget child, bool setting) {
    if (!setting) return child;
    return InteractiveViewer(
      minScale: minScale,
      maxScale: maxScale,
      child: child,
    );
  }
}
