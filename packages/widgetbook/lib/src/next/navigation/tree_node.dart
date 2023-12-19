import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

typedef KeyResolver<T> = String Function(T data);

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

  List<TreeNode> get children => _children.values.sortedBy((node) => node.name);

  String get path => parent == null ? name : p.join(parent!.path, name);

  List<TreeNode> get leaves {
    if (children.isEmpty) {
      return [this];
    } else {
      return children.expand((child) => child.leaves).toList();
    }
  }

  TreeNode<TChild> add<TChild>(TreeNode<TChild> node) {
    return _children.putIfAbsent(
      node.name,
      () => node,
    ) as TreeNode<TChild>;
  }
}
