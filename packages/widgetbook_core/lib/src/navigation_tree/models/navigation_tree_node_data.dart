import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_core/src/navigation_tree/enums/navigation_node_type.dart';

part 'navigation_tree_node_data.freezed.dart';

@freezed
class NavigationTreeNodeData with _$NavigationTreeNodeData {
  const factory NavigationTreeNodeData({
    String? id,
    required String name,
    required NavigationNodeType type,
    @Default([]) List<NavigationTreeNodeData> children,
  }) = _NavigationTreeNodeData;

  const NavigationTreeNodeData._();

  Widget get icon => type.icon;
  bool get isExpandable => type.isExpandable;
  bool get isSelectable => type.isSelectable;
}
