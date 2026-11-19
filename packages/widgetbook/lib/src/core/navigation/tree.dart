import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

import '../atlas/atlas_layout.dart';

import '../docs/docs.dart';
import '../framework/framework.dart';
import 'tree_node.dart';

/// The navigation path of the atlas overview; each flow is nested below it.
const atlasPath = 'Atlas';

class Tree {
  static TreeNode<Null> build(Config config) {
    final root = TreeNode<Null>('', null, null);

    if (config.atlas.isNotEmpty) {
      _addAtlas(root, config);
    }

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

      final defaultDocs = config.docsBuilder?.call() ?? [];
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

  static void _addAtlas(TreeNode<Null> root, Config config) {
    final registered = registeredStories(config);
    final atlasNode = root.add(
      TreeNode<List<AtlasFlow>>(atlasPath, config.atlas, root),
    );

    for (final flow in config.atlas) {
      final flowNode = atlasNode.add(
        TreeNode<AtlasFlow>(flow.name, flow, atlasNode),
      );

      for (final node in flow.pages) {
        if (isUnregisteredPage(node, registered)) {
          debugPrint(
            'Widgetbook: the "${flow.name}" AtlasFlow references a story that '
            'is not part of Config.components; it is shown as a placeholder.',
          );
        } else if (node is AtlasPage && node.args != null) {
          flowNode.add(
            TreeNode<Scenario>(node.pathSegment, node.scenario, flowNode),
          );
        }
      }
    }
  }
}
