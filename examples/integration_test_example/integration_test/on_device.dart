import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:widgetbook/snapshot.dart';
import 'package:widgetbook/widgetbook.dart';

/// The [IntegrationTestWidgetsFlutterBinding.reportData] key under which
/// per-scenario metadata is delivered to the host driver.
const widgetbookReportKey = 'widgetbook';

/// On-device counterpart of `testWidgetbook`.
///
/// Runs every scenario under [IntegrationTestWidgetsFlutterBinding] on a real
/// device or simulator, so widgets backed by platform textures/views (e.g.
/// `video_player`, `pdfrx`) render for real and are included in the captured
/// screenshot. `flutter test` cannot do this: its `OffsetLayer.toImage` only
/// rasterizes the Flutter layer tree, leaving native content blank.
///
/// The device file system is sandboxed and remote from the host, so results
/// are handed back through the integration-test driver rather than written
/// directly: screenshot bytes via `takeScreenshot`/`onScreenshot`, and the
/// per-scenario [ScenarioMetadata] JSON via the binding's `reportData` under
/// [widgetbookReportKey], keyed by the target PNG path.
///
/// Tests are declared synchronously — the integration-test runner begins
/// before an async `main` resumes, so an `await` before `group()` throws
/// "Can't call group() once tests have begun running".
void testWidgetbookOnDevice(Config config) {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  for (final component in config.components) {
    group(component.name, () {
      for (final story in component.stories) {
        group(story.name, () {
          for (final scenario in story.allScenarios(config)) {
            _testScenarioOnDevice(binding, config, scenario);
          }
        });
      }
    });
  }
}

void _testScenarioOnDevice(
  IntegrationTestWidgetsFlutterBinding binding,
  Config config,
  Scenario scenario,
) {
  testWidgets(scenario.name, (tester) async {
    final semanticsHandle = tester.binding.ensureSemantics();

    Future<void> body() async {
      final key = UniqueKey();
      await tester.pumpWidget(
        Builder(
          key: key,
          builder: (context) => scenario.buildWithConfig(context, config),
        ),
      );

      await config.scenarioConfig.setUp?.call(tester, scenario);
      await scenario.execute(tester);
      await tester.pump();

      final semanticsNode = tester.getSemantics(find.byKey(key));
      final semanticsData = SemanticsTreeSerializer.toJson(semanticsNode);
      final pixelRatio = tester.view.devicePixelRatio;

      // The screenshot name is the target PNG path; the driver writes the
      // bytes there and derives the sibling `.json` path from it.
      final imagePath = _metadata(
        scenario,
        Uint8List(0),
        0,
        0,
        pixelRatio,
        const {},
      ).imageFile.path;

      final rawBytes = await binding.takeScreenshot(imagePath);
      final bytes = Uint8List.fromList(rawBytes);

      final metadata = _metadata(
        scenario,
        bytes,
        _pngUint32(bytes, 16),
        _pngUint32(bytes, 20),
        pixelRatio,
        semanticsData,
      );

      binding.reportData ??= <String, dynamic>{};
      final store =
          (binding.reportData![widgetbookReportKey] ??= <String, dynamic>{})
              as Map<String, dynamic>;
      store[metadata.imageFile.path] = metadata.toJson();

      await config.scenarioConfig.tearDown?.call(tester, scenario);
    }

    final wrapper = config.scenarioConfig.wrapper;
    await (wrapper == null ? body() : wrapper(tester, scenario, body));

    semanticsHandle.dispose();
    addTearDown(tester.view.reset);
  });
}

ScenarioMetadata _metadata(
  Scenario scenario,
  Uint8List bytes,
  int width,
  int height,
  double pixelRatio,
  Map<String, dynamic> semantics,
) {
  return ScenarioMetadata(
    scenario: scenario,
    imageBytes: bytes,
    imageWidth: width,
    imageHeight: height,
    pixelRatio: pixelRatio,
    semanticsData: semantics,
  );
}

/// Reads a big-endian uint32 from a PNG byte stream. Width/height live in the
/// IHDR chunk at byte offsets 16 and 20 respectively.
int _pngUint32(Uint8List b, int offset) =>
    (b[offset] << 24) |
    (b[offset + 1] << 16) |
    (b[offset + 2] << 8) |
    b[offset + 3];
