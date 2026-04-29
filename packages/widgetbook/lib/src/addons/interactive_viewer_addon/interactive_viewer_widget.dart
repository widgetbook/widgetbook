import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

/// An InteractiveViewer widget that syncs its transformation state with the URL query parameters.
class InteractiveViewerWidget extends StatefulWidget {
  /// Creates an [InteractiveViewerWidget].
  const InteractiveViewerWidget({
    required this.minScale,
    required this.maxScale,
    required this.scale,
    required this.translation,
    required this.onTransformChanged,
    required this.child,
    super.key,
  });

  /// The minimum scale factor for zooming.
  final double minScale;

  /// The maximum scale factor for zooming.
  final double maxScale;

  /// Callback function that is called when the transformation changes.
  final double scale;

  /// The current translation point.
  final ({double? x, double? y}) translation;

  /// Callback function that is called when the transformation changes.
  final void Function(Point translation, double scale) onTransformChanged;

  /// The child widget to be displayed inside the InteractiveViewer.
  final Widget child;

  @override
  State<InteractiveViewerWidget> createState() =>
      _InteractiveViewerWidgetState();
}

class _InteractiveViewerWidgetState extends State<InteractiveViewerWidget> {
  TransformationController? _controller;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenSize = MediaQuery.sizeOf(context);

      /// Parse scale with default of 1
      final scale = widget.scale;

      /// Parse x and y with fallback to center
      final fallbackX = (screenSize.width / 2) * (1 - scale);
      final fallbackY = (screenSize.height / 2) * (1 - scale);
      final x = widget.translation.x ?? fallbackX;
      final y = widget.translation.y ?? fallbackY;

      _controller = TransformationController(
        Matrix4.identity()..scaleByDouble(
          scale,
          scale,
          scale,
          1.0,
        ),
      );
      _controller!.value.setTranslationRaw(x, y, 0);
      _controller!.addListener(_onTransformChanged);
      setState(() {});
    });
  }

  void _onTransformChanged() {
    final scale = _controller!.value.getMaxScaleOnAxis().toStringAsFixed(2);
    final x = _controller!.value.getTranslation().x.toStringAsFixed(2);
    final y = _controller!.value.getTranslation().y.toStringAsFixed(2);

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 100), () {
      widget.onTransformChanged(
        Point<double>(double.parse(x), double.parse(y)),
        double.parse(scale),
      );
    });
  }

  @override
  void dispose() {
    _controller?.removeListener(_onTransformChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: _controller,
      minScale: widget.minScale,
      maxScale: widget.maxScale,
      child: widget.child,
    );
  }
}
