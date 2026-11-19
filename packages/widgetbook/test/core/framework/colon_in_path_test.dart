import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/framework/component.dart';

import '../../helper/story_helpers.dart';

void main() {
  group('Colon in story/scenario name', () {
    late Component<SizedBox, TestStoryArgs> component;

    setUp(() {
      component = Component(
        name: 'Profile',
        path: 'widgets',
        stories: [
          TestStory(
            name: 'Profile (tap: Accept)',
            scenarios: [
              TestScenario(name: 'Default'),
            ],
          ),
        ],
      );
    });

    test('Component.fullPath joins without dropping parent', () {
      expect(component.fullPath, 'widgets/Profile');
    });

    test('Story.path preserves parent when name contains colon', () {
      final story = component.stories.first;
      expect(story.path, 'widgets/Profile/Profile (tap: Accept)');
    });

    test('Scenario.path preserves full ancestry with colon in story name', () {
      final scenario = component.stories.first.scenarios.first;
      expect(
        scenario.path,
        'widgets/Profile/Profile (tap: Accept)/Default',
      );
    });
  });
}
