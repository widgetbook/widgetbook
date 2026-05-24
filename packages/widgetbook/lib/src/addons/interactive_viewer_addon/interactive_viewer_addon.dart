import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../widgetbook.dart';
import 'interactive_viewer_widget.dart';

@internal
class InteractiveViewerSetting {
  const InteractiveViewerSetting({
    required this.enabled,
    required this.scale,
    this.x,
    this.y,
  });

  final bool enabled;
  final double scale;
  final double? x;
  final double? y;

  @override
  String toString() =>
      'InteractiveViewerSetting(enabled: $enabled, scale: $scale, x: $x, y: $y)';
}

/// A [WidgetbookAddon] for zoom/scaling the widget tree.
///
/// The interactive viewer addon allows developers to scale the entire widget tree
/// to test how components behave at different zoom levels.
///
/// Learn more: https://docs.widgetbook.io/addons/interactive-viewer-addon
class InteractiveViewerAddon extends WidgetbookAddon<InteractiveViewerSetting> {
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
  InteractiveViewerSetting valueFromQueryGroup(Map<String, String> group) {
    final enabled = valueOf('enabled', group) as bool;
    final scale = double.tryParse(group['scale'] ?? '') ?? 1.0;
    final x = double.tryParse(group['x'] ?? '');
    final y = double.tryParse(group['y'] ?? '');

    return InteractiveViewerSetting(
      enabled: enabled,
      scale: scale,
      x: x,
      y: y,
    );
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    InteractiveViewerSetting setting,
  ) {
    if (!setting.enabled) return child;
    return InteractiveViewerWidget(
      minScale: minScale,
      maxScale: maxScale,
      translation: (x: setting.x, y: setting.y),
      scale: setting.scale,
      onTransformChanged: (translation, scale) {
        final newGroup = {
          'enabled': setting.enabled.toString(),
          'scale': scale.toStringAsFixed(2),
          'x': translation.x.toStringAsFixed(2),
          'y': translation.y.toStringAsFixed(2),
        };

        final encodedNewGroup = FieldCodec.encodeQueryGroup(newGroup);
        WidgetbookState.of(context).updateQueryParam(
          'interactive-viewer',
          encodedNewGroup,
        );
      },
      child: child,
    );
  }
}
