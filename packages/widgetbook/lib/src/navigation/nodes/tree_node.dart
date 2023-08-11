abstract class TreeNode {
  TreeNode({
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
  final List<TreeNode>? children;
  TreeNode? parent;

  bool get isRoot => parent == null;

  bool get isLeaf => children == null || children!.isEmpty;

  String get path => nodesPath
      .map((pathNode) => pathNode.name)
      .join('/')
      .replaceAll(' ', '-')
      .toLowerCase()
      .replaceFirst('/', ''); // Remove leading slash from root

  List<TreeNode> get nodesPath {
    if (isRoot) {
      return [this];
    } else {
      return [...parent!.nodesPath, this];
    }
  }

  List<TreeNode> get leaves {
    if (isLeaf) {
      return [this];
    } else {
      return children!.expand((child) => child.leaves).toList();
    }
  }

  TreeNode? filter(bool Function(TreeNode node) predicate) {
    if (predicate(this)) {
      return this;
    } else {
      final filteredChildren = children
          ?.map((child) => child.filter(predicate))
          .whereType<TreeNode>()
          .toList();

      return filteredChildren == null || filteredChildren.isEmpty
          ? null
          : copyWith(
              children: filteredChildren,
            );
    }
  }

  TreeNode? find(bool Function(TreeNode node) predicate) {
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

  TreeNode copyWith({
    String? name,
    List<TreeNode>? children,
  });
}
