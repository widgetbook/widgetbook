import 'package:flutter/material.dart';

import '../icons/icons.dart';
import '../nodes/nodes.dart';

class NavigationTreeNodeData {
  const NavigationTreeNodeData({
    required this.path,
    required this.name,
    this.isInitiallyExpanded = true,
    this.children = const [],
    required this.data,
  });

  final String path;
  final String name;
  final bool isInitiallyExpanded;
  final List<NavigationTreeNodeData> children;
  final TreeNode data;

  Widget get icon {
    switch (data.runtimeType) {
      case WidgetbookPackage:
        return const Icon(Icons.inventory, size: 16);
      case WidgetbookCategory:
        return const Icon(Icons.auto_awesome_mosaic, size: 16);
      case WidgetbookFolder:
        return const Icon(Icons.folder, size: 16);
      case WidgetbookComponent:
        return const ComponentIcon();
      case WidgetbookUseCase:
        return const UseCaseIcon();
      default:
        return const SizedBox();
    }
  }

  bool get isExpandable => !data.isLeaf;

  bool get isSelectable => data.isLeaf;

  NavigationTreeNodeData copyWith({
    String? path,
    String? name,
    bool? isInitiallyExpanded,
    List<NavigationTreeNodeData>? children,
    TreeNode? data,
  }) {
    return NavigationTreeNodeData(
      path: path ?? this.path,
      name: name ?? this.name,
      isInitiallyExpanded: isInitiallyExpanded ?? this.isInitiallyExpanded,
      children: children ?? this.children,
      data: data ?? this.data,
    );
  }
}
