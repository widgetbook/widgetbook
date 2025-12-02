import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../widgetbook.dart';
import 'font_loader.dart';
import 'scenario_metadata.dart';

/// The default location is already an ignored path by default.
const outputDir = 'build/.widgetbook';

Future<void> testWidgetbook(Config config) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await loadFonts();

  for (final component in config.components) {
    testComponent(config, component);
  }
}

void testComponent(Config config, Component component) {
  group('${component.name}', () {
    for (final story in component.stories) {
      testStory(config, story);
    }
  });
}

void testStory(Config config, Story story) {
  group(story.name, () {
    final scenarios = story.allScenarios(config);
    for (final scenario in scenarios) {
      testScenario(config, scenario);
    }
  });
}

void testScenario(
  Config config,
  Scenario scenario,
) {
  final defaultViewport = Viewports.none;
  final targetViewport = scenario.viewport ?? defaultViewport;

  testWidgets(
    scenario.name,
    (tester) async {
      tester.view.physicalConstraints = targetViewport.viewConstraints;
      tester.view.devicePixelRatio = targetViewport.pixelRatio;

      final key = UniqueKey();
      await tester.pumpWidget(
        Builder(
          key: key,
          builder: (context) => scenario.buildWithConfig(context, config),
        ),
      );

      await scenario.execute(tester);

      final element = tester.element(find.byKey(key));
      final imageFuture = captureImage(element, 1);

      // Run on separate isolate as async operations cannot be run inside
      // testWidgets directly.
      final binding = TestWidgetsFlutterBinding.instance;
      await binding.runAsync(() async {
        final image = await imageFuture;
        final byteData = await image.toByteData(format: ImageByteFormat.png);
        final imageBytes = byteData!.buffer.asUint8List();

        final jsonEncoder = const JsonEncoder.withIndent('  ');
        final metadata = ScenarioMetadata(
          scenario: scenario,
          imageBytes: imageBytes,
          imageWidth: image.width,
          imageHeight: image.height,
          pixelRatio: targetViewport.pixelRatio,
        );

        await metadata.directory.create(recursive: true);

        await Future.wait([
          metadata.imageFile.writeAsBytes(imageBytes, flush: true),
          metadata.jsonFile.writeAsString(
            jsonEncoder.convert(metadata),
            flush: true,
          ),
        ]);

        image.dispose();
      });

      addTearDown(tester.view.reset);
    },
  );
}

/// Same as [captureImage] from `flutter_test` but has [pixelRatio] parameter.
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
