import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../widgetbook.dart';
import 'font_loader.dart';
import 'report_key.dart';
import 'snapshot_runner.dart';

/// On-device counterpart of `testWidgetbook`, run via `flutter drive` on a real
/// device or simulator so widgets backed by platform textures/views (e.g.
/// `video_player`, `pdfrx`) render for real instead of appearing blank.
///
/// Pair it with `widgetbookIntegrationDriver` from
/// `package:widgetbook/integration_test_driver.dart`. Use [where] to route only
/// selected components on-device while the rest stay on `testWidgetbook`:
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

  // Tests are declared synchronously (the runner starts before an async `main`
  // resumes), so defer font loading into setUpAll rather than awaiting here.
  setUpAll(loadFonts);

  declareSnapshotTests(config, _IntegrationTestStrategy(binding), where: where);
}

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

    // Pass the target PNG path as the screenshot name so the driver knows where
    // to write it.
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

    // A viewport is sized (centered) by ViewportAddon during build; crop the
    // physical screenshot to it. It cannot exceed the device screen.
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
    // Ship the cropped bytes so the driver can replace the full-screen PNG that
    // takeScreenshot already streamed to it.
    store[metadata.imageFile.path] = {
      'metadata': metadata.toJson(),
      if (framed) 'png': bytes,
    };
  }
}

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

/// Reads a big-endian uint32 from a PNG's IHDR chunk (width at 16, height at 20).
int _pngUint32(Uint8List b, int offset) =>
    (b[offset] << 24) |
    (b[offset + 1] << 16) |
    (b[offset + 2] << 8) |
    b[offset + 3];
