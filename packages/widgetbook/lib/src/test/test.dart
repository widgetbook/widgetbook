import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../widgetbook.dart';
import 'font_loader.dart';
import 'snapshot_runner.dart';

/// The default location is already an ignored path by default.
const outputDir = 'build/.widgetbook';

/// Generates a snapshot for every scenario in [config] headlessly under
/// `flutter test`, optionally narrowed to the components matching [where].
///
/// Widgets backed by platform textures/views (e.g. `video_player`, `pdfrx`)
/// render blank here because there is no real engine or GPU — only the Flutter
/// layer tree is rasterized. For those, use `testWidgetbookOnDevice` from
/// `package:widgetbook/integration_test.dart`, which runs on a device/simulator.
/// The two share the same `where` filter, so a project can partition its
/// components between the fast headless run and the on-device run.
Future<void> testWidgetbook(
  Config config, {
  bool Function(Component component)? where,
}) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await loadFonts();
  declareSnapshotTests(config, const _LayerStrategy(), where: where);
}

/// Headless capture strategy: rasterizes the Flutter layer tree offscreen via
/// [captureImage] and writes the results straight to disk.
class _LayerStrategy extends SnapshotStrategy {
  const _LayerStrategy();

  @override
  void applyViewport(WidgetTester tester, ViewportData viewport) {
    tester.view.physicalConstraints = viewport.viewConstraints;
    tester.view.devicePixelRatio = viewport.pixelRatio;
  }

  @override
  Future<void> captureAndPersist({
    required WidgetTester tester,
    required Scenario scenario,
    required Key key,
    required ViewportData viewport,
    required Map<String, dynamic> semantics,
    required List<Map<String, dynamic>> violations,
  }) async {
    final element = tester.element(find.byKey(key));
    final imageFuture = captureImage(element, 1);

    // Run on a real event loop as async operations cannot be run inside
    // testWidgets directly.
    await TestWidgetsFlutterBinding.instance.runAsync(() async {
      final image = await imageFuture;
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();

      final metadata = buildScenarioMetadata(
        scenario,
        CapturedSnapshot(
          bytes: bytes,
          width: image.width,
          height: image.height,
          pixelRatio: viewport.pixelRatio,
        ),
        semantics,
        violations,
      );

      await metadata.directory.create(recursive: true);
      await Future.wait([
        metadata.imageFile.writeAsBytes(bytes, flush: true),
        metadata.jsonFile.writeAsString(
          const JsonEncoder.withIndent('  ').convert(metadata),
          flush: true,
        ),
      ]);

      image.dispose();
    });
  }
}

/// Same as `captureImage` from `flutter_test` but has [pixelRatio] parameter.
Future<Image> captureImage(
  Element element,
  double pixelRatio,
) async {
  var renderObject = element.renderObject!;
  while (!renderObject.isRepaintBoundary) {
    renderObject = renderObject.parent!;
  }

  final layer = renderObject.debugLayer! as OffsetLayer;
  return layer.toImage(
    renderObject.paintBounds,
    pixelRatio: pixelRatio,
  );
}
