import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../widgetbook.dart';
import 'font_loader.dart';
import 'guidelines/guidelines.dart';
import 'scenario_metadata.dart';
import 'semantics/semantics_tree_serializer.dart';

/// The default location is already an ignored path by default.
const outputDir = 'build/.widgetbook';

Future<void> testWidgetbook(
  Config config, {
  List<WidgetbookGuideline> guidelines = WidgetbookGuidelines.recommended,
}) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await loadFonts();

  for (final component in config.components) {
    testComponent(config, component, guidelines);
  }
}

void testComponent(
  Config config,
  Component component,
  List<WidgetbookGuideline> guidelines,
) {
  group('${component.name}', () {
    for (final story in component.stories) {
      testStory(config, story, guidelines);
    }
  });
}

void testStory(
  Config config,
  Story story,
  List<WidgetbookGuideline> guidelines,
) {
  group(story.name, () {
    final scenarios = story.allScenarios(config);
    for (final scenario in scenarios) {
      testScenario(config, scenario, guidelines);
    }
  });
}

void testScenario(
  Config config,
  Scenario scenario,
  List<WidgetbookGuideline> guidelines,
) {
  final defaultViewport = Viewports.none;
  final targetViewport = scenario.viewport ?? defaultViewport;

  testWidgets(
    scenario.name,
    (tester) async {
      tester.view.physicalConstraints = targetViewport.viewConstraints;
      tester.view.devicePixelRatio = targetViewport.pixelRatio;

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

        // Evaluate guidelines here (not inside the runAsync below): the contrast
        // guideline uses runAsync internally, and runAsync cannot be nested.
        final violations = await evaluateGuidelines(tester, guidelines);

        final element = tester.element(find.byKey(key));
        final imageFuture = captureImage(element, 1);

        final semanticsNode = tester.getSemantics(find.byKey(key));

        // Run on separate isolate as async operations cannot be run inside
        // testWidgets directly.
        final binding = TestWidgetsFlutterBinding.instance;
        await binding.runAsync(() async {
          final image = await imageFuture;
          final byteData = await image.toByteData(format: ImageByteFormat.png);
          final imageBytes = byteData!.buffer.asUint8List();

          final jsonEncoder = const JsonEncoder.withIndent('  ');

          final semanticsData = SemanticsTreeSerializer.toJson(
            semanticsNode,
          );

          final metadata = ScenarioMetadata(
            scenario: scenario,
            imageBytes: imageBytes,
            imageWidth: image.width,
            imageHeight: image.height,
            pixelRatio: targetViewport.pixelRatio,
            semanticsData: semanticsData,
            violations: violations,
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

        await config.scenarioConfig.tearDown?.call(tester, scenario);
      }

      // The wrapper must already be on the call stack when the widget is
      // pumped, so that Zone values (e.g. package:clock's clock) are visible
      // to the build methods of the scenario's widget tree.
      final wrapper = config.scenarioConfig.wrapper;
      await (wrapper == null ? body() : wrapper(tester, scenario, body));

      semanticsHandle.dispose();
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
