import 'dart:convert';
import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

import 'report_key.dart';

/// Host side of `testWidgetbookOnDevice`. Run it from a `test_driver/` script
/// under `flutter drive`; it writes the device's screenshots and metadata into
/// `build/.widgetbook`, the layout the Widgetbook CLI reads. Imports no Flutter
/// UI code, so it is safe in the `flutter drive` VM.
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

        // Cropped scenarios ship final bytes here, replacing the full-screen
        // PNG onScreenshot already wrote.
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
