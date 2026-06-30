import 'package:flutter_test/flutter_test.dart';

/// A single node that violated a guideline.
class ViolationNode {
  const ViolationNode({
    this.label,
    this.role,
    this.rect,
    required this.message,
  });

  final String? label;
  final String? role;

  /// Global bounds in physical pixels as `[left, top, right, bottom]`, matching
  /// the captured screenshot. Lets a consumer highlight the node on the image.
  final List<double>? rect;

  /// A concise, human-readable description of the failure.
  final String message;

  Map<String, dynamic> toJson() => {
        if (label != null) 'label': label,
        if (role != null) 'role': role,
        if (rect != null) 'rect': rect,
        'message': message,
      };
}

/// A guideline failure, optionally pinned to one or more [nodes].
class GuidelineViolation {
  const GuidelineViolation({
    required this.guidelineId,
    required this.title,
    this.helpUrl,
    this.nodes = const [],
    this.reason,
  });

  final String guidelineId;
  final String title;
  final String? helpUrl;

  /// The offending nodes. Empty for adapted [AccessibilityGuideline]s, which
  /// only report a coarse [reason].
  final List<ViolationNode> nodes;

  /// Raw text from an adapted guideline — for "details" only, not primary UI.
  final String? reason;

  Map<String, dynamic> toJson() => {
        'id': guidelineId,
        'title': title,
        if (helpUrl != null) 'helpUrl': helpUrl,
        if (nodes.isNotEmpty) 'nodes': nodes.map((node) => node.toJson()).toList(),
        if (reason != null) 'reason': reason,
      };
}

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

/// Runs each of the [guidelines] against the currently pumped tree and collects all
/// violations. A guideline that throws is recorded as a violation with a
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
