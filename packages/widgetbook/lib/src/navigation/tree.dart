import 'package:path/path.dart' as p;

import '../core/core.dart';
import 'tree_node.dart';

class Tree {
  static TreeNode<Null> build(List<Component> components) {
    final root = TreeNode<Null>('');

    for (final component in components) {
      final parts = p.split(component.meta.path ?? '');

      // Start with root and keep adding parts down the path
      final lastNode = parts.fold<TreeNode>(
        root,
        (currentNode, part) => currentNode.add(
          TreeNode<String>(part, currentNode),
        ),
      );

      final componentNode = TreeNode<Component>(
        component.name,
        lastNode,
        component,
      );

      lastNode.add(componentNode);

      if (component.docs != null) {
        componentNode.add(
          TreeNode<String>(
            'Docs',
            componentNode,
            component.docs,
          ),
        );
      }

      component.stories.forEach(
        (story) => componentNode.add(
          TreeNode<Story>(
            story.name,
            componentNode,
            story,
          ),
        ),
      );
    }

    return root;
  }

  static Map<String, Story> index(List<Component> components) {
    return Map.fromEntries(
      components.expand(
        (component) => component.stories.map(
          (story) => MapEntry(
            component.pathOf(story),
            story,
          ),
        ),
      ),
    );
  }
}
