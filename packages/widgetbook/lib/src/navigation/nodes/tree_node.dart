abstract class TreeNode {
  TreeNode({
    required this.name,
    required this.children,
  }) {
    children?.forEach(
      (child) => child.parent = this,
    );
  }

  final String name;
  final List<TreeNode>? children;
  TreeNode? parent;

  bool get isOrphan => parent == null;

  bool get isLeaf => children == null || children!.isEmpty;

  List<TreeNode> get path {
    if (isOrphan) {
      return [this];
    } else {
      return [...parent!.path, this];
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

  TreeNode copyWith({
    String? name,
    List<TreeNode>? children,
  });
}
