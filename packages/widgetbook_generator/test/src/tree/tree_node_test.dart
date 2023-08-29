import 'package:test/test.dart';
import 'package:widgetbook_generator/widgetbook_generator.dart';

void main() {
  group('$TreeNode', () {
    test('adds child', () {
      final node = TreeNode<String>('root');
      node.add('child');

      expect(node.children.keys, equals(['child']));
    });
  });
}
