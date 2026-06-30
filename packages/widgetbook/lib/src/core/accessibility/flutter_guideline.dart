/// @docImport 'violation_node.dart';
library;

import 'package:flutter_test/flutter_test.dart';

import 'guideline.dart';
import 'guideline_violation.dart';

/// Adapts a Flutter [AccessibilityGuideline] into a [WidgetbookGuideline].
///
/// Flutter's built-in guidelines only report a coarse text [Evaluation.reason]
/// (and merge all failing nodes into one string), so the resulting
/// [GuidelineViolation] has no structured [ViolationNode]s. Use a native
/// [WidgetbookGuideline] when you need per-node anchoring; use this to run any
/// existing or custom Flutter guideline as-is.
class FlutterGuideline extends WidgetbookGuideline {
  const FlutterGuideline(
    this.guideline, {
    required this.id,
    this.helpUrl,
  });

  final AccessibilityGuideline guideline;

  @override
  final String id;

  final String? helpUrl;

  @override
  Future<List<GuidelineViolation>> evaluate(WidgetTester tester) async {
    final evaluation = await guideline.evaluate(tester);
    if (evaluation.passed) return const [];

    return [
      GuidelineViolation(
        guidelineId: id,
        title: guideline.description,
        helpUrl: helpUrl,
        reason: evaluation.reason,
      ),
    ];
  }
}
