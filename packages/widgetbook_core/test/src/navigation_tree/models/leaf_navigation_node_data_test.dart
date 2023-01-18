import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_core/src/navigation_tree/enums/enums.dart';
import 'package:widgetbook_core/src/navigation_tree/models/leaf_navigation_node_data.dart';

void main() {
  group('$LeafNavigationNodeData', () {
    test('Supports value equality', () {
      const node1 = LeafNavigationNodeData(
        name: 'Node Name',
        type: NavigationNodeType.useCase,
      );
      const node2 = LeafNavigationNodeData(
        name: 'Node Name',
        type: NavigationNodeType.useCase,
      );

      expect(node1.hashCode, equals(node2.hashCode));
      expect(node1, equals(node2));
    });

    test('Returns formatted string', () {
      const node = LeafNavigationNodeData(
        name: 'Node Name',
        type: NavigationNodeType.useCase,
        isInitiallyExpanded: false,
      );

      expect(
        node.toString(),
        equals(
          'LeafNavigationNodeData('
          'name: Node Name, '
          'type: NavigationNodeType.useCase, '
          'data: null, '
          'isInitiallyExpanded: false '
          ')',
        ),
      );
    });
  });
}
