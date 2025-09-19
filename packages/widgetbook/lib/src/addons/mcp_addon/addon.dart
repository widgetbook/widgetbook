import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../widgetbook.dart';

class McpAddon extends WidgetbookAddon<void> {
  McpAddon() : super(name: 'Screenshot');

  // Global key to capture the entire use case
  final GlobalKey _screenshotKey = GlobalKey();

  @override
  List<Field> get fields => [];

  @override
  void valueFromQueryGroup(Map<String, String> group) {}

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    void setting,
  ) {
    print('ScreenshotAddon: Building use case');
    return RepaintBoundary(
      key: _screenshotKey,
      child: child,
    );
  }

  /// Public method to capture a screenshot of the current use case
  /// Returns a Future<String?> containing the base64 encoded screenshot data
  Future<String?> captureScreenshot() async {
    try {
      // Wait for the next frame to ensure the widget is fully rendered
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Check if the context is available
      final context = _screenshotKey.currentContext;
      if (context == null) {
        debugPrint(
          'ScreenshotAddon: Context not available for screenshot capture',
        );
        return null;
      }

      // Find the render object and capture the image
      final boundary = context.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        debugPrint('ScreenshotAddon: RenderRepaintBoundary not found');
        return null;
      }

      // Capture the image with default settings
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        final bytes = byteData.buffer.asUint8List();
        final base64String = base64Encode(bytes);
        return base64String;
      } else {
        debugPrint('ScreenshotAddon: Failed to convert image to byte data');
        return null;
      }
    } catch (e) {
      debugPrint('ScreenshotAddon: Error capturing screenshot: $e');
      return null;
    }
  }

  /// Capture the render tree structure and return it as a JSON-serializable map
  /// Returns a Future<Map<String, dynamic>?> containing the render tree structure
  Future<Map<String, dynamic>?> captureRenderTree() async {
    try {
      // Wait for the next frame to ensure the widget is fully rendered
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Check if the context is available
      final context = _screenshotKey.currentContext;
      if (context == null) {
        debugPrint(
          'ScreenshotAddon: Context not available for render tree capture',
        );
        return null;
      }

      // Find the render object
      final renderObject = context.findRenderObject();
      if (renderObject == null) {
        debugPrint('ScreenshotAddon: RenderObject not found');
        return null;
      }

      // Build the render tree structure
      final renderTree = _buildRenderTreeNode(renderObject);
      return renderTree;
    } catch (e) {
      debugPrint('ScreenshotAddon: Error capturing render tree: $e');
      return null;
    }
  }

  /// Get the render tree as a formatted JSON string
  String? captureRenderTreeAsJson({bool pretty = true}) {
    final renderTree = captureRenderTree();

    if (pretty) {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(renderTree);
    } else {
      return jsonEncode(renderTree);
    }
  }

  /// Recursively build a JSON representation of a render object and its children
  Map<String, dynamic> _buildRenderTreeNode(RenderObject renderObject) {
    final node = <String, dynamic>{
      'type': renderObject.runtimeType.toString(),
      'depth': renderObject.depth,
    };

    // Add size information if available (only for RenderBox)
    if (renderObject is RenderBox && renderObject.hasSize) {
      final size = renderObject.size;
      node['size'] = {
        'width': _sanitizeDouble(size.width),
        'height': _sanitizeDouble(size.height),
      };

      final offset = renderObject.localToGlobal(Offset.zero);
      node['position'] = {
        'x': _sanitizeDouble(offset.dx),
        'y': _sanitizeDouble(offset.dy),
      };

      // Add constraints information
      node['constraints'] = _serializeConstraints(renderObject.constraints);
    }

    // Add semantic information if available
    if (renderObject.debugSemantics != null) {
      node['semantics'] = {
        'label': renderObject.debugSemantics?.label,
        'hint': renderObject.debugSemantics?.hint,
        'value': renderObject.debugSemantics?.value,
      };
    }

    // Add paint properties for debugging
    node['needsPaint'] = renderObject.debugNeedsPaint;
    node['needsLayout'] = renderObject.debugNeedsLayout;

    // Add specific properties based on render object type
    _addSpecificProperties(renderObject, node);

    // Recursively add children
    final children = <Map<String, dynamic>>[];
    renderObject.visitChildren((child) {
      children.add(_buildRenderTreeNode(child));
    });

    if (children.isNotEmpty) {
      node['children'] = children;
    }

    return node;
  }

  /// Add type-specific properties to the render tree node
  void _addSpecificProperties(
    RenderObject renderObject,
    Map<String, dynamic> node,
  ) {
    if (renderObject is RenderParagraph) {
      node['text'] = renderObject.text.toPlainText();
      node['textAlign'] = renderObject.textAlign.toString();
      node['maxLines'] = renderObject.maxLines;
    } else if (renderObject is RenderImage) {
      node['imageInfo'] = {
        'width': renderObject.image?.width,
        'height': renderObject.image?.height,
      };
    } else if (renderObject is RenderFlex) {
      node['direction'] = renderObject.direction.toString();
      node['mainAxisAlignment'] = renderObject.mainAxisAlignment.toString();
      node['crossAxisAlignment'] = renderObject.crossAxisAlignment.toString();
      node['mainAxisSize'] = renderObject.mainAxisSize.toString();
    } else if (renderObject is RenderStack) {
      node['stackInfo'] = {
        'alignment': renderObject.alignment.toString(),
        'fit': renderObject.fit.toString(),
      };
    } else if (renderObject is RenderDecoratedBox) {
      // Add decoration information
      node['hasDecoration'] = true;
    } else if (renderObject is RenderTransform) {
      node['hasTransform'] = true;
      // Transform matrix is complex, just indicate it exists
    }
  }

  /// Serialize BoxConstraints to a JSON-serializable format
  Map<String, dynamic> _serializeConstraints(BoxConstraints constraints) {
    return {
      'minWidth': _sanitizeDouble(constraints.minWidth),
      'maxWidth': _sanitizeDouble(constraints.maxWidth),
      'minHeight': _sanitizeDouble(constraints.minHeight),
      'maxHeight': _sanitizeDouble(constraints.maxHeight),
      'hasBoundedWidth': constraints.hasBoundedWidth,
      'hasBoundedHeight': constraints.hasBoundedHeight,
      'hasInfiniteWidth': constraints.hasInfiniteWidth,
      'hasInfiniteHeight': constraints.hasInfiniteHeight,
      'isTight': constraints.isTight,
      'isNormalized': constraints.isNormalized,
    };
  }

  /// Sanitize double values to handle Infinity and NaN for JSON serialization
  dynamic _sanitizeDouble(double value) {
    if (value.isInfinite) {
      return value.isNegative ? '-Infinity' : 'Infinity';
    }
    if (value.isNaN) {
      return 'NaN';
    }
    return value;
  }
}
