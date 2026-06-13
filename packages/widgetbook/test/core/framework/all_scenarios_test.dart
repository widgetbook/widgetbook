import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group('Story.allScenarios', () {
    test('returns default scenario when no scenarios are defined', () {
      final story = TestStory(name: 'Primary');

      final scenarios = story.allScenarios(const Config());

      expect(scenarios, hasLength(1));
      expect(scenarios.single.name, 'Default');
      expect(scenarios.single.type, ScenarioType.$default);
    });

    test('returns local scenarios unchanged without definitions', () {
      final local1 = TestScenario(name: 'L1');
      final local2 = TestScenario(name: 'L2');
      final story = TestStory(
        name: 'Primary',
        scenarios: [local1, local2],
      );

      final scenarios = story.allScenarios(const Config());

      expect(scenarios, hasLength(2));
      expect(scenarios[0], same(local1));
      expect(scenarios[1], same(local2));
    });

    test('defaults to ScenarioStrategy.perScenario', () {
      final definition = ScenarioDefinition(name: 'Dark', modes: []);

      expect(definition.strategy, ScenarioStrategy.perScenario);
    });

    test('perStory creates one standalone scenario per definition', () {
      final story = TestStory(name: 'Primary');
      final config = Config(
        scenarioConfig: ScenarioConfig(
          definitions: [
            ScenarioDefinition(
              name: 'Dark',
              modes: [TextScaleMode(2)],
              strategy: ScenarioStrategy.perStory,
            ),
          ],
        ),
      );

      final scenarios = story.allScenarios(config);

      expect(scenarios, hasLength(1));
      expect(scenarios.single.name, 'Dark');
      expect(scenarios.single.type, ScenarioType.global);
      expect(scenarios.single.args, same(story.args));
      expect(scenarios.single.run, isNull);
      expect(
        scenarios.single.modes.whereType<TextScaleMode>().single.value,
        2,
      );
    });

    test('perStory keeps bare local scenarios', () {
      final local = TestScenario(name: 'L1');
      final story = TestStory(name: 'Primary', scenarios: [local]);
      final config = Config(
        scenarioConfig: ScenarioConfig(
          definitions: [
            ScenarioDefinition(
              name: 'Dark',
              modes: [TextScaleMode(2)],
              strategy: ScenarioStrategy.perStory,
            ),
          ],
        ),
      );

      final scenarios = story.allScenarios(config);

      expect(scenarios.map((scenario) => scenario.name), ['Dark', 'L1']);
      expect(scenarios[1], same(local));
    });

    test('perScenario replaces bare local scenarios with crossed variants', () {
      final story = TestStory(
        name: 'Primary',
        scenarios: [
          TestScenario(name: 'L1'),
          TestScenario(name: 'L2'),
        ],
      );
      final config = Config(
        scenarioConfig: ScenarioConfig(
          definitions: [
            ScenarioDefinition(name: 'Dark', modes: [TextScaleMode(2)]),
          ],
        ),
      );

      final scenarios = story.allScenarios(config);

      expect(
        scenarios.map((scenario) => scenario.name),
        ['L1 • Dark', 'L2 • Dark'],
      );
      expect(
        scenarios.map((scenario) => scenario.type),
        everyElement(ScenarioType.crossed),
      );
    });

    test('crossed variants keep the args and run callback of their base', () {
      const pinnedArgs = TestStoryArgs();
      Future<void> run(WidgetTester tester, TestStoryArgs args) async {}

      final story = TestStory(
        name: 'Primary',
        scenarios: [
          TestScenario(name: 'L1', args: pinnedArgs, run: run),
        ],
      );
      final config = Config(
        scenarioConfig: ScenarioConfig(
          definitions: [
            ScenarioDefinition(name: 'Dark', modes: [TextScaleMode(2)]),
          ],
        ),
      );

      final crossed = story.allScenarios(config).single;

      expect(crossed.args, same(pinnedArgs));
      expect(crossed.run, same(run));
    });

    test('merges modes with precedence local > definition > story', () {
      final story = TestStory(
        name: 'Primary',
        modes: [
          TextScaleMode(1),
          AlignmentMode(Alignment.topLeft),
        ],
        scenarios: [
          TestScenario(name: 'L1', modes: [TextScaleMode(3)]),
          TestScenario(name: 'L2'),
        ],
      );
      final config = Config(
        scenarioConfig: ScenarioConfig(
          definitions: [
            ScenarioDefinition(
              name: 'Dark',
              modes: [TextScaleMode(2), ZoomMode(2)],
            ),
          ],
        ),
      );

      final scenarios = story.allScenarios(config);

      final withLocalModes = scenarios[0].modes;
      expect(withLocalModes, hasLength(3));
      expect(withLocalModes.whereType<TextScaleMode>().single.value, 3);
      expect(withLocalModes.whereType<ZoomMode>().single.value, 2);
      expect(
        withLocalModes.whereType<AlignmentMode>().single.value,
        Alignment.topLeft,
      );

      final withoutLocalModes = scenarios[1].modes;
      expect(withoutLocalModes, hasLength(3));
      expect(withoutLocalModes.whereType<TextScaleMode>().single.value, 2);
    });

    test('perScenario without local scenarios keeps the definition name', () {
      final story = TestStory(name: 'Primary');
      final config = Config(
        scenarioConfig: ScenarioConfig(
          definitions: [
            ScenarioDefinition(name: 'Dark', modes: [TextScaleMode(2)]),
            ScenarioDefinition(name: 'Light', modes: [TextScaleMode(1)]),
          ],
        ),
      );

      final scenarios = story.allScenarios(config);

      expect(scenarios.map((scenario) => scenario.name), ['Dark', 'Light']);
      expect(
        scenarios.map((scenario) => scenario.type),
        everyElement(ScenarioType.crossed),
      );
      expect(scenarios.first.args, same(story.args));
      expect(scenarios.first.run, isNull);
      expect(
        scenarios.first.modes.whereType<TextScaleMode>().single.value,
        2,
      );
    });

    test('both creates standalone and crossed scenarios', () {
      final story = TestStory(
        name: 'Primary',
        scenarios: [TestScenario(name: 'L1')],
      );
      final config = Config(
        scenarioConfig: ScenarioConfig(
          definitions: [
            ScenarioDefinition(
              name: 'Dark',
              modes: [TextScaleMode(2)],
              strategy: ScenarioStrategy.both,
            ),
          ],
        ),
      );

      final scenarios = story.allScenarios(config);

      expect(
        scenarios.map((scenario) => scenario.name),
        ['Dark', 'L1 • Dark'],
      );
      expect(scenarios[0].type, ScenarioType.global);
      expect(scenarios[1].type, ScenarioType.crossed);
    });

    test(
      'both without local scenarios does not cross the implicit default',
      () {
        final story = TestStory(name: 'Primary');
        final config = Config(
          scenarioConfig: ScenarioConfig(
            definitions: [
              ScenarioDefinition(
                name: 'Dark',
                modes: [TextScaleMode(2)],
                strategy: ScenarioStrategy.both,
              ),
            ],
          ),
        );

        final scenarios = story.allScenarios(config);

        expect(scenarios, hasLength(1));
        expect(scenarios.single.name, 'Dark');
        expect(scenarios.single.type, ScenarioType.global);
      },
    );

    test('orders standalone scenarios before crossed variants', () {
      final story = TestStory(
        name: 'Primary',
        scenarios: [
          TestScenario(name: 'L1'),
          TestScenario(name: 'L2'),
        ],
      );
      final config = Config(
        scenarioConfig: ScenarioConfig(
          definitions: [
            ScenarioDefinition(
              name: 'A',
              modes: [TextScaleMode(1)],
              strategy: ScenarioStrategy.perStory,
            ),
            ScenarioDefinition(name: 'B', modes: [TextScaleMode(2)]),
            ScenarioDefinition(
              name: 'C',
              modes: [TextScaleMode(3)],
              strategy: ScenarioStrategy.both,
            ),
          ],
        ),
      );

      final scenarios = story.allScenarios(config);

      expect(scenarios.map((scenario) => scenario.name), [
        'A',
        'C',
        'L1 • B',
        'L1 • C',
        'L2 • B',
        'L2 • C',
      ]);
    });

    test('uses the custom nameBuilder only for crossed variants', () {
      final calls = <String>[];
      final story = TestStory(
        name: 'Primary',
        scenarios: [
          TestScenario(name: 'L1'),
          TestScenario(name: 'L2'),
        ],
      );
      final config = Config(
        scenarioConfig: ScenarioConfig(
          definitions: [
            ScenarioDefinition(
              name: 'A',
              modes: [TextScaleMode(1)],
              strategy: ScenarioStrategy.perStory,
            ),
            ScenarioDefinition(name: 'B', modes: [TextScaleMode(2)]),
          ],
          nameBuilder: (definition, story, scenario) {
            calls.add('${story.name}/${scenario.name}/${definition.name}');
            return '${scenario.name}+${definition.name}';
          },
        ),
      );

      final scenarios = story.allScenarios(config);

      expect(
        scenarios.map((scenario) => scenario.name),
        ['A', 'L1+B', 'L2+B'],
      );
      expect(calls, ['Primary/L1/B', 'Primary/L2/B']);
    });

    test('does not invoke the nameBuilder without definitions', () {
      var calls = 0;
      final config = Config(
        scenarioConfig: ScenarioConfig(
          nameBuilder: (definition, story, scenario) {
            calls++;
            return 'unused';
          },
        ),
      );

      final withLocals = TestStory(
        name: 'Primary',
        scenarios: [TestScenario(name: 'L1')],
      );
      final withoutLocals = TestStory(name: 'Secondary');

      expect(
        withLocals.allScenarios(config).map((scenario) => scenario.name),
        ['L1'],
      );
      expect(withoutLocals.allScenarios(config).single.name, 'Default');
      expect(calls, 0);
    });
  });

  group('defaultScenarioNameBuilder', () {
    test('combines base and definition names with the separator', () {
      final definition = ScenarioDefinition(name: 'Dark', modes: []);
      final story = TestStory(name: 'Primary');
      final local = TestScenario(name: 'L1');

      expect(
        defaultScenarioNameBuilder(definition, story, local),
        'L1 • Dark',
      );
    });

    test('returns the definition name for the implicit default scenario', () {
      final definition = ScenarioDefinition(name: 'Dark', modes: []);
      final story = TestStory(name: 'Primary');
      final base = TestScenario(type: ScenarioType.$default, name: 'Default');

      expect(
        defaultScenarioNameBuilder(definition, story, base),
        'Dark',
      );
    });
  });

  group('Scenario.crossWith', () {
    test('applies definition modes when base and story have none', () {
      final definition = ScenarioDefinition(
        name: 'Dark',
        modes: [TextScaleMode(2)],
      );
      final base = TestScenario(name: 'L1');
      TestStory(name: 'Primary', scenarios: [base]);

      final crossed = base.crossWith(definition, 'L1 • Dark');

      expect(crossed.modes, definition.modes);
    });

    test('uses the mergeModes of its base for both merges', () {
      var mergerCalls = 0;
      List<Mode<dynamic>> spyMerger(
        List<Mode<dynamic>> storyModes,
        List<Mode<dynamic>> scenarioModes,
      ) {
        mergerCalls++;
        return defaultMergeModes(storyModes, scenarioModes);
      }

      final definition = ScenarioDefinition(
        name: 'Dark',
        modes: [TextScaleMode(3)],
      );
      final base = TestScenario(
        name: 'L1',
        modes: [ZoomMode(2)],
        mergeModes: spyMerger,
      );
      TestStory(
        name: 'Primary',
        modes: [TextScaleMode(1)],
        scenarios: [base],
      );

      final crossed = base.crossWith(definition, 'L1 • Dark');
      expect(mergerCalls, 1);

      final modes = crossed.modes;
      expect(mergerCalls, 2);
      expect(modes.whereType<TextScaleMode>().single.value, 3);
      expect(modes.whereType<ZoomMode>().single.value, 2);
    });

    test('keeps crossed names as a single path segment', () {
      final story = TestStory(
        name: 'Primary',
        scenarios: [TestScenario(name: 'L1')],
      );
      Component<SizedBox, TestStoryArgs>(name: 'Button', stories: [story]);
      final config = Config(
        scenarioConfig: ScenarioConfig(
          definitions: [
            ScenarioDefinition(name: 'Dark', modes: [TextScaleMode(2)]),
          ],
        ),
      );

      final crossed = story.allScenarios(config).single;

      expect(crossed.path, 'Button/Primary/L1 • Dark');
    });
  });
}
