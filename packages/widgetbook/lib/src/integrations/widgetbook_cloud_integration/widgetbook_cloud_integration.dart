import 'package:flutter/foundation.dart';

import '../../state/state.dart';
import '../widgetbook_integration.dart';
import 'no_messaging.dart' if (dart.library.html) 'web_messaging.dart';

/// Integration for Widgetbook Cloud, that is used to sync addons and knobs
/// information with the host.
class WidgetbookCloudIntegration extends WidgetbookIntegration {
  @visibleForTesting
  void notifyCloud(
    String title,
    List<Map<String, dynamic>> data,
  ) {
    sendMessage({title: data});
  }

  @override
  void onInit(WidgetbookState state) {
    if (state.effectiveAddons == null) return;

    final addonsJson = state.effectiveAddons! //
        .map((addon) => addon.toJson())
        .toList();

    notifyCloud('addons', addonsJson);
  }

  @override
  void onKnobsRegistered(WidgetbookState state) {
    final knobsJson = state.knobs.values //
        .map((knob) => knob.toJson())
        .toList();

    notifyCloud('knobs', knobsJson);
  }
}
