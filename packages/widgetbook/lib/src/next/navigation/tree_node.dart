import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

@optionalTypeArgs
class TreeNode<T> {
  TreeNode(
    this.name, [
    this.parent,
    this.data,
  ]) : _children = HashMap();

  final String name;
  final TreeNode? parent;
  final T? data;
  final Map<String, TreeNode> _children;

  bool get isRoot => parent == null;
  bool get isLeaf => children.isEmpty;

  List<TreeNode> get children => _children.values.sortedBy((node) => node.name);

  /// Gets the path from root to this node without leading slash
  /// Example: root/child/grandchild
  String get path => isRoot //
      ? name
      : p.join(parent!.path, name).replaceAll(' ', '-');

  /// Gets the depth of the node within the tree.
  int get depth {
    if (isRoot) {
      return 0;
    } else {
      return parent!.depth + 1;
    }
  }

  TreeNode<TChild> add<TChild>(TreeNode<TChild> node) {
    return _children.putIfAbsent(
      node.name,
      () => node,
    ) as TreeNode<TChild>;
  }

  void addAll(Iterable<TreeNode> nodes) {
    nodes.forEach(add);
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
    } else {
      return TreeNode<T>(
        name,
        parent,
        data,
      )..addAll(
          children.where(predicate),
        );
    }
  }
}
