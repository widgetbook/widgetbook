import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import '../guideline.dart';
import '../guideline_violation.dart';
import '../violation_node.dart';
import 'guideline_utils.dart';

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
    final isTappable =
        data.hasAction(ui.SemanticsAction.tap) ||
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
