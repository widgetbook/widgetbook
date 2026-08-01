import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../widgetbook.dart';
import 'font_loader.dart';
import 'report_key.dart';
import 'scenario_metadata.dart';
import 'snapshot_runner.dart';

/// On-device counterpart of `testWidgetbook`.
///
/// Runs every scenario (optionally narrowed by [where]) under
/// [IntegrationTestWidgetsFlutterBinding] on a real device or simulator, so
/// widgets backed by platform textures/views (e.g. `video_player`, `pdfrx`)
/// render for real and appear in the captured screenshot — unlike headless
/// `testWidgetbook`, whose offscreen layer rasterization leaves them blank.
///
/// Because the device file system is remote from the host, results are handed
/// back through the integration-test driver: screenshot bytes via
/// `takeScreenshot`, and the per-scenario [ScenarioMetadata] via the binding's
/// `reportData`. Pair it with `widgetbookIntegrationDriver` from
/// `package:widgetbook/integration_test_driver.dart` and run via `flutter drive`.
///
/// Use [where] to opt only selected components into on-device capture while the
/// rest stay on the faster headless path (mark those `excludeFromTests` there):
///
/// ```dart
/// void main() => testWidgetbookOnDevice(
///       config,
///       where: (component) => component.name == 'VideoPlayer',
///     );
/// ```
void testWidgetbookOnDevice(
  Config config, {
  bool Function(Component component)? where,
}) {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Fonts must be loaded before tests run, but tests are declared
  // synchronously — the integration-test runner begins before an async `main`
  // resumes, so awaiting before declaring throws "Can't call group() once
  // tests have begun running". Defer the load into setUpAll instead.
  setUpAll(loadFonts);

  declareSnapshotTests(config, _IntegrationTestStrategy(binding), where: where);
}

/// On-device capture strategy: reads back the real composited surface via
/// `takeScreenshot` and hands bytes + metadata to the host driver.
class _IntegrationTestStrategy extends SnapshotStrategy {
  _IntegrationTestStrategy(this.binding);

  final IntegrationTestWidgetsFlutterBinding binding;

  @override
  Future<void> captureAndPersist({
    required WidgetTester tester,
    required Scenario scenario,
    required Key key,
    required ViewportData viewport,
    required Map<String, dynamic> semantics,
    required List<Map<String, dynamic>> violations,
  }) async {
    final pixelRatio = tester.view.devicePixelRatio;

    // The screenshot name is the target PNG path; the driver writes the bytes
    // there and derives the sibling `.json` path from it.
    final imagePath = buildScenarioMetadata(
      scenario,
      CapturedSnapshot(
        bytes: Uint8List(0),
        width: 0,
        height: 0,
        pixelRatio: pixelRatio,
      ),
      const {},
      const [],
    ).imageFile.path;

    final raw = await binding.takeScreenshot(imagePath);
    var bytes = Uint8List.fromList(raw);

    // A `ViewportMode` on the scenario makes `ViewportAddon` size the use case
    // to the viewport (centered) during build; crop the physical screenshot to
    // it. Unlike the offscreen headless path, the viewport cannot exceed the
    // device screen and renders at the device's own pixel ratio.
    final framed = viewport.maxWidth.isFinite && viewport.maxHeight.isFinite;
    if (framed) {
      final screen = tester.view.physicalSize;
      final w = viewport.maxWidth * pixelRatio;
      final h = viewport.maxHeight * pixelRatio;
      bytes = await _cropPng(
        bytes,
        (screen.width - w) / 2,
        (screen.height - h) / 2,
        w,
        h,
      );
    }

    final metadata = buildScenarioMetadata(
      scenario,
      CapturedSnapshot(
        bytes: bytes,
        width: _pngUint32(bytes, 16),
        height: _pngUint32(bytes, 20),
        pixelRatio: pixelRatio,
      ),
      semantics,
      violations,
    );

    binding.reportData ??= <String, dynamic>{};
    final store =
        (binding.reportData![widgetbookReportKey] ??= <String, dynamic>{})
            as Map<String, dynamic>;
    // `takeScreenshot` already streamed the full-screen bytes to the driver's
    // onScreenshot. When cropped, ship the cropped bytes so the driver
    // overwrites the PNG to match the metadata.
    store[metadata.imageFile.path] = {
      'metadata': metadata.toJson(),
      if (framed) 'png': bytes,
    };
  }
}

/// Crops [png] to the given physical-pixel rectangle and re-encodes it.
Future<Uint8List> _cropPng(
  Uint8List png,
  double left,
  double top,
  double width,
  double height,
) async {
  final codec = await ui.instantiateImageCodec(png);
  final frame = await codec.getNextFrame();
  final source = frame.image;

  final w = width.round();
  final h = height.round();
  final recorder = ui.PictureRecorder();
  ui.Canvas(recorder).drawImageRect(
    source,
    ui.Rect.fromLTWH(left, top, width, height),
    ui.Rect.fromLTWH(0, 0, w.toDouble(), h.toDouble()),
    ui.Paint(),
  );
  final cropped = await recorder.endRecording().toImage(w, h);
  final data = await cropped.toByteData(format: ui.ImageByteFormat.png);

  source.dispose();
  cropped.dispose();
  return data!.buffer.asUint8List();
}

/// Reads a big-endian uint32 from a PNG byte stream. Width/height live in the
/// IHDR chunk at byte offsets 16 and 20 respectively.
int _pngUint32(Uint8List b, int offset) =>
    (b[offset] << 24) |
    (b[offset + 1] << 16) |
    (b[offset + 2] << 8) |
    b[offset + 3];
