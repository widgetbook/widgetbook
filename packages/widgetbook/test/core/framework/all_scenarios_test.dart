import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

class _Args extends StoryArgs<SizedBox> {
  const _Args();

  @override
  List<Arg?> get list => const [];
}

class _TestStory extends Story<SizedBox, _Args> {
  _TestStory({
    super.scenarios = const [],
  }) : super(
         args: const _Args(),
         builder: (_, __) => const SizedBox.shrink(),
       );
}

TextScaleMode _textScaleMode(double value) => TextScaleMode(value);

void main() {
  group('Story.allScenarios', () {
    test('returns default scenario when no scenarios are defined', () {
      final story = _TestStory();
      final config = const Config();

      final scenarios = story.allScenarios(config);

      expect(scenarios, hasLength(1));
      expect(scenarios.single.name, 'Default');
      expect(scenarios.single.type, ScenarioType.$default);
    });

    test('includes global and local scenarios separately by default', () {
      final story = _TestStory(
        scenarios: [
          Scenario(name: 'Loading'),
        ],
      );
      final config = Config(
        scenarios: [
          ScenarioDefinition(
            name: 'Dark',
            modes: [_textScaleMode(2)],
          ),
        ],
      );

      final scenarios = story.allScenarios(config);

      expect(scenarios.map((scenario) => scenario.name), [
        'Default | Dark',
        'Loading',
      ]);
    });

    test(
      'keeps standalone globals and adds merged custom scenarios',
      () {
        final story = _TestStory(
          scenarios: [
            Scenario(name: 'Story Scenario'),
          ],
        );
        final config = Config(
          scenarios: [
            ScenarioDefinition(
              name: 'Global Mode 1',
              modes: [_textScaleMode(1)],
              applyToStoryScenarios: true,
            ),
            ScenarioDefinition(
              name: 'Global Mode 2',
              modes: [_textScaleMode(2)],
              applyToStoryScenarios: true,
            ),
          ],
        );

        expect(story.allScenarios(config).map((scenario) => scenario.name), [
          'Default | Global Mode 1',
          'Default | Global Mode 2',
          'Story Scenario | Global Mode 1',
          'Story Scenario | Global Mode 2',
        ]);
      },
    );

    test(
      'creates merged scenarios when applyToStoryScenarios is true',
      () {
        final story = _TestStory(
          scenarios: [
            Scenario(
              name: 'Loading',
              modes: [_textScaleMode(1.5)],
            ),
            Scenario(name: 'Error'),
          ],
        );
        final config = Config(
          scenarios: [
            ScenarioDefinition(
              name: 'Dark',
              modes: [_textScaleMode(2)],
              applyToStoryScenarios: true,
            ),
            ScenarioDefinition(
              name: 'Light',
              modes: [_textScaleMode(1)],
            ),
          ],
        );

        final scenarios = story.allScenarios(config);

        expect(scenarios.map((scenario) => scenario.name), [
          'Default | Dark',
          'Default | Light',
          'Loading | Dark',
          'Error | Dark',
        ]);
      },
    );

    test(
      'groups merged scenarios by local scenario name',
      () {
        final story = _TestStory(
          scenarios: [
            Scenario(name: 'Outlined'),
            Scenario(name: 'Filled'),
          ],
        );
        final config = Config(
          scenarios: [
            ScenarioDefinition(
              name: 'Light Theme, 1.0x Text Scale',
              modes: [_textScaleMode(1)],
              applyToStoryScenarios: true,
            ),
            ScenarioDefinition(
              name: 'Dark Theme, 1.35x Text Scale',
              modes: [_textScaleMode(1.35)],
              applyToStoryScenarios: true,
            ),
          ],
        );

        expect(story.allScenarios(config).map((scenario) => scenario.name), [
          'Default | Light Theme, 1.0x Text Scale',
          'Default | Dark Theme, 1.35x Text Scale',
          'Outlined | Light Theme, 1.0x Text Scale',
          'Outlined | Dark Theme, 1.35x Text Scale',
          'Filled | Light Theme, 1.0x Text Scale',
          'Filled | Dark Theme, 1.35x Text Scale',
        ]);
      },
    );

    test(
      'creates standalone global scenarios when no custom scenarios exist',
      () {
        final story = _TestStory();
        final config = Config(
          scenarios: [
            ScenarioDefinition(
              name: 'Light Theme, 1.0x Text Scale',
              modes: [_textScaleMode(1)],
              applyToStoryScenarios: true,
            ),
            ScenarioDefinition(
              name: 'Dark Theme, 1.35x Text Scale',
              modes: [_textScaleMode(1.35)],
              applyToStoryScenarios: true,
            ),
          ],
        );

        final scenarios = story.allScenarios(config);

        expect(scenarios.map((scenario) => scenario.name), [
          'Light Theme, 1.0x Text Scale',
          'Dark Theme, 1.35x Text Scale',
        ]);
        expect(
          scenarios.map((scenario) => scenario.type),
          everyElement(ScenarioType.global),
        );
      },
    );

    test(
      'merged scenarios apply global modes with local precedence',
      () {
        final story = _TestStory(
          scenarios: [
            Scenario(
              name: 'Loading',
              modes: [_textScaleMode(1.5)],
            ),
          ],
        );
        final config = Config(
          scenarios: [
            ScenarioDefinition(
              name: 'Dark',
              modes: [_textScaleMode(2)],
              applyToStoryScenarios: true,
            ),
          ],
        );

        final merged = story.allScenarios(config).last;

        expect(merged.name, 'Loading | Dark');
        expect(
          merged.modes.whereType<TextScaleMode>().single.value,
          1.5,
        );
      },
    );
  });
}
