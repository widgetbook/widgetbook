import 'package:flutter_test/flutter_test.dart';

import 'guideline_violation.dart';

/// Evaluates a pumped widget tree against an accessibility guideline and
/// returns structured violations.
///
/// Implement this to provide custom guidelines, or wrap a Flutter
/// [AccessibilityGuideline] with `FlutterGuideline`.
abstract class WidgetbookGuideline {
  const WidgetbookGuideline();

  /// A stable identifier used as the violation key (e.g. `tap-target-android`).
  String get id;

  Future<List<GuidelineViolation>> evaluate(WidgetTester tester);
}

/// Runs each of the [guidelines] against the currently pumped tree and collects
/// all violations. A guideline that throws is recorded as a violation with a
/// `reason` instead of failing the capture, so one flaky check never blocks a
/// snapshot.
Future<List<GuidelineViolation>> evaluateGuidelines(
  WidgetTester tester,
  List<WidgetbookGuideline> guidelines,
) async {
  final violations = <GuidelineViolation>[];

  for (final guideline in guidelines) {
    try {
      violations.addAll(await guideline.evaluate(tester));
    } catch (error) {
      violations.add(
        GuidelineViolation(
          guidelineId: guideline.id,
          title: guideline.id,
          reason: 'Guideline evaluation threw: $error',
        ),
      );
    }
  }

  return violations;
}
