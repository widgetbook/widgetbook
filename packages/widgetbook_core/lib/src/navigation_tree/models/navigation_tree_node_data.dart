import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_core/src/navigation_tree/enums/navigation_node_type.dart';

class NavigationTreeNodeData {
  NavigationTreeNodeData({
    this.id,
    required this.name,
    required this.type,
    this.children = const <NavigationTreeNodeData>[],
    this.isInitiallyExpanded = true,
  }) {
    for (final child in children) {
      child.parent = this;
    }
  }

  final String? id;
  final String name;
  final NavigationNodeType type;
  final List<NavigationTreeNodeData> children;
  final bool isInitiallyExpanded;

  Widget get icon => type.icon;

  bool get isExpandable => type.isExpandable;

  bool get isSelectable => type.isSelectable;

  /// Used for navigation and matching hot reloaded elements with existing
  String get path {
    var path = name.replaceAll(' ', '-').toLowerCase();
    var current = parent;
    while (current?.parent != null) {
      path = '${current!.name.replaceAll(' ', '-').toLowerCase()}${'/$path'}';
      current = current.parent;
    }
    return path;
  }

  /// The Node hosting this element.
  NavigationTreeNodeData? parent;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is NavigationTreeNodeData &&
        other.id == id &&
        other.type == type &&
        other.name == name &&
        listEquals(other.children, children) &&
        other.isInitiallyExpanded == other.isInitiallyExpanded;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return 'NavigationTreeNodeData('
        'id: $id, '
        'name: $name, '
        'type: $type, '
        'children: $children, '
        'isInitiallyExpanded: $isInitiallyExpanded '
        ')';
  }
}
