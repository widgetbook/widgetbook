import 'package:path/path.dart' as p;

import '../docs/docs.dart';
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

      final defaultDocs = config.docBuilder?.call() ?? [];
      final docs = component.docsBuilder?.call(defaultDocs) ?? defaultDocs;
      if (docs.isNotEmpty) {
        componentNode.add(
          TreeNode<List<DocBlock>>('Docs', docs, componentNode),
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
