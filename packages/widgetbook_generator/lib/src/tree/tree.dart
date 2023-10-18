import 'package:path/path.dart' as path;

import '../models/use_case_metadata.dart';
import 'duplicate_use_cases_error.dart';
import 'tree_node.dart';

class Tree {
  /// Builds a tree from the given [useCases].
  ///
  /// The tree is built by splitting the import uri of each use case into its
  /// parts and adding each part as a node to the tree. Then adding the
  /// use-case's component as a child of the last part, followed by the
  /// use-case itself as a leaf node.
  static TreeNode<Null> build(
    List<UseCaseMetadata> useCases,
  ) {
    final root = TreeNode<Null>(null);

    for (var useCase in useCases) {
      final parts = path.split(useCase.navPath);

      TreeNode currentNode = root;

      for (final part in parts) {
        final node = currentNode.add(part);
        currentNode = node;
      }

      final componentName = useCase.component.name;
      final componentNode = currentNode.add(componentName);

      if (componentNode.children.containsKey(useCase.name)) {
        throw DuplicateUseCasesError(componentNode, useCase);
      }

      componentNode.add<UseCaseMetadata>(
        useCase,
        resolveKey: (data) => data.name,
      );
    }

    return root;
  }
}
