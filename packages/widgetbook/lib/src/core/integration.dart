import '../state/state.dart';
import 'core.dart';

/// Integrations are like lifecycle hooks that notifies implementer
/// about [WidgetbookState] changes.
abstract class Integration {
  /// Gets called on first launch with the initial [state].
  void onInit(WidgetbookState state) {}

  /// Gets called when story changes.
  void onStoryChange(Story story) {}

  /// Gets called on every [WidgetbookState] change.
  void onChange(WidgetbookState state) {}
}
