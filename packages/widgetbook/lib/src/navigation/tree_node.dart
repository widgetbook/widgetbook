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
  bool get isCategory {
    return T == String && name.startsWith('[') && name.endsWith(']');
  }

  List<TreeNode> get children {
    return _children.values.sorted(
      (a, b) {
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
  String get path => isRoot //
      ? name
      : p.join(parent!.path, name).replaceAll(' ', '-');

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
