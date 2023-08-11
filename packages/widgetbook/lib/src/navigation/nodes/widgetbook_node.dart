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

  String get path => nodesPath
      .map((pathNode) => pathNode.name)
      .join('/')
      .replaceAll(' ', '-')
      .toLowerCase()
      .replaceFirst('/', ''); // Remove leading slash from root

  List<WidgetbookNode> get nodesPath {
    if (isRoot) {
      return [this];
    } else {
      return [...parent!.nodesPath, this];
    }
  }

  List<WidgetbookNode> get leaves {
    if (isLeaf) {
      return [this];
    } else {
      return children!.expand((child) => child.leaves).toList();
    }
  }

  WidgetbookNode? filter(bool Function(WidgetbookNode node) predicate) {
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

  WidgetbookNode? find(bool Function(WidgetbookNode node) predicate) {
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

  WidgetbookNode copyWith({
    String? name,
    List<WidgetbookNode>? children,
  });
}
