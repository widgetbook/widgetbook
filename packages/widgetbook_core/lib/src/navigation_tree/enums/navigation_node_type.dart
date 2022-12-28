import 'package:flutter/material.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

enum NavigationNodeType {
  package,
  category,
  folder,
  component,
  useCase;

  static List<NavigationNodeType> get expandableTypes => [
        package,
        category,
        folder,
        component,
      ];

  static List<NavigationNodeType> get selectableTypes => [
        useCase,
      ];

  bool get isExpandable => expandableTypes.contains(this);

  bool get isSelectable => selectableTypes.contains(this);

  Widget get icon {
    switch (this) {
      case package:
        return const Icon(Icons.inventory, size: 16);
      case category:
        return const Icon(Icons.auto_awesome_mosaic, size: 16);
      case folder:
        return const Icon(Icons.folder, size: 16);
      case component:
        return const ComponentIcon();
      case useCase:
        return const UseCaseIcon();
    }
  }
}
