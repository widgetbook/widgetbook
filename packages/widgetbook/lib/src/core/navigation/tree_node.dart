import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

@optionalTypeArgs
class TreeNode<T> {
  TreeNode(
    this.name,
    this.data,
    this.parent,
  ) : _children = HashMap();

  final String name;
  final T data;
  final TreeNode? parent;
  final Map<String, TreeNode> _children;

  bool get isRoot => parent == null;
  bool get isLeaf => children.isEmpty;

  bool get isDocs => T == String && name == 'Docs';
  bool get isCategory {
    return T == Null && name.startsWith('[') && name.endsWith(']');
  }

  List<TreeNode> get children {
    return _children.values.sorted(
      (a, b) {
        if (a.isDocs) return -1; // Docs always first
        if (a.isCategory == b.isCategory) {
          // Both categories or both folders
          return a.name.compareTo(b.name);
        } else {
          // Sort categories after folders
          return a.isCategory ? 1 : -1;
        }
      },
    );
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
    } else {
      return TreeNode<T>(
        name,
        data,
        parent,
      )..addAll(
        children.where(predicate),
      );
    }
  }
}
