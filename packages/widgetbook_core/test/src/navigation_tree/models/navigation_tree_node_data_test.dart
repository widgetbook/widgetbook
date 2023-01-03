import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_core/src/navigation_tree/enums/enums.dart';
import 'package:widgetbook_core/src/navigation_tree/models/models.dart';

void main() {
  group('$NavigationTreeNodeData', () {
    test('Supports value equality', () {
      final nodeData1 = NavigationTreeNodeData(
        name: 'Node',
        type: NavigationNodeType.package,
      );
      final nodeData2 = NavigationTreeNodeData(
        name: 'Node',
        type: NavigationNodeType.package,
      );
      expect(nodeData1.hashCode, equals(nodeData2.hashCode));
      expect(nodeData1, equals(nodeData2));
    });

    test('Returns formatted string', () {
      final data = NavigationTreeNodeData(
        name: 'Node',
        type: NavigationNodeType.package,
      );

      expect(
        data.toString(),
        equals(
          'NavigationTreeNodeData('
          'id: null, '
          'name: Node, '
          'type: NavigationNodeType.package, '
          'children: [], '
          'isInitiallyExpanded: true '
          ')',
        ),
      );
    });

    test('Can generate path', () {
      final node = NavigationTreeNodeData(
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

      expect(
        node.children[0].children[0].children[0].path,
        equals('first-child/second-child/third-child'),
      );
    });
  });
}
