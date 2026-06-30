import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'guideline.dart';

/// Minimum tap-target size guideline. Reimplements Flutter's
/// `MinimumTapTargetGuideline` but reports each offending node individually.
///
/// Note: unlike the framework version, this does not special-case targets
/// partially scrolled off-screen inside an implicit scrollable.
class MinTapTargetGuideline extends WidgetbookGuideline {
  const MinTapTargetGuideline({
    required this.id,
    required this.size,
    this.helpUrl,
  });

  @override
  final String id;

  /// Minimum allowed size in logical pixels.
  final Size size;

  final String? helpUrl;

  @override
  Future<List<GuidelineViolation>> evaluate(WidgetTester tester) async {
    final nodes = <ViolationNode>[];

    for (final view in tester.binding.renderViews) {
      final root = view.owner?.semanticsOwner?.rootSemanticsNode;
      if (root == null) continue;

      final pixelRatio = view.flutterView.devicePixelRatio;
      final viewRect = Offset.zero & view.flutterView.physicalSize;
      _visit(root, pixelRatio, viewRect, nodes);
    }

    if (nodes.isEmpty) return const [];
    return [
      GuidelineViolation(
        guidelineId: id,
        title: 'Tap target too small',
        helpUrl: helpUrl,
        nodes: nodes,
      ),
    ];
  }

  void _visit(
    SemanticsNode node,
    double pixelRatio,
    Rect viewRect,
    List<ViolationNode> out,
  ) {
    node.visitChildren((child) {
      _visit(child, pixelRatio, viewRect, out);
      return true;
    });

    if (node.isMergedIntoParent) return;

    final data = node.getSemanticsData();
    final isTappable = data.hasAction(ui.SemanticsAction.tap) ||
        data.hasAction(ui.SemanticsAction.longPress);
    // Links are exempt per WCAG; hidden nodes don't count.
    if (!isTappable || data.flagsCollection.isHidden || data.flagsCollection.isLink) {
      return;
    }

    final bounds = globalRect(node);
    if (isAtBoundary(bounds, viewRect)) return;

    final candidate = bounds.size / pixelRatio;
    final tooSmall = candidate.width < size.width - precisionErrorTolerance ||
        candidate.height < size.height - precisionErrorTolerance;
    if (!tooSmall) return;

    out.add(
      ViolationNode(
        label: data.label.isEmpty ? null : data.label,
        role: roleName(data),
        rect: rectToList(bounds),
        message: 'Expected at least ${formatSize(size)}, '
            'found ${formatSize(candidate)}',
      ),
    );
  }
}

/// Tappable-labeling guideline. Reimplements Flutter's
/// `LabeledTapTargetGuideline` with per-node output: every node with a tap or
/// long-press action must have a label or tooltip.
class LabeledTappableGuideline extends WidgetbookGuideline {
  const LabeledTappableGuideline({
    this.id = 'labeled-tappable',
    this.helpUrl,
  });

  @override
  final String id;

  final String? helpUrl;

  @override
  Future<List<GuidelineViolation>> evaluate(WidgetTester tester) async {
    final nodes = <ViolationNode>[];

    for (final view in tester.binding.renderViews) {
      final root = view.owner?.semanticsOwner?.rootSemanticsNode;
      if (root != null) _visit(root, nodes);
    }

    if (nodes.isEmpty) return const [];
    return [
      GuidelineViolation(
        guidelineId: id,
        title: 'Tappable without a label',
        helpUrl: helpUrl,
        nodes: nodes,
      ),
    ];
  }

  void _visit(SemanticsNode node, List<ViolationNode> out) {
    node.visitChildren((child) {
      _visit(child, out);
      return true;
    });

    if (node.isMergedIntoParent ||
        node.isInvisible ||
        node.flagsCollection.isHidden ||
        node.flagsCollection.isTextField) {
      return;
    }

    final data = node.getSemanticsData();
    final isTappable = data.hasAction(ui.SemanticsAction.tap) ||
        data.hasAction(ui.SemanticsAction.longPress);
    if (!isTappable) return;

    if (data.label.isEmpty && data.tooltip.isEmpty) {
      out.add(
        ViolationNode(
          role: roleName(data),
          rect: rectToList(globalRect(node)),
          message: 'Tappable node has no semantic label or tooltip.',
        ),
      );
    }
  }
}

/// The global bounds of [node] in physical pixels, composed from the transform
/// chain up to the root.
@visibleForTesting
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
@visibleForTesting
bool isAtBoundary(Rect child, Rect parent) {
  const gap = 0.001;
  final inside = child.left - parent.left > gap &&
      parent.right - child.right > gap &&
      child.top - parent.top > gap &&
      parent.bottom - child.bottom > gap;
  return !inside;
}

String? roleName(SemanticsData data) {
  final name = data.role.name;
  if (name == 'none' || name == 'generic') return null;
  return name;
}

List<double> rectToList(Rect rect) => [rect.left, rect.top, rect.right, rect.bottom];

String formatSize(Size size) => '${_formatNumber(size.width)}×${_formatNumber(size.height)}';

String _formatNumber(double value) {
  return value == value.roundToDouble()
      ? value.toInt().toString()
      : value.toStringAsFixed(1);
}
