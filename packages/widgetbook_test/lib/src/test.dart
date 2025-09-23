import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:widgetbook/widgetbook.dart';
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
  for (final story in component.stories) {
    testStory(config, component, story);
  }
}

void testStory(Config config, Component component, Story story) {
  for (final scenario in story.scenarios) {
    testScenario(config, component, story, scenario);
  }
}

void testScenario(
  Config config,
  Component component,
  Story story,
  Scenario scenario,
) {
  testWidgets(
    '${component.name}/${story.name}/${scenario.name}',
    (tester) async {
      // Loosen constraints to make the image as small as the widget.
      tester.view.physicalConstraints = const ViewConstraints();

      final key = UniqueKey();
      await tester.pumpWidget(
        Builder(
          key: key,
          builder: (context) {
            // Re-use app builder from config
            return config.appBuilder(
              context,
              story.buildWithScenario(context, scenario),
            );
          },
        ),
      );

      final element = tester.element(find.byKey(key));
      final imageFuture = captureImage(element, 2);

      // Run on separate isolate as async operations cannot be run inside
      // testWidgets directly.
      final binding = TestWidgetsFlutterBinding.instance;
      await binding.runAsync(() async {
        final image = await imageFuture;
        final byteData = await image.toByteData(format: ImageByteFormat.png);
        final imageBytes = byteData!.buffer.asUint8List();

        final metadata = ScenarioMetadata(
          component: component,
          story: story,
          scenario: scenario,
          imageBytes: imageBytes,
        );

        await metadata.directory.create(recursive: true);

        await Future.wait([
          metadata.imageFile.writeAsBytes(imageBytes, flush: true),
          metadata.jsonFile.writeAsString(jsonEncode(metadata), flush: true),
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
