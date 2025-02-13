import '../state/state.dart';
import '../widgetbook.dart';

/// Integrations are like lifecycle hooks that notifies implementer
/// about [WidgetbookState] changes.
abstract class WidgetbookIntegration {
  /// Gets called on first launch of [Widgetbook] with the initial [state].
  void onInit(WidgetbookState state) {}

  /// Gets called when all knobs are registered after.
  void onKnobsRegistered(WidgetbookState state) {}

  /// Gets called on every [WidgetbookState] change.
  void onChange(WidgetbookState state) {}
}
