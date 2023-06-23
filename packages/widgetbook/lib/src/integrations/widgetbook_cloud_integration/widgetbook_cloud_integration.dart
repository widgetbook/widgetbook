import '../../state/state.dart';
import '../widgetbook_integration.dart';
import 'no_messaging.dart' if (dart.library.html) 'web_messaging.dart';

/// Integration for Widgetbook Cloud, that is used to sync addons and knobs
/// information with the host.
class WidgetbookCloudIntegration extends WidgetbookIntegration {
  @override
  void onInit(WidgetbookState state) {
    if (state.addons == null) return;

    final addonsJson = state.addons! //
        .map((addon) => addon.toJson())
        .toList();

    sendMessage({'addons': addonsJson});
  }

  @override
  void onKnobsRegistered(WidgetbookState state) {
    final knobsJson = state.knobs.values //
        .map((knob) => knob.toJson())
        .toList();

    sendMessage({'knobs': knobsJson});
  }
}
