import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';

/// A [WidgetbookAddon] for zoom/scaling the widget tree.
///
/// The interactive viewer addon allows developers to scale the entire widget tree
/// to test how components behave at different zoom levels.
///
/// Learn more: https://docs.widgetbook.io/addons/zoom-addon
class InteractiveViewerAddon extends WidgetbookAddon<bool> {
  /// Creates a new instance of [InteractiveViewerAddon].
  InteractiveViewerAddon({
    this.minScale = 1,
    this.maxScale = 30,
  }) : super(
         name: 'Interactive Viewer',
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
