import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/navigation/tree.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group('children ordering', () {
    test(
      'stories should be ordered by definition order, not alphabetically',
      () {
        final config = Config(
          docsBuilder: null,
          components: [
            Component(
              name: 'Button',
              stories: [
                TestStory(name: 'Primary'),
                TestStory(name: 'Disabled'),
                TestStory(name: 'Active'),
              ],
            ),
          ],
        );

        final tree = Tree.build(config);
        final buttonNode = tree.children.first;
        final storyNames = buttonNode.children.map((n) => n.name).toList();

        expect(storyNames, ['Primary', 'Disabled', 'Active']);
      },
    );

    test(
      'docs should be ordered before stories',
      () {
        final config = Config(
          components: [
            Component(
              name: 'Button',
              stories: [
                TestStory(name: 'Primary'),
                TestStory(name: 'Disabled'),
              ],
            ),
          ],
        );

        final tree = Tree.build(config);
        final buttonNode = tree.children.first;
        final childNames = buttonNode.children.map((n) => n.name).toList();

        expect(childNames, ['Docs', 'Primary', 'Disabled']);
      },
    );
  });
}
