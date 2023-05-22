import 'package:flutter/foundation.dart';

import '../../state/state.dart';
import '../widgetbook_integration.dart';
import 'no_messaging.dart' if (dart.library.html) 'web_messaging.dart';

/// Integration for Widgetbook Cloud, that is used to sync addons and knobs
/// information with the host.
class WidgetbookCloudIntegration extends WidgetbookIntegration {
  @override
  void onInit(WidgetbookState state) {
    if (!kIsWeb) return;

    final addonsJsonEntries = state.addons.map(
      (addon) => MapEntry(
        addon.slugName,
        addon.fields.map((field) => field.toFullJson()).toList(),
      ),
    );

    sendMessage(
      Map.fromEntries(addonsJsonEntries),
    );
  }
}
