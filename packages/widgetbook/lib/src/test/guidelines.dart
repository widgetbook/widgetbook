import 'package:flutter_test/flutter_test.dart';

/// The accessibility guidelines evaluated for every scenario by default.
///
/// These are Flutter's built-in [AccessibilityGuideline]s. The contrast
/// guideline samples the rendered image and is approximate — treat its results
/// as advisory.
const defaultGuidelines = <AccessibilityGuideline>[
  androidTapTargetGuideline,
  iOSTapTargetGuideline,
  labeledTapTargetGuideline,
  textContrastGuideline,
];

/// A stable identifier for a guideline, used as the violation key.
String guidelineId(AccessibilityGuideline guideline) {
  if (identical(guideline, androidTapTargetGuideline)) {
    return 'tap-target-android';
  }
  if (identical(guideline, iOSTapTargetGuideline)) return 'tap-target-ios';
  if (identical(guideline, labeledTapTargetGuideline)) {
    return 'labeled-tap-target';
  }
  if (identical(guideline, textContrastGuideline)) return 'text-contrast';
  return guideline.runtimeType.toString();
}

/// Evaluates each of the [guidelines] against the currently pumped widget tree and
/// returns the failures as JSON-serializable maps. A guideline that throws is
/// recorded as an `error` entry instead of failing the capture, so one flaky
/// check never blocks a snapshot.
Future<List<Map<String, dynamic>>> evaluateGuidelines(
  WidgetTester tester,
  List<AccessibilityGuideline> guidelines,
) async {
  final violations = <Map<String, dynamic>>[];

  for (final guideline in guidelines) {
    try {
      final evaluation = await guideline.evaluate(tester);
      if (!evaluation.passed) {
        violations.add({
          'id': guidelineId(guideline),
          'description': guideline.description,
          'reason': evaluation.reason,
        });
      }
    } catch (error) {
      violations.add({
        'id': guidelineId(guideline),
        'description': guideline.description,
        'error': error.toString(),
      });
    }
  }

  return violations;
}
