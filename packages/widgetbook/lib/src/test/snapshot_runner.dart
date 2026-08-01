import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

import '../../widgetbook.dart';
import 'scenario_metadata.dart';
import 'semantics/semantics_tree_serializer.dart';

/// A captured scenario image and the dimensions describing it.
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

/// The parts of snapshot capture that differ between the headless
/// (`flutter test`) and on-device (`integration_test`) runners: how the
/// viewport is applied, and how the built scenario is captured and persisted.
///
/// Everything else — the component/story/scenario walk, `Scenario.run`,
/// accessibility evaluation, semantics, image-cache reset, `wrapper`, and
/// `excludeFromTests` — is shared by [declareSnapshotTests].
@internal
abstract class SnapshotStrategy {
  const SnapshotStrategy();

  /// Applies [viewport] to the tester's view before the scenario is pumped.
  void applyViewport(WidgetTester tester, ViewportData viewport) {}

  /// Captures the pumped scenario (keyed by [key]) and persists the resulting
  /// image plus its [ScenarioMetadata]. Implementations build the metadata via
  /// [buildScenarioMetadata] so both runners emit an identical shape.
  Future<void> captureAndPersist({
    required WidgetTester tester,
    required Scenario scenario,
    required Key key,
    required ViewportData viewport,
    required Map<String, dynamic> semantics,
    required List<Map<String, dynamic>> violations,
  });
}

/// Assembles [ScenarioMetadata] from a captured image. Shared so the headless
/// and on-device runners produce byte-identical metadata.
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

/// Declares a test group per component/story and a test case per scenario in
/// [config], delegating capture and persistence to [strategy]. When [where] is
/// given, only components it selects are included — the mechanism customers use
/// to opt specific components into on-device snapshotting.
@internal
void declareSnapshotTests(
  Config config,
  SnapshotStrategy strategy, {
  bool Function(Component component)? where,
}) {
  for (final component in config.components) {
    if (where != null && !where(component)) continue;

    group(component.name, () {
      for (final story in component.stories) {
        group(
          story.name,
          () {
            for (final scenario in story.allScenarios(config)) {
              _testScenario(config, scenario, strategy);
            }
          },
          skip: story.excludeFromTests ? 'Excluded from snapshots' : null,
        );
      }
    });
  }
}

void _testScenario(
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

      // The wrapper must already be on the call stack when the widget is
      // pumped, so that Zone values (e.g. package:clock's clock) are visible
      // to the build methods of the scenario's widget tree.
      final wrapper = config.scenarioConfig.wrapper;
      await (wrapper == null ? body() : wrapper(tester, scenario, body));

      semanticsHandle.dispose();
      addTearDown(tester.view.reset);
    },
    // `null` (not `false`) so a non-excluded scenario inside an excluded story
    // still inherits the story group's `skip`.
    skip: scenario.excludeFromTests ? true : null,
  );
}
