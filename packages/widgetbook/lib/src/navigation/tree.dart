import 'package:path/path.dart' as p;

import '../framework/framework.dart';
import 'tree_node.dart';

class Tree {
  static TreeNode<Null> build(Config config) {
    final root = TreeNode<Null>('', null, null);

    for (final component in config.components) {
      final parts = p.split(component.path);

      // Start with root and keep adding parts down the path
      final lastNode = parts.fold<TreeNode>(
        root,
        (currentNode, part) => currentNode.add(
          TreeNode<Null>(part, null, currentNode),
        ),
      );

      final componentNode = TreeNode<Component>(
        component.name,
        component,
        lastNode,
      );

      lastNode.add(componentNode);

      final docs = component.docs;
      if (docs != null) {
        componentNode.add(
          TreeNode<String>('Docs', docs, componentNode),
        );
      }

      component.stories.forEach(
        (story) {
          final storyNode = componentNode.add(
            TreeNode<Story>(
              story.name,
              story,
              componentNode,
            ),
          );

          final allScenarios = story.allScenarios(config);
          allScenarios.forEach(
            (scenario) => storyNode.add(
              TreeNode<Scenario>(
                scenario.name,
                scenario,
                storyNode,
              ),
            ),
          );
        },
      );
    }

    return root;
  }
}
