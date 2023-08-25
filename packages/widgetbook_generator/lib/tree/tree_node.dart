import 'dart:collection';

import 'package:meta/meta.dart';

import '../instances/instance.dart';
import '../instances/widgetbook_component_instance.dart';
import '../instances/widgetbook_folder_instance.dart';
import '../models/use_case_metadata.dart';

typedef KeyResolver<T> = String Function(T data);

@optionalTypeArgs
class TreeNode<T> {
  TreeNode(
    this.data, [
    Map<String, TreeNode> children = const {},
  ]) : children = HashMap.from(children);

  final T data;
  Map<String, TreeNode> children;

  List<Instance> get instances => children.values //
      .map((child) => child.toInstance())
      .toList();

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

  Instance toInstance() {
    final isComponentNode = children.isNotEmpty &&
        children.values.every(
          (child) => child is TreeNode<UseCaseMetadata>,
        );

    return isComponentNode
        ? WidgetbookComponentInstance(
            name: data as String,
            useCases: children.values
                .map((child) => child.data)
                .whereType<UseCaseMetadata>()
                .toList(),
          )
        : WidgetbookFolderInstance(
            node: this as TreeNode<String>,
          );
  }
}
