import 'package:flutter/material.dart';

abstract class NavigationEntity {
  NavigationEntity({
    required this.name,
    required this.icon,
    this.children,
    this.isInitiallyExpanded = true,
  }) {
    children?.forEach(
      (child) => child.parent = this,
    );
  }

  final String name;
  final Widget icon;
  final bool isInitiallyExpanded;
  final List<NavigationEntity>? children;
  NavigationEntity? parent;

  bool get isExpandable => children != null && children!.isNotEmpty;

  bool get isSelectable => children == null || children!.isEmpty;

  String get path => _pathOf(this).replaceAll(' ', '-').toLowerCase();

  String _pathOf(NavigationEntity entity) {
    return entity.parent == null
        ? entity.name
        : '${_pathOf(entity.parent!)}/${entity.name}';
  }

  NavigationEntity copyWith({
    required List<NavigationEntity> children,
  });
}
