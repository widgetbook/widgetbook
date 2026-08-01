import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

import '../../widgetbook.dart';
import 'scenario_metadata.dart';
import 'semantics/semantics_tree_serializer.dart';

@internal
class CapturedSnapshot {
  const CapturedSnapshot({
    required this.bytes,
    required this.width,
    required this.height,
    required this.pixelRatio,
  });

  final Uint8List bytes;
  final int width;
  final int height;
  final double pixelRatio;
}

/// The capture behavior that differs between the headless (`flutter test`) and
/// on-device (`integration_test`) runners. The scenario walk and everything
/// around capture is shared by [declareSnapshotTests].
@internal
abstract class SnapshotStrategy {
  const SnapshotStrategy();

  void applyViewport(WidgetTester tester, ViewportData viewport) {}

  Future<void> captureAndPersist({
    required WidgetTester tester,
    required Scenario scenario,
    required Key key,
    required ViewportData viewport,
    required Map<String, dynamic> semantics,
    required List<Map<String, dynamic>> violations,
  });
}

@internal
ScenarioMetadata buildScenarioMetadata(
  Scenario scenario,
  CapturedSnapshot capture,
  Map<String, dynamic> semantics,
  List<Map<String, dynamic>> violations,
) {
  return ScenarioMetadata(
    scenario: scenario,
    imageBytes: capture.bytes,
    imageWidth: capture.width,
    imageHeight: capture.height,
    pixelRatio: capture.pixelRatio,
    semanticsData: semantics,
    violations: violations,
  );
}

/// [where] restricts the run to matching components — how a project partitions
/// components between the headless and on-device runs.
@internal
void declareSnapshotTests(
  Config config,
  SnapshotStrategy strategy, {
  bool Function(Component component)? where,
}) {
  for (final component in config.components) {
    if (where != null && !where(component)) continue;
    declareComponentTests(config, component, strategy);
  }
}

@internal
void declareComponentTests(
  Config config,
  Component component,
  SnapshotStrategy strategy,
) {
  group(component.name, () {
    for (final story in component.stories) {
      declareStoryTests(config, story, strategy);
    }
  });
}

@internal
void declareStoryTests(
  Config config,
  Story story,
  SnapshotStrategy strategy,
) {
  group(
    story.name,
    () {
      for (final scenario in story.allScenarios(config)) {
        declareScenarioTest(config, scenario, strategy);
      }
    },
    skip: story.excludeFromTests ? 'Excluded from snapshots' : null,
  );
}

@internal
void declareScenarioTest(
  Config config,
  Scenario scenario,
  SnapshotStrategy strategy,
) {
  final targetViewport = scenario.viewport ?? Viewports.none;

  testWidgets(
    scenario.name,
    (tester) async {
      // Reset the shared image cache so it doesn't leak between scenarios.
      addTearDown(() {
        final imageCache = PaintingBinding.instance.imageCache;
        imageCache.clear();
        imageCache.clearLiveImages();
      });

      strategy.applyViewport(tester, targetViewport);

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

        final violations = (await evaluateGuidelines(
          tester,
          config.accessibilityConfig.guidelines,
        )).map((violation) => violation.toJson()).toList();

        final semantics = SemanticsTreeSerializer.toJson(
          tester.getSemantics(find.byKey(key)),
        );

        await strategy.captureAndPersist(
          tester: tester,
          scenario: scenario,
          key: key,
          viewport: targetViewport,
          semantics: semantics,
          violations: violations,
        );

        await config.scenarioConfig.tearDown?.call(tester, scenario);
      }

      // The wrapper must be on the call stack before pumping so its Zone values
      // (e.g. package:clock) are visible to the scenario's build methods.
      final wrapper = config.scenarioConfig.wrapper;
      await (wrapper == null ? body() : wrapper(tester, scenario, body));

      semanticsHandle.dispose();
      addTearDown(tester.view.reset);
    },
    // `null` (not `false`) so a non-excluded scenario in an excluded story still
    // inherits the group's `skip`.
    skip: scenario.excludeFromTests ? true : null,
  );
}
