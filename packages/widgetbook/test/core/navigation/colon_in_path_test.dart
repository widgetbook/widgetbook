import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/core/navigation/tree_node.dart';

void main() {
  group('Colon in node name', () {
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
