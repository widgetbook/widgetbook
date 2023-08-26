import 'dart:collection';

import 'package:meta/meta.dart';

import '../code/widgetbook_instance.dart';

typedef KeyResolver<T> = String Function(T data);

@optionalTypeArgs
class TreeNode<T> {
  TreeNode(
    this.data, [
    Map<String, TreeNode> children = const {},
  ]) : children = HashMap.from(children);

  final T data;
  Map<String, TreeNode> children;

  /// Uses [toString] on [data]
  static String defaultKeyResolver(dynamic data) {
    return data.toString();
  }

  /// Adds a new child node with the given [data].
  TreeNode<TData> add<TData>(
    TData data, {
    KeyResolver<TData> resolveKey = defaultKeyResolver,
  }) {
    final key = resolveKey(data);

    return children.putIfAbsent(
      key,
      () => TreeNode<TData>(data),
    ) as TreeNode<TData>;
  }

  List<WidgetbookInstance> getInstances(String baseDir) {
    return children.values
        .map((child) => WidgetbookInstance.fromNode(child, baseDir))
        .toList();
  }
}
