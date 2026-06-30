import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'flutter_guideline.dart';
import 'guideline.dart';
import 'native/native_guidelines.dart';

export 'flutter_guideline.dart';
export 'guideline.dart';
export 'guideline_violation.dart';
export 'native/native_guidelines.dart';
export 'violation_node.dart';

/// Widgetbook's curated accessibility guideline set, evaluated by
/// `testWidgetbook` unless overridden.
///
/// Tap-target and labeled-tappable are native (per-node) reimplementations;
/// contrast is adapted from Flutter's built-in guideline and is text-only and
/// approximate — treat it as advisory.
abstract final class WidgetbookGuidelines {
  static const recommended = <WidgetbookGuideline>[
    MinTapTargetGuideline(
      id: 'tap-target-android',
      size: Size(48, 48),
      helpUrl:
          'https://support.google.com/accessibility/android/answer/7101858',
    ),
    MinTapTargetGuideline(
      id: 'tap-target-ios',
      size: Size(44, 44),
      helpUrl:
          'https://developer.apple.com/design/human-interface-guidelines/accessibility',
    ),
    LabeledTappableGuideline(),
    FlutterGuideline(textContrastGuideline, id: 'text-contrast'),
  ];
}
