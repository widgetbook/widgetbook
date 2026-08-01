import 'dart:convert';
import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

import 'report_key.dart';

/// Host side of `testWidgetbookOnDevice`. Run it from `test_driver/` under
/// `flutter drive`; it writes the two streams the device produces into
/// `build/.widgetbook`, the layout the Widgetbook CLI reads:
///   - screenshot bytes (via `onScreenshot`) to the PNG path the device chose;
///   - per-scenario metadata (via `reportData`) to the sibling `.json` path,
///     overwriting the PNG with cropped bytes when a viewport was applied.
///
/// This library imports no Flutter UI code, so it is safe to import from a
/// driver script running in the `flutter drive` VM.
Future<void> widgetbookIntegrationDriver() async {
  await integrationDriver(
    onScreenshot: (name, bytes, [args]) async {
      final file = File(name);
      await file.parent.create(recursive: true);
      await file.writeAsBytes(bytes);
      return true;
    },
    responseDataCallback: (data) async {
      final store =
          (data?[widgetbookReportKey] as Map<String, dynamic>?) ??
          const <String, dynamic>{};
      const encoder = JsonEncoder.withIndent('  ');

      for (final entry in store.entries) {
        final value = entry.value as Map<String, dynamic>;

        // A cropped (viewport) scenario ships its final PNG bytes here; they
        // replace the full-screen bytes onScreenshot already wrote.
        final png = value['png'];
        if (png != null) {
          final imageFile = File(entry.key);
          await imageFile.parent.create(recursive: true);
          await imageFile.writeAsBytes((png as List).cast<int>());
        }

        final jsonPath = entry.key.replaceAll(RegExp(r'\.png$'), '.json');
        final jsonFile = File(jsonPath);
        await jsonFile.parent.create(recursive: true);
        await jsonFile.writeAsString(encoder.convert(value['metadata']));
      }
    },
  );
}
