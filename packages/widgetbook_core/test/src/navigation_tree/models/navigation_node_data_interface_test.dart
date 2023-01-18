import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class NodeImplementation1 extends NavigationNodeDataInterface {
  const NodeImplementation1({required super.name, required super.type});
}

class NodeImplementation2 extends NavigationNodeDataInterface {
  const NodeImplementation2({required super.name, required super.type});
}

void main() {
  group('$NavigationNodeDataInterface', () {
    test('Supports value equality', () {
      const node1 = NodeImplementation1(
        name: 'test',
        type: NavigationNodeType.component,
      );

      const node2 = NodeImplementation2(
        name: 'test',
        type: NavigationNodeType.component,
      );

      expect(node1, equals(node2));
    });
  });
}
