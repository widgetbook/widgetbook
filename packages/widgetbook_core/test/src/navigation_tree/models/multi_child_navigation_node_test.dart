import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

void main() {
  group('$MultiChildNavigationNodeData', () {
    final data = MultiChildNavigationNodeData(
      name: 'Parent',
      type: NavigationNodeType.package,
      children: [
        NavigationTreeNodeData(
          name: 'First child',
          type: NavigationNodeType.package,
          children: [
            NavigationTreeNodeData(
              name: 'Second child',
              type: NavigationNodeType.package,
              children: [
                NavigationTreeNodeData(
                  name: 'Third child',
                  type: NavigationNodeType.package,
                ),
              ],
            ),
          ],
        ),
      ],
    );

    test('Can generate path', () {
      expect(
        data.children[0].children[0].children[0].path,
        equals('first-child/second-child/third-child'),
      );
    });

    test(
      'Path is assigned to id',
      () {
        expect(
          data.children[0].id,
          equals(data.children[0].path),
        );
      },
      // Todo: make this test work
      skip: true,
    );

    test('Updates children', () {
      final updatedData = data.updateChildren(
        children: [],
      );

      expect(updatedData.children, isEmpty);
    });

    group('$MultiChildNavigationNodeData.filterNode', () {
      test('Returns null when node has no matches', () {
        final data = MultiChildNavigationNodeData(
          name: 'Parent node',
          type: NavigationNodeType.package,
          children: [
            MultiChildNavigationNodeData(
              name: 'First child node',
              type: NavigationNodeType.package,
              children: [
                LeafNavigationNodeData(
                  name: 'First leaf node',
                  type: NavigationNodeType.package,
                )
              ],
            ),
          ],
        );

        expect(data.filterNode('foo'), isNull);
      });

      test('Can filter nodes on the first level', () {
        final data = MultiChildNavigationNodeData(
          name: 'Parent node',
          type: NavigationNodeType.package,
          children: [
            MultiChildNavigationNodeData(
              name: 'First child node',
              type: NavigationNodeType.package,
              children: const [],
            ),
            MultiChildNavigationNodeData(
              name: 'Second child node',
              type: NavigationNodeType.package,
              children: const [],
            ),
          ],
        );

        expect(
          data.filterNode('parent'),
          equals(data),
        );
      });

      test('Can filter nested nodes', () {
        final data = MultiChildNavigationNodeData(
          name: 'Parent node',
          type: NavigationNodeType.package,
          children: [
            MultiChildNavigationNodeData(
              name: 'First child node',
              type: NavigationNodeType.package,
              children: const [],
            ),
            MultiChildNavigationNodeData(
              name: 'Second child node',
              type: NavigationNodeType.package,
              children: [
                MultiChildNavigationNodeData(
                  name: 'Third child node',
                  type: NavigationNodeType.package,
                  children: const [],
                ),
                MultiChildNavigationNodeData(
                  name: 'Fourth child node',
                  type: NavigationNodeType.package,
                  children: [
                    LeafNavigationNodeData(
                      name: 'Leaf Child',
                      type: NavigationNodeType.useCase,
                    ),
                  ],
                ),
              ],
            ),
          ],
        );

        final result = MultiChildNavigationNodeData(
          name: 'Parent node',
          type: NavigationNodeType.package,
          children: [
            MultiChildNavigationNodeData(
              name: 'Second child node',
              type: NavigationNodeType.package,
              children: [
                MultiChildNavigationNodeData(
                  name: 'Fourth child node',
                  type: NavigationNodeType.package,
                  children: [
                    LeafNavigationNodeData(
                      name: 'Leaf Child',
                      type: NavigationNodeType.useCase,
                    ),
                  ],
                ),
              ],
            ),
          ],
        );

        expect(data.filterNode('fourth'), equals(result));
      });

      test('Can filter by Leaf name', () {
        final data = MultiChildNavigationNodeData(
          name: 'Parent node',
          type: NavigationNodeType.component,
          children: [
            LeafNavigationNodeData(
              name: 'Leaf Child',
              type: NavigationNodeType.useCase,
            ),
            LeafNavigationNodeData(
              name: 'Unwanted Child',
              type: NavigationNodeType.useCase,
            ),
          ],
        );

        final result = MultiChildNavigationNodeData(
          name: 'Parent node',
          type: NavigationNodeType.component,
          children: [
            LeafNavigationNodeData(
              name: 'Leaf Child',
              type: NavigationNodeType.useCase,
            ),
          ],
        );

        expect(data.filterNode('leaf'), equals(result));
      });
    });
  });
}
