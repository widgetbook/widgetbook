import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/framework/component.dart';
import 'package:widgetbook/src/core/navigation/tree.dart';
import 'package:widgetbook/src/core/navigation/tree_node.dart';

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

    test('TreeNode.findByPath resolves path with colon in segment', () {
      final root = TreeNode<Null>('', null, null);
      final child = TreeNode<Null>('widgets', null, root);
      root.add(child);
      final profile = TreeNode<Null>('Profile', null, child);
      child.add(profile);
      final story = TreeNode<Null>('Profile (tap: Accept)', null, profile);
      profile.add(story);

      final found = root.findByPath('widgets/Profile/Profile (tap: Accept)');
      expect(found, isNotNull);
      expect(found!.name, 'Profile (tap: Accept)');
    });

    test('TreeNode.path builds correctly with colon in name', () {
      final root = TreeNode<Null>('', null, null);
      final child = TreeNode<Null>('widgets', null, root);
      root.add(child);
      final node = TreeNode<Null>('Btn (mode: Dark)', null, child);
      child.add(node);

      expect(node.path, 'widgets/Btn (mode: Dark)');
    });
  });
}
