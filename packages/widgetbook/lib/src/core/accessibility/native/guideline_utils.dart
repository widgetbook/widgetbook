import 'package:flutter/rendering.dart';

/// The global bounds of [node] in physical pixels, composed from the transform
/// chain up to the root.
Rect globalRect(SemanticsNode node) {
  var bounds = node.rect;
  SemanticsNode? current = node;
  while (current != null) {
    final transform = current.transform;
    if (transform != null) {
      bounds = MatrixUtils.transformRect(transform, bounds);
    }
    current = current.parent;
  }
  return bounds;
}

/// Whether [child] touches the edge of [parent] (within a small tolerance).
bool isAtBoundary(Rect child, Rect parent) {
  const gap = 0.001;
  final inside =
      child.left - parent.left > gap &&
      parent.right - child.right > gap &&
      child.top - parent.top > gap &&
      parent.bottom - child.bottom > gap;
  return !inside;
}

/// The semantics [SemanticsData.role] name, or null for the uninformative
/// `none`/`generic` roles.
String? roleName(SemanticsData data) {
  final name = data.role.name;
  if (name == 'none' || name == 'generic') return null;
  return name;
}

/// A [Rect] as `[left, top, right, bottom]` for JSON serialization.
List<double> rectToList(Rect rect) => [
  rect.left,
  rect.top,
  rect.right,
  rect.bottom,
];

/// A [Size] formatted as `width×height` with integers where possible.
String formatSize(Size size) =>
    '${_formatNumber(size.width)}×${_formatNumber(size.height)}';

String _formatNumber(double value) {
  return value == value.roundToDouble()
      ? value.toInt().toString()
      : value.toStringAsFixed(1);
}
