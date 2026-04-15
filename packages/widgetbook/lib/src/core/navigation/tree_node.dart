import 'dart:collection';

import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

import '../docs/docs.dart';
import '../framework/scenario.dart';
import '../framework/story.dart';

@optionalTypeArgs
class TreeNode<T> {
  TreeNode(
    this.name,
    this.data,
    this.parent,
  ) : _children = LinkedHashMap();

  final String name;
  final T data;
  final TreeNode? parent;
  final Map<String, TreeNode> _children;

  bool get isRoot => parent == null;
  bool get isLeaf => children.isEmpty;

  bool get isDocs => data is List<DocBlock> && name == 'Docs';
  bool get isCategory {
    return T == Null && name.startsWith('[') && name.endsWith(']');
  }

  bool get isClickable => switch (this) {
    TreeNode<List<DocBlock>>() => true,
    TreeNode<Scenario>() => true,
    TreeNode<Story>() => true,
    _ => false,
  };

  bool get isTerminal => switch (this) {
    TreeNode<List<DocBlock>>() => true,
    TreeNode<Scenario>() => true,
    TreeNode<Story>() => children.isEmpty,
    _ => false,
  };

  List<TreeNode> get children {
    final values = _children.values;
    return [
      ...values.where((n) => n.isDocs),
      ...values.where((n) => !n.isDocs && !n.isCategory),
      ...values.where((n) => n.isCategory),
    ];
  }

  /// The nesting depth of this node in the navigation tree.
  /// Category nodes don't contribute to depth.
  int get depth {
    var count = 0;
    var current = parent;
    while (current != null) {
      if (!current.isCategory) count++;
      current = current.parent;
    }
    return count;
  }

  /// Gets the path from root to this node without leading slash
  /// Example: root/child/grandchild
  String get path => isRoot ? name : p.join(parent!.path, name);

  TreeNode<TChild> add<TChild>(TreeNode<TChild> node) {
    return _children.putIfAbsent(
          node.name,
          () => node,
        )
        as TreeNode<TChild>;
  }

  void addAll(Iterable<TreeNode> nodes) {
    nodes.forEach(add);
  }

  /// Finds a node by its [path]. Returns null if no node is found.
  /// This is more efficient than using [filter] with a path equality check,
  /// as it traverses the tree directly.
  TreeNode? findByPath(String path) {
    final parts = p.split(path);

    TreeNode? currentNode = this;
    for (final part in parts) {
      currentNode = currentNode?._children[part];
      if (currentNode == null) {
        return null;
      }
    }

    return currentNode;
  }

  /// Filters the sub-tree of this node for any node that matches [predicate].
  /// If a node matches the predicate, it will be included, along with all its
  /// descendants, in the result.
  ///
  /// Returns null if no node matches the predicate.
  TreeNode<T>? filter(
    bool Function(TreeNode node) predicate,
  ) {
    if (predicate(this)) {
      return this;
    }

    final filteredChildren = children
        .map((child) => child.filter(predicate))
        .nonNulls;

    if (filteredChildren.isEmpty) {
      return null;
    }

    return TreeNode<T>(
      name,
      data,
      parent,
    )..addAll(filteredChildren);
  }
}
