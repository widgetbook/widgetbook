import 'dart:convert';
import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

/// Must match `widgetbookReportKey` in `package:widgetbook/integration_test.dart`.
const _reportKey = 'widgetbook';

/// Host side of the on-device snapshot run. Writes the two streams the device
/// produces into `build/.widgetbook`, the layout the Widgetbook CLI reads:
///   - screenshot bytes (via `onScreenshot`) to the PNG path the device chose,
///   - per-scenario metadata (via `reportData`) to the sibling `.json` path.
Future<void> main() async {
  await integrationDriver(
    onScreenshot: (
      String name,
      List<int> bytes, [
      Map<String, Object?>? args,
    ]) async {
      // widgetbook scenarios pass their target PNG path as the screenshot
      // name; the m0 smoke test passes a bare label.
      final path =
          name.endsWith('.png') ? name : 'build/m0_screenshots/$name.png';
      final file = File(path);
      await file.parent.create(recursive: true);
      await file.writeAsBytes(bytes);
      stderr.writeln('PNG  $path (${bytes.length} bytes)');
      return true;
    },
    responseDataCallback: (data) async {
      final store = (data?[_reportKey] as Map<String, dynamic>?) ?? const {};
      const encoder = JsonEncoder.withIndent('  ');
      for (final entry in store.entries) {
        final jsonPath = entry.key.replaceAll(RegExp(r'\.png$'), '.json');
        final file = File(jsonPath);
        await file.parent.create(recursive: true);
        await file.writeAsString(encoder.convert(entry.value));
        stderr.writeln('JSON $jsonPath');
      }
    },
  );
}
