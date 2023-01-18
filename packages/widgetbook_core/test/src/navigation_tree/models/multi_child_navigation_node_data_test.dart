import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

void main() {
  group('$MultiChildNavigationNodeData', () {
    test('Supports value equality', () {
      const node1 = MultiChildNavigationNodeData(
        name: 'Second child',
        type: NavigationNodeType.package,
        children: [
          LeafNavigationNodeData(
            name: 'Third child',
            type: NavigationNodeType.package,
          ),
        ],
      );
      const node2 = MultiChildNavigationNodeData(
        name: 'Second child',
        type: NavigationNodeType.package,
        children: [
          LeafNavigationNodeData(
            name: 'Third child',
            type: NavigationNodeType.package,
          ),
        ],
      );

      expect(node1.hashCode, equals(node2.hashCode));
      expect(node1, equals(node2));
    });

    test('Returns formatted string', () {
      const node = MultiChildNavigationNodeData(
        name: 'Node Name',
        children: [],
        type: NavigationNodeType.package,
        isInitiallyExpanded: false,
      );

      expect(
        node.toString(),
        equals('MultiChildNavigationNodeData('
            'name: Node Name, '
            'type: NavigationNodeType.package, '
            'data: null, '
            'children: [], '
            'isInitiallyExpanded: false '
            ')'),
      );
    });
  });
}
