/// @docImport '../../test/test.dart';
/// @docImport '../framework/config.dart';
library;

import 'guidelines.dart';

/// Accessibility configuration applied to every scenario captured by
/// [testWidgetbook], referenced from [Config.accessibilityConfig].
///
/// Holds the [WidgetbookGuideline]s evaluated against each captured scenario;
/// the resulting violations are written into the scenario's metadata.
class AccessibilityConfig {
  const AccessibilityConfig({
    this.guidelines = WidgetbookGuidelines.recommended,
  });

  /// The accessibility guidelines evaluated for every captured scenario.
  ///
  /// Defaults to [WidgetbookGuidelines.recommended]. Pass `const []` to
  /// disable accessibility evaluation, or provide a custom list — optionally
  /// spreading [WidgetbookGuidelines.recommended] — to extend the defaults.
  final List<WidgetbookGuideline> guidelines;
}
