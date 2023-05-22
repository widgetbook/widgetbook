import '../state/state.dart';

/// Integrations are like lifecycle hooks that notifies implementer
/// about [WidgetbookState] changes.
abstract class WidgetbookIntegration {
  void onInit(WidgetbookState state) {}
  void onChange(WidgetbookState state) {}
}
