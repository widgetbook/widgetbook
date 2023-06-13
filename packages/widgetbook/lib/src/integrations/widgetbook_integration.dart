import '../state/state.dart';
import '../widgetbook.dart';
import 'widgetbook_cloud_integration/widgetbook_cloud_integration.dart';

/// Integrations are like lifecycle hooks that notifies implementer
/// about [WidgetbookState] changes.
///
/// See also:
///
/// * [WidgetbookCloudIntegration], integrates your widget library with
/// Widgetbook Cloud.
abstract class WidgetbookIntegration {
  /// Gets called on first launch of [Widgetbook] with the initial [state].
  void onInit(WidgetbookState state) {}

  /// Gets called on every [WidgetbookState] change.
  void onChange(WidgetbookState state) {}
}
