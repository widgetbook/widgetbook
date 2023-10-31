import 'nodes.dart';

/// A base class for all nodes in the navigation tree.
/// The nodes have the following hierarchy:
///
/// 1. [WidgetbookRoot]
/// 2. [WidgetbookPackage]
/// 3. [WidgetbookCategory]
/// 4. [WidgetbookFolder]
/// 5. [WidgetbookComponent]
/// 6. [WidgetbookLeafComponent]
/// 7. [WidgetbookUseCase]
abstract class WidgetbookNode {
  WidgetbookNode({
    required this.name,
    required this.children,
    this.isInitiallyExpanded = true,
  }) {
    children?.forEach(
      (child) => child.parent = this,
    );
  }

  final String name;
  final bool isInitiallyExpanded;
  final List<WidgetbookNode>? children;
  WidgetbookNode? parent;

  bool get isRoot => parent == null;

  bool get isLeaf => children == null || children!.isEmpty;

  /// Gets the path from root to this node without leading slash
  /// Example: root/child/grandchild
  String get path => nodesPath
      .map((pathNode) => pathNode.name)
      .join('/')
      .replaceAll(' ', '-')
      .toLowerCase()
      .replaceFirst('/', '');

  /// Gets the nodes path from root to this node.
  List<WidgetbookNode> get nodesPath {
    if (isRoot) {
      return [this];
    } else {
      return [...parent!.nodesPath, this];
    }
  }

  /// Gets the depth of the node within the tree.
  int get depth {
    if (isRoot) {
      return 0;
    } else {
      return parent!.depth + 1;
    }
  }

  /// Gets all leaf nodes of this node.
  List<WidgetbookNode> get leaves {
    if (isLeaf) {
      return [this];
    } else {
      return children!.expand((child) => child.leaves).toList();
    }
  }

  // Gets the number of nodes in the sub-tree of this node.
  int get count {
    if (isLeaf) {
      return 1;
    } else {
      return children!.fold<int>(
        1,
        (acc, child) => acc + child.count,
      );
    }
  }

  /// Filters the sub-tree of this node for any node that matches [predicate].
  /// If a node matches the predicate, it will be included, along with all its
  /// descendants, in the result.
  ///
  /// Returns null if no node matches the predicate.
  WidgetbookNode? filter(
    bool Function(WidgetbookNode node) predicate,
  ) {
    if (predicate(this)) {
      return this;
    } else {
      final filteredChildren = children
          ?.map((child) => child.filter(predicate))
          .whereType<WidgetbookNode>()
          .toList();

      return filteredChildren == null || filteredChildren.isEmpty
          ? null
          : copyWith(
              children: filteredChildren,
            );
    }
  }

  /// Searches for a node that matches [predicate] in the sub-tree of this node.
  WidgetbookNode? find(
    bool Function(WidgetbookNode node) predicate,
  ) {
    if (predicate(this)) {
      return this;
    } else {
      return children //
          ?.map((child) => child.find(predicate))
          .firstWhere(
            (child) => child != null,
            orElse: () => null,
          );
    }
  }

  /// Creates a copy of this node with the given properties.
  /// Used in [filter] to create a copy of the sub-tree.
  WidgetbookNode copyWith({
    String? name,
    List<WidgetbookNode>? children,
  });
}
