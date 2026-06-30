import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import '../guideline.dart';
import '../guideline_violation.dart';
import '../violation_node.dart';
import 'guideline_utils.dart';

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
    final isTappable =
        data.hasAction(ui.SemanticsAction.tap) ||
        data.hasAction(ui.SemanticsAction.longPress);
    // Links are exempt per WCAG; hidden nodes don't count.
    if (!isTappable ||
        data.flagsCollection.isHidden ||
        data.flagsCollection.isLink) {
      return;
    }

    final bounds = globalRect(node);
    if (isAtBoundary(bounds, viewRect)) return;

    final candidate = bounds.size / pixelRatio;
    final tooSmall =
        candidate.width < size.width - precisionErrorTolerance ||
        candidate.height < size.height - precisionErrorTolerance;
    if (!tooSmall) return;

    out.add(
      ViolationNode(
        id: node.id,
        label: data.label.isEmpty ? null : data.label,
        role: roleName(data),
        rect: rectToList(bounds),
        message:
            'Expected at least ${formatSize(size)}, '
            'found ${formatSize(candidate)}',
      ),
    );
  }
}
