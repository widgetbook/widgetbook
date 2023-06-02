import 'package:flutter/material.dart';

import '../enums/navigation_node_type.dart';

class NavigationTreeNodeData {
  const NavigationTreeNodeData({
    required this.path,
    required this.name,
    required this.type,
    this.isInitiallyExpanded = true,
    this.children = const [],
    this.data,
  });

  final String path;
  final String name;
  final NavigationNodeType type;
  final bool isInitiallyExpanded;
  final List<NavigationTreeNodeData> children;
  final dynamic data;

  Widget get icon => type.icon;

  bool get isExpandable => type.isExpandable;

  bool get isSelectable => type.isSelectable;

  NavigationTreeNodeData copyWith({
    String? path,
    String? name,
    NavigationNodeType? type,
    bool? isInitiallyExpanded,
    List<NavigationTreeNodeData>? children,
    dynamic data,
  }) {
    return NavigationTreeNodeData(
      path: path ?? this.path,
      name: name ?? this.name,
      type: type ?? this.type,
      isInitiallyExpanded: isInitiallyExpanded ?? this.isInitiallyExpanded,
      children: children ?? this.children,
      data: data ?? this.data,
    );
  }
}
