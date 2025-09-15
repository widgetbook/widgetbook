import 'nodes.dart';

/// A base class for all nodes in the navigation tree.
/// The nodes have the following hierarchy:
///
/// 1. [WidgetbookRoot]
/// 2. [WidgetbookPackage]
/// 3. [WidgetbookCategory]
/// 4. [WidgetbookFolder]
/// 5. [WidgetbookComponent]
/// 6. [WidgetbookUseCase]
abstract class WidgetbookNode {
  /// Creates a [WidgetbookNode].
  WidgetbookNode({
    required this.name,
    required this.children,
    this.isInitiallyExpanded = true,
  }) {
    children?.forEach(
      (child) => child.parent = this,
    );
  }

  /// The name of the node.
  final String name;

  /// Whether the node is expanded by default.
  final bool isInitiallyExpanded;

  /// The children of the node.
  final List<WidgetbookNode>? children;

  /// The parent of the node.
  /// This is set after the node is added to a parent node.
  WidgetbookNode? parent;

  /// Whether this node is the root node.
  /// The root node does not have a parent.
  bool get isRoot => parent == null;

  /// Whether this node is a leaf node.
  /// A leaf node has no children.
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

  /// Gets the number of nodes in the sub-tree of this node.
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
      final filteredChildren =
          children
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

  /// Returns an [Iterable] of all nodes that match the [predicate].
  Iterable<WidgetbookNode> findAll(
    bool Function(WidgetbookNode node) predicate,
  ) {
    if (predicate(this)) {
      return [this];
    } else {
      return children?.expand((child) => child.findAll(predicate)) ?? [];
    }
  }

  /// Creates a copy of this node with the given properties.
  /// Used in [filter] to create a copy of the sub-tree.
  WidgetbookNode copyWith({
    String? name,
    List<WidgetbookNode>? children,
  });
}
